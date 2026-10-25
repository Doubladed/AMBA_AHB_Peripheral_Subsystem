module ahb_sram_wrapper(

	input HCLK,
	input HRESETn,

	input [31:0] HADDR,
	input [31:0] HWDATA,
	input [3:0] HWSTRB,
	input HWRITE,

	input HSEL,
	input [1:0] HTRANS,
	input HREADY,

	output [31:0] HRDATA,
	output HREADYOUT
);

wire [31:0] sl_addr;
wire [31:0] sl_wdata;
wire [3:0]  sl_wstrb;
wire        sl_write;
wire        valid_trans;
wire [31:0] sl_rdata;

ahb_sram_sub AHB_SRAM_SUB(

	.HCLK        (HCLK),
	.HRESETn     (HRESETn),
	.HADDR       (HADDR),
	.HWDATA      (HWDATA),
	.HWSTRB      (HWSTRB),
	.HWRITE      (HWRITE),
	.HSEL        (HSEL),
	.HTRANS      (HTRANS),
	.HREADY      (HREADY),
	.HRDATA      (HRDATA),
	.HREADYOUT   (HREADYOUT),
	.sl_rdata    (sl_rdata),
	.sl_addr     (sl_addr),
	.sl_wdata    (sl_wdata),
	.sl_wstrb    (sl_wstrb),
	.sl_write    (sl_write),
	.valid_trans (valid_trans)
);

sram_controller SRAM_CONTROLLER(

	.HCLK        (HCLK),
	.HRESETn     (HRESETn),
	.sl_addr     (sl_addr),
	.sl_wdata    (sl_wdata),
	.sl_wstrb    (sl_wstrb),
	.sl_write    (sl_write),
	.valid_trans (valid_trans),
	.sl_rdata    (sl_rdata)
);

endmodule
