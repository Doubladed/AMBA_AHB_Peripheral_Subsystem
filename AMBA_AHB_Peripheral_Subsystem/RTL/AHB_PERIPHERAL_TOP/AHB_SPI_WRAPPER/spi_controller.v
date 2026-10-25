module spi_controller(

	input CLK,
	input RST_n,

	input spi_start,

	input [31:0] tx_data,
	output reg [31:0] rx_data,

	input [2:0] tx_byte_size,
	input [2:0] rx_byte_size,

	input [1:0] slave_select,

	output busy,
	output reg done,
	output reg error,

	output reg MOSI,
	input MISO,
	
	output reg SCK,
	output reg [3:0] CS_n
);

parameter IDLE = 0;
parameter WRITE_BYTE = 1;
parameter READ_BYTE = 2;
parameter DONE = 3;

parameter SCK_RISE = 0;
parameter SCK_FALL = 1;

reg [1:0] STATE;
reg SUBSTATE;

// CLK = 100MHz -> 10ns per clock cycle

// From SPI EEPROM AC characteristics:
// Minimum SCK low time  (T_CL) = 1us
// Minimum SCK high time (T_CH) = 1us

// 1us = 1000ns
// 1000ns / 10ns = 100 CLK cycles

// T_LO = 100 cycles -> SCK low  = 1us
// T_HI = 100 cycles -> SCK high = 1us

// Full SCK period = T_LO + T_HI = 100 + 100 = 200 CLK cycles = 200 * 10ns = 2us

// SCK frequency = 1 / 2us = 500kHz

parameter T_LO = 100;
parameter T_HI = 100;

reg [6:0] sck_counter; // 100 - 1 = 99 -> 7 Bits
reg [2:0] bit_counter; // 8 - 1 = 7 -> 3 Bits

reg [2:0] tx_size; // 0 to 4 bytes -> needs 3 Bits
reg [2:0] rx_size; // 0 to 4 bytes -> needs 3 Bits
 
reg [1:0] tx_counter; // 4 - 1 = 3 -> 2 Bits 
reg [1:0] rx_counter; // 4 - 1 = 3 -> 2 Bits

reg [31:0] tx_shift;

reg [7:0] tx_byte;
reg [7:0] rx_byte;

assign busy = (STATE != IDLE);

always @(posedge CLK or negedge RST_n) begin

	if (!RST_n) begin
    
		done <= 1'b0;
		error <= 1'b0;

		SCK <= 1'b0;
		CS_n <= 4'b1111;

		STATE <= IDLE;
		SUBSTATE <= SCK_RISE;

		sck_counter <= 7'd0; 
		bit_counter <= 3'd0; 

		tx_size <= 3'd0;
		rx_size <= 3'd0;

		tx_counter <= 2'd0;
		rx_counter <= 2'd0;

		tx_shift <= 32'd0;
		tx_byte <= 8'd0;

		rx_byte <= 8'd0;
		rx_data <= 32'd0;

		MOSI <= 1'd0;
	end
	else begin

		case(STATE)

			IDLE: begin

				SCK <= 1'b0;
				SUBSTATE <= SCK_RISE;

				CS_n <= 4'b1111;

				sck_counter <= 7'd0;
				bit_counter <= 3'd7;

				tx_counter <= 2'd0;
				rx_counter <= 2'd0;

				if (spi_start) begin

					done <= 1'b0;
					error <= 1'b0;

					case (slave_select)

						2'd0: CS_n <= 4'b1110;
						2'd1: CS_n <= 4'b1101;
						2'd2: CS_n <= 4'b1011;
						2'd3: CS_n <= 4'b0111;
					endcase

					tx_size <= tx_byte_size;
					rx_size <= rx_byte_size;

					tx_shift <= tx_data;
					tx_byte <= tx_data[31:24];

					rx_byte <= 8'd0;
					rx_data <= 32'd0;

					MOSI <= tx_data[31];

					STATE <= WRITE_BYTE;
				end
			end
			WRITE_BYTE: begin

				case(SUBSTATE)
					
					SCK_RISE: begin

						if (sck_counter == T_LO - 1) begin

							sck_counter <= 0;
							SUBSTATE <= SCK_FALL;
							SCK <= 1;
						end
						else begin
						
							sck_counter <= sck_counter + 1;
						end
					end
					SCK_FALL: begin

                                                if (sck_counter == T_HI - 1) begin

                                                        sck_counter <= 0;
                                                        SUBSTATE <= SCK_RISE;
                                                        SCK <= 0;

							if (bit_counter == 0) begin

								bit_counter <= 7;
										
								if (tx_counter == tx_size - 1) begin
									
									tx_counter <= 0;

									if (rx_size == 0) begin				
										
										STATE <= DONE;
									end
									else begin
									
										STATE <= READ_BYTE;
									end
								end
								else begin

									tx_counter <= tx_counter + 1;
									
									case (tx_counter)

										2'd0: begin  
    
											tx_byte <= tx_shift[23:16];
											MOSI <= tx_shift[23];
										end
										2'd1: begin

											tx_byte <= tx_shift[15:8];
											MOSI <= tx_shift[15];
										end
										2'd2: begin

											tx_byte <= tx_shift[7:0];
											MOSI <= tx_shift[7];
										end                        
									endcase
								end
							end
							else begin

								bit_counter <= bit_counter - 1;
								MOSI <= tx_byte[bit_counter - 1];
							end
                                                end
                                                else begin

                                                        sck_counter <= sck_counter + 1;
                                                end
					end
				endcase
			end
			READ_BYTE: begin

				case(SUBSTATE)

					SCK_RISE: begin

						if (sck_counter == T_LO - 1) begin

							sck_counter <= 0;
							SUBSTATE <= SCK_FALL;
							SCK <= 1;

							rx_byte[bit_counter] <= MISO;
						end
						else begin

							sck_counter <= sck_counter + 1;
						end
					end

					SCK_FALL: begin

						if (sck_counter == T_HI - 1) begin

							sck_counter <= 0;
							SUBSTATE <= SCK_RISE;
							SCK <= 0;

							if (bit_counter == 0) begin

								bit_counter <= 7;

								case (rx_counter)

									2'd0: rx_data[31:24] <= rx_byte;
									2'd1: rx_data[23:16] <= rx_byte;
									2'd2: rx_data[15:8]  <= rx_byte;
									2'd3: rx_data[7:0]   <= rx_byte;

								endcase

								rx_byte <= 8'd0;

								if (rx_counter == rx_size - 1) begin

									rx_counter <= 0;
									STATE <= DONE;
								end
								else begin

									rx_counter <= rx_counter + 1;
								end
							end
							else begin

								bit_counter <= bit_counter - 1;
							end
						end
						else begin

							sck_counter <= sck_counter + 1;
						end
					end
				endcase
			end
			DONE: begin

				SCK <= 1'b0;
				CS_n <= 4'b1111;

				if (sck_counter == T_LO - 1) begin

					done <= 1'b1;
					error <= 1'b0;

					STATE <= IDLE;
					SUBSTATE <= SCK_RISE;
				end
				else begin

					sck_counter <= sck_counter + 1;
				end
			end
			default: begin

				STATE <= IDLE;
			end
		endcase
	end
end

endmodule
