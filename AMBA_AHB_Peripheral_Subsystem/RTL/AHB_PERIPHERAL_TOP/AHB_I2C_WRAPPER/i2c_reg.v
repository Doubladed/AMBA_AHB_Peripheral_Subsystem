module i2c_reg(

	input CLK,
	input RST_n,

	// Slave Input
	input [31:0] sl_addr,
	input [31:0] sl_wdata,
	input [3:0] sl_wstrb,
	input sl_write,

	input valid_trans,
	output reg [31:0] sl_rdata,

	// I2C Input
	output reg i2c_start,

	output reg [31:0] tx_data,
	input [31:0] rx_data,

	output reg [2:0] tx_byte_size,
	output reg [2:0] rx_byte_size,

	input busy,
	input done,
	input error
);

parameter TX_REG = 4'h0;
parameter RX_REG = 4'h4;
parameter STATUS_REG = 4'h8;
parameter CONTROL_REG = 4'hc;

always @(posedge CLK or negedge RST_n) begin

	if (!RST_n) begin

		sl_rdata <= 32'h0000_0000;
		i2c_start <= 1'b0;	

		tx_data <= 32'h0000_0000;
		tx_byte_size <= 3'b000;
		rx_byte_size <= 3'b000;
	end
	else begin

		i2c_start <= 1'b0; // Ensure that i2c_start will become a pulse instead of having to send another i2c_start = 1'b0 signal
	
		if (valid_trans) begin

			if (sl_write && (sl_wstrb == 4'b1111)) begin

				case(sl_addr[3:0])

					TX_REG: begin
						
						tx_data <= sl_wdata;
					end
					CONTROL_REG: begin

						i2c_start <= sl_wdata[0];
						tx_byte_size <= sl_wdata[3:1];
						rx_byte_size <= sl_wdata[6:4];
					end
				endcase
			end
			else if (sl_write == 1'b0) begin

				case(sl_addr[3:0])

					TX_REG: begin

						sl_rdata <= tx_data;
					end
					RX_REG: begin

						sl_rdata <= rx_data;
					end	
					STATUS_REG: begin

						sl_rdata <= {29'b0, error, done, busy};
					end
					CONTROL_REG: begin

						sl_rdata <= {25'b0, rx_byte_size, tx_byte_size, i2c_start};
					end
					default: begin

						sl_rdata <= 32'h0000_0000;
					end
				endcase
			end
		end
	end
end

endmodule
