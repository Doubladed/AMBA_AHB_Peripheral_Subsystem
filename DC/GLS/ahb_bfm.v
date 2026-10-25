module ahb_bfm(

	input HCLK,
	input HRESETn,
	
	input [31:0] HRDATA,
	input HREADY,

	output reg [31:0] HADDR,
	output reg [31:0] HWDATA,
	output reg [3:0] HWSTRB,
	output reg HWRITE,
	output reg [1:0] HTRANS,

	// Testbench Stimulus
	input [31:0] tb_addr,
	input [31:0] tb_wdata,
	input [3:0] tb_wstrb,
	input tb_write,
	input [1:0] tb_trans,

	output reg [31:0] tb_rdata
);

reg [31:0] wdata_reg;

always @(posedge HCLK or negedge HRESETn) begin

	if (!HRESETn) begin

        	HADDR <= 32'h0000_0000;
        	HWDATA <= 32'h0000_0000;
        	HWSTRB <= 4'b0000;
       		HWRITE <= 1'b0;
		HTRANS <= 2'b00;

		wdata_reg <= 32'h0000_0000;
		tb_rdata  <= 32'h0000_0000;
	end
	else begin
	
		if (HREADY) begin

	                HADDR <= tb_addr;
                	HWSTRB <= tb_wstrb;
                	HWRITE <= tb_write;
			HTRANS <= tb_trans;

			wdata_reg <= tb_wdata;
			HWDATA <= wdata_reg;

			tb_rdata <= HRDATA;
		end
	end
end

endmodule
