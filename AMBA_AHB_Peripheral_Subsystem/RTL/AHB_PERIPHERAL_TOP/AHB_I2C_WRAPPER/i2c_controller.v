// Standard Mode I2C Controller
module i2c_controller(

	input CLK,
	input RST_n,

	input i2c_start,

	input [31:0] tx_data,
	output reg [31:0] rx_data,

	input [2:0] tx_byte_size,
	input [2:0] rx_byte_size,

	output busy,
	output reg done,
	output reg error,

	inout SDA,
	inout SCL
);

parameter IDLE = 0;
parameter START = 1;
parameter WRITE_BYTE = 2;
parameter RECEIVE_ACK = 3;
parameter TX_NEXT_BYTE = 4;
parameter READ_BYTE = 5;
parameter SEND_ACK = 6;
parameter RX_NEXT_BYTE = 7;
parameter STOP = 8;
parameter BUS_FREE = 9;

parameter SCL_LOW = 0;
parameter SCL_HIGH = 1;

reg [3:0] STATE;
reg SUBSTATE;

// CLK = 100MHZ, I2C Controller CLK, SCL = 100KHZ
// Full-Cycle = 100M/100K = 1000, Half-Cycle = 1000/2 = 500

parameter T_HIGH = 500;
parameter T_LOW = 500;

// Start Hold: SCL must be stable before SDA can change
// CLK: 100MHZ = 10ns
// 4000ns/10ns = 400

parameter T_HD_STA = 400;

// Data Hold: SCL must be stable before SDA can change
// Hold Time: 600000ps = 600ns
// 600ns/10ns = 60

parameter T_HD_DAT = 60;

// Bus Free: Bus must be free for 4700ns before transitioning back to START state from STOP state
// 4700ns/10ns = 470

parameter T_BUF = 470;

reg SDA_PULLDOWN;
reg SCL_PULLDOWN;

reg [8:0] scl_counter;
reg [2:0] bit_counter;

reg [2:0] tx_size;
reg [2:0] rx_size; 
 
reg [1:0] tx_counter; 
reg [1:0] rx_counter;

reg [31:0] tx_shift;

reg [7:0] tx_byte;
reg [7:0] rx_byte;

reg rw_mode;
reg read_mode_start;

assign SDA = SDA_PULLDOWN ? 1'b0 : 1'bz;
assign SCL = SCL_PULLDOWN ? 1'b0 : 1'bz;

assign busy = (STATE != IDLE);

always @(posedge CLK or negedge RST_n) begin

	if (!RST_n) begin

		STATE <= IDLE;
		SUBSTATE <= SCL_LOW;

		SDA_PULLDOWN <= 1'b0;
		SCL_PULLDOWN <= 1'b0;

		scl_counter <= 9'b0;
		bit_counter <= 3'b0;

		tx_size <= 3'd0;
		rx_size <= 3'd0;

		tx_counter <= 2'd0;
		rx_counter <= 2'd0;

		tx_shift <= 32'd0;

		tx_byte <= 8'd0;
		rx_byte <= 8'd0;

		rw_mode <= 1'b0;
		read_mode_start <= 1'b0;

		rx_data <= 32'h0000_0000;

		done <= 1'b0;
		error <= 1'b0;
	end
	else begin
	
		case(STATE)
			
			IDLE: begin
				
				SDA_PULLDOWN <= 1'b0;
				SCL_PULLDOWN <= 1'b0;

				scl_counter <= 9'd0;
				bit_counter <= 3'd0;

				tx_counter <= 2'd0;
				rx_counter <= 2'd0;

				if (i2c_start) begin

					done <= 1'b0;
					error <= 1'b0;

					tx_size <= tx_byte_size;
					rx_size <= rx_byte_size;

					tx_shift <= tx_data;

					if (tx_data[24] == 1) begin
					
						tx_byte <= {tx_data[31:25], 1'b0};
					end
					else begin

						tx_byte <= tx_data[31:24];
					end
					
					rx_byte <= 8'b0;
					rx_data <= 32'b0;

					rw_mode <= tx_data[24];
					read_mode_start <= 1'b0;

					STATE <= START;
					SUBSTATE <= SCL_LOW;
				end
			end
			START: begin

				case(SUBSTATE)

					SCL_LOW: begin

						SCL_PULLDOWN <= 1'b1;
						SDA_PULLDOWN <= 1'b0;

						if (scl_counter == T_LOW - 1) begin

							scl_counter <= 0;
							SUBSTATE <= SCL_HIGH;
						end
						else begin
							
							scl_counter <= scl_counter + 1;
						end	
					end
					SCL_HIGH: begin

						SCL_PULLDOWN <= 1'b0;

						if (scl_counter == T_HD_STA - 1) begin

							SDA_PULLDOWN <= 1'b1;
						end

						if (scl_counter == T_HIGH - 1) begin

							scl_counter <= 0;
							bit_counter <= 7;

							SUBSTATE <= SCL_LOW;
							STATE <= WRITE_BYTE;	
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
				endcase
			end
			WRITE_BYTE: begin

				case(SUBSTATE)

					SCL_LOW: begin

						SCL_PULLDOWN <= 1'b1; 

						if (scl_counter == T_HD_DAT - 1) begin
						
							SDA_PULLDOWN <= ~tx_byte[bit_counter];
						end

						if (scl_counter == T_LOW - 1) begin
							
							scl_counter <= 0;
							SUBSTATE <= SCL_HIGH;
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
					SCL_HIGH: begin

						SCL_PULLDOWN <= 1'b0;

						if (scl_counter == T_HIGH - 1) begin

							scl_counter <= 0;
							SUBSTATE <= SCL_LOW;

							if (bit_counter == 0) begin

								STATE <= RECEIVE_ACK;
							end
							else begin

								bit_counter <= bit_counter - 1;
							end
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
				endcase
			end
			RECEIVE_ACK: begin 

				case(SUBSTATE) 
					
					SCL_LOW: begin 

						SCL_PULLDOWN <= 1'b1; 
						SDA_PULLDOWN <= 1'b0; 

						if (scl_counter == T_LOW - 1) begin 

							scl_counter <= 0; 
							SUBSTATE <= SCL_HIGH; 
						end 
						else begin 

							scl_counter <= scl_counter + 1; 
						end 
					end 
					SCL_HIGH: begin

						SCL_PULLDOWN <= 1'b0; 

						if (scl_counter == T_HIGH - 1) begin 

							scl_counter <= 0; 
							SUBSTATE <= SCL_LOW; 

							if (SDA == 1'b0) begin 

								STATE <= TX_NEXT_BYTE; 
								$display("========== Slave-to-I2C Controller (%d): Slave ACK! ==========", tx_counter); 
							end 
							else begin 

								STATE <= STOP; 
								error <= 1'b1; 
								$display("========== Slave-to-I2C Controller (%d): Slave NACK! ==========", tx_counter); 
							end 
						end 
						else begin 

							scl_counter <= scl_counter + 1; 
						end 
					end 
				endcase 
			end
			TX_NEXT_BYTE: begin

				SCL_PULLDOWN <= 1'b1;
				SDA_PULLDOWN <= 1'b0;

				bit_counter <= 7;

				if (read_mode_start) begin

					STATE <= READ_BYTE;
				end
				else if (tx_counter == tx_size - 1) begin

					if (rw_mode == 1'b1) begin

						read_mode_start <= 1'b1;
						tx_byte <= {tx_shift[31:25], 1'b1};

						STATE <= START;
					end
					else begin

						STATE <= STOP;
					end
				end
				else begin

					tx_counter <= tx_counter + 1;
					STATE <= WRITE_BYTE;

					case(tx_counter)

						2'd0: tx_byte <= tx_shift[23:16]; 
						2'd1: tx_byte <= tx_shift[15:8];
						2'd2: tx_byte <= tx_shift[7:0];
					endcase
				end
			end
			READ_BYTE: begin

				case(SUBSTATE)

					SCL_LOW: begin

						SCL_PULLDOWN <= 1'b1;
						SDA_PULLDOWN <= 1'b0;

						if (scl_counter == T_LOW - 1) begin

							scl_counter <= 0;
							SUBSTATE <= SCL_HIGH;
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
					SCL_HIGH: begin

						SCL_PULLDOWN <= 1'b0;
						rx_byte[bit_counter] <= SDA;

						if (scl_counter == T_HIGH - 1) begin

							scl_counter <= 0;
							SUBSTATE <= SCL_LOW;

							if (bit_counter == 0) begin

								STATE <= SEND_ACK;
							end
							else begin

								bit_counter <= bit_counter - 1;
							end
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
				endcase
			end
			SEND_ACK: begin

				case(SUBSTATE)

					SCL_LOW: begin

						SCL_PULLDOWN <= 1'b1;

						if (scl_counter == T_HD_DAT - 1) begin
						
							if (rx_counter == rx_size - 1) begin

								SDA_PULLDOWN <= 1'b0;
							end
							else begin

								SDA_PULLDOWN <= 1'b1;
							end
						end

						if (scl_counter == T_LOW - 1) begin							

							scl_counter <= 0;
							SUBSTATE <= SCL_HIGH;
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
					SCL_HIGH: begin

						SCL_PULLDOWN <= 1'b0;

						if (scl_counter == T_HIGH - 1) begin

							scl_counter <= 0;
							SUBSTATE <= SCL_LOW;
							
							STATE <= RX_NEXT_BYTE;
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
				endcase
			end
			RX_NEXT_BYTE: begin

				SCL_PULLDOWN <= 1'b1;
				SDA_PULLDOWN <= 1'b0;

				bit_counter <= 7;

				case(rx_counter)

					2'd0: rx_data[31:24] <= rx_byte;
					2'd1: rx_data[23:16] <= rx_byte;
					2'd2: rx_data[15:8] <= rx_byte;
					2'd3: rx_data[7:0] <= rx_byte;
				endcase

				if (rx_counter == rx_size - 1) begin

					STATE <= STOP;
				end
				else begin

					rx_counter <= rx_counter + 1;
					STATE <= READ_BYTE;
				end
			end
			STOP: begin

				case(SUBSTATE)

					SCL_LOW: begin

						SCL_PULLDOWN <= 1'b1;

						if (scl_counter == T_HD_DAT - 1) begin						
						
							SDA_PULLDOWN <= 1'b1;
						end
						
						if (scl_counter == T_LOW - 1) begin

							scl_counter <= 0;
							SUBSTATE <= SCL_HIGH;
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
					SCL_HIGH: begin

						SCL_PULLDOWN <= 1'b0;

						if (scl_counter == T_HIGH - 1) begin

							SDA_PULLDOWN <= 1'b0;

							scl_counter <= 0;
							SUBSTATE <= SCL_LOW;

							STATE <= BUS_FREE;
						end
						else begin

							scl_counter <= scl_counter + 1;
						end
					end
				endcase
			end
			BUS_FREE: begin

				SCL_PULLDOWN <= 1'b0;
				SDA_PULLDOWN <= 1'b0;

				if (scl_counter == T_BUF - 1) begin

					scl_counter <= 0;

					STATE <= IDLE;
					done <= 1'b1;
				end
				else begin

					scl_counter <= scl_counter + 1;
				end
			end
		endcase	
	end
end

endmodule
