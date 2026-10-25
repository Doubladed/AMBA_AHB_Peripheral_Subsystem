module ahb_uart_sub(

	input HCLK,
	input HRESETn,

	input [31:0] HADDR,
	input [31:0] HWDATA,
	input [3:0] HWSTRB,
	input HWRITE,

	input HSEL,
	input [1:0] HTRANS,
	input HREADY,

	output reg [31:0] HRDATA,
	output reg HREADYOUT,

	// Slave Input
	input [31:0] sl_rdata,

        output reg [31:0] sl_addr,
        output reg [31:0] sl_wdata,
        output reg [3:0] sl_wstrb,
        output reg sl_write,

	output reg valid_trans	
);

reg [31:0] addr_reg;
reg [3:0] wstrb_reg;
reg write_reg;
reg sel_reg;
reg [1:0] trans_reg;

parameter READ_WAIT_NUM = 2'd3;

reg READ_WAIT;
reg [1:0] read_wait_counter;

always @(posedge HCLK or negedge HRESETn) begin

	if (!HRESETn) begin

		HREADYOUT <= 1'b1;
		HRDATA <= 32'h0000_0000;

		READ_WAIT <= 1'b0;
		read_wait_counter <= 2'd0;

		sl_addr <= 32'h0000_0000;
		sl_wdata <= 32'h0000_0000;
		sl_wstrb <= 4'b0000;
		sl_write <= 1'b0;
		valid_trans <= 1'b0;

		addr_reg <= 32'h0000_0000;
		wstrb_reg <= 4'b0000;
		write_reg <= 1'b0;
		sel_reg <= 1'b0;
		trans_reg <= 2'b00;
	end
	else begin

		if (READ_WAIT) begin

			sl_addr     <= addr_reg;
			sl_wstrb    <= wstrb_reg;
			sl_write    <= write_reg;
			valid_trans <= sel_reg && trans_reg[1];

			if (read_wait_counter == READ_WAIT_NUM) begin

				HREADYOUT       <= 1'b1;
				READ_WAIT       <= 1'b0;
				read_wait_counter <= 0;

				HRDATA <= sl_rdata;
			end
			else begin

				HREADYOUT       <= 1'b0;
				read_wait_counter <= read_wait_counter + 1;
			end
		end
		else if (HREADY) begin

			addr_reg <= HADDR;
			sl_addr  <= addr_reg;

			wstrb_reg <= HWSTRB;
			sl_wstrb  <= wstrb_reg;

			write_reg <= HWRITE;
			sl_write  <= write_reg;

			sel_reg   <= HSEL;
			trans_reg <= HTRANS;

			valid_trans <= sel_reg && trans_reg[1];

			sl_wdata <= HWDATA;

			if (HSEL && HTRANS[1] && !HWRITE) begin
			
				HREADYOUT <= 1'b0;
				READ_WAIT <= 1'b1;
				read_wait_counter <= 2'd0;
			end
			else begin

				HREADYOUT <= 1'b1;
			end
		end
	end
end

endmodule
