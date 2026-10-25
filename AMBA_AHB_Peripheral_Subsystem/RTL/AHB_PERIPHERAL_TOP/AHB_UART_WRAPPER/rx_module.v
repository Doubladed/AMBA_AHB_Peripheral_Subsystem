module rx_module(
	
	input CLK,
	input RST_n,
	input Rxclk_en,
	input Rx,
	input rx_valid_clr,
	input [2:0] rx_byte_size,
	
	output reg [31:0] RXDATA,
	output reg rx_valid
);

parameter Rx_IDLE      = 3'd0;
parameter Rx_START     = 3'd1;
parameter Rx_DATA      = 3'd2;
parameter Rx_STOP      = 3'd3;
parameter Rx_NEXT_BYTE = 3'd4;

reg [2:0] STATE;
reg [2:0] Bit_Counter;
reg [1:0] Byte_Counter;
reg [7:0] Byte_Frame;
reg [3:0] Sample_Counter;

always @(posedge CLK or negedge RST_n) begin

	if(!RST_n) begin
	
		STATE <= Rx_IDLE;
		Bit_Counter <= 0;
		Byte_Counter <= 0;
		Sample_Counter <= 0;
		Byte_Frame <= 0;

		RXDATA <= 0;
		rx_valid <= 0;
	end
	else begin
		
		if(rx_valid_clr) begin
			rx_valid <= 0;
		end
		
		case(STATE)

		Rx_IDLE: begin
			Bit_Counter <= 0;
			Sample_Counter <= 0;

			if(Rx == 0 && rx_byte_size != 0) begin
				STATE <= Rx_START;
			end
		end

		Rx_START: begin
			if(Rxclk_en) begin
				if(Sample_Counter == 4'd7) begin
					Sample_Counter <= 0;

					if(Rx == 0) begin
						STATE <= Rx_DATA;
					end
					else begin
						STATE <= Rx_IDLE;
					end
				end
				else begin
					Sample_Counter <= Sample_Counter + 1;
				end
			end
		end 

		Rx_DATA: begin
			if(Rxclk_en) begin
				if(Sample_Counter == 4'd15) begin
					Sample_Counter <= 0;
					Byte_Frame[Bit_Counter] <= Rx;

					if(Bit_Counter == 3'd7) begin
						Bit_Counter <= 0;
						STATE <= Rx_STOP;
					end
					else begin
						Bit_Counter <= Bit_Counter + 1;
					end
				end
				else begin
					Sample_Counter <= Sample_Counter + 1;
				end
			end
		end 

		Rx_STOP: begin
			if(Rxclk_en) begin
				if(Sample_Counter == 4'd15) begin
					Sample_Counter <= 0;

					if(Rx == 1) begin
						STATE <= Rx_NEXT_BYTE;
					end
					else begin
						STATE <= Rx_IDLE;
					end
				end
				else begin
					Sample_Counter <= Sample_Counter + 1;
				end
			end
		end 

		Rx_NEXT_BYTE: begin
			case(Byte_Counter)
			2'b00: RXDATA[7:0]   <= Byte_Frame;
			2'b01: RXDATA[15:8]  <= Byte_Frame;
			2'b10: RXDATA[23:16] <= Byte_Frame;
			2'b11: RXDATA[31:24] <= Byte_Frame;
			default: RXDATA[7:0] <= Byte_Frame;
			endcase

			if(Byte_Counter == rx_byte_size - 1) begin
				Byte_Counter <= 0;
				rx_valid <= 1;
				STATE <= Rx_IDLE;
			end
			else begin
				Byte_Counter <= Byte_Counter + 1;
				STATE <= Rx_IDLE;
			end
		end

		default: begin
			STATE <= Rx_IDLE;
		end

		endcase
	end
end

endmodule
