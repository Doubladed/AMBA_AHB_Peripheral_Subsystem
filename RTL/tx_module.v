module tx_module(

	input CLK,
	input RST_n,
	input Txclk_en,
	input tx_start,
	input [31:0] TXDATA,
	input [2:0] tx_byte_size,
	
	output reg Tx,
	output tx_busy
);

parameter Tx_IDLE = 3'd0;
parameter Tx_START = 3'd1;
parameter Tx_DATA = 3'd2;
parameter Tx_STOP = 3'd3;
parameter Tx_NEXT_BYTE = 3'd4; 

reg [2:0] STATE; // 5 States = 3 Bits
reg [2:0] Bit_Counter; // 8 Data = 3 Bits
reg [1:0] Byte_Counter; // 32/8 = 4 Frames = 2 Bits
reg [7:0] Byte_Frame; // 32 Bits = 8 Bits per Frame 

assign tx_busy = (STATE != Tx_IDLE);

always @(*) begin
	
	case(Byte_Counter)
	2'b00: Byte_Frame = TXDATA[7:0];
	2'b01: Byte_Frame = TXDATA[15:8];
	2'b10: Byte_Frame = TXDATA[23:16];
	2'b11: Byte_Frame = TXDATA[31:24];
	default: Byte_Frame = 8'b00; 
	endcase
end

always @(posedge CLK or negedge RST_n) begin

	if(!RST_n) begin

		STATE <= Tx_IDLE;
		Bit_Counter <= 3'b000;
		Byte_Counter <= 2'b00;

		Tx <= 1; // Since Tx sends '1' at IDLE state according to FSM 
	end
	else begin
		
		case(STATE)
		Tx_IDLE: begin
		
			Tx <= 1;

			if(tx_start && tx_byte_size != 0) begin

				STATE <= Tx_START;
				Bit_Counter <= 3'b000;
				Byte_Counter <= 2'b00;
			end	
		end
		Tx_START: begin
			
			if(Txclk_en) begin

				Tx <= 0;			
				STATE <= Tx_DATA;
			end
		end
		Tx_DATA: begin

			if(Txclk_en) begin
			
				Tx <= Byte_Frame[Bit_Counter];

				if(Bit_Counter == 3'b111) begin

					Bit_Counter <= 3'b000;
					STATE <= Tx_STOP;
				end
				else begin
					
					Bit_Counter <= Bit_Counter + 1;
				end
			end
		end
		Tx_STOP: begin
			
			if(Txclk_en) begin
				
				Tx <= 1;
				STATE <= Tx_NEXT_BYTE;
			end
		end
		Tx_NEXT_BYTE: begin

			if(Byte_Counter == tx_byte_size - 1) begin

				Byte_Counter <= 2'b00;
				STATE <= Tx_IDLE;
			end
			else begin
				
				Byte_Counter <= Byte_Counter + 1;
				STATE <= Tx_START;
			end
		end
		default: begin

			STATE <= Tx_IDLE;
			Bit_Counter <= 3'b000;
			Byte_Counter <= 2'b00;
			Tx <= 1;
		end
		endcase
	end
end

endmodule
