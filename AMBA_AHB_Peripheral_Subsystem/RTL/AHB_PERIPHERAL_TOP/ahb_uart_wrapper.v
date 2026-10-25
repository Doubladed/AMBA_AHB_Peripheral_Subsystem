module ahb_uart_wrapper(

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
	output HREADYOUT,

	input Rx,
	output Tx
);

wire [31:0] sl_addr;
wire [31:0] sl_wdata;
wire [3:0]  sl_wstrb;
wire        sl_write;
wire        valid_trans;
wire [31:0] sl_rdata;

wire        tx_start;
wire [31:0] tx_data;
wire [2:0]  tx_byte_size;
wire [2:0]  rx_byte_size;
wire [31:0] rx_data;
wire        tx_busy;
wire        rx_valid;
wire        rx_valid_clr;

ahb_uart_sub AHB_UART_SUB(

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

uart_reg UART_REG(

	.CLK          (HCLK),
	.RST_n        (HRESETn),
	.sl_addr      (sl_addr),
	.sl_wdata     (sl_wdata),
	.sl_wstrb     (sl_wstrb),
	.sl_write     (sl_write),
	.valid_trans  (valid_trans),
	.sl_rdata     (sl_rdata),
	.tx_start     (tx_start),
	.tx_data      (tx_data),
	.tx_byte_size (tx_byte_size),
	.rx_byte_size (rx_byte_size),
	.rx_data      (rx_data),
	.tx_busy      (tx_busy),
	.rx_valid     (rx_valid),
	.rx_valid_clr (rx_valid_clr)
);

uart_controller UART_CONTROLLER(
	.CLK          (HCLK),
	.RST_n        (HRESETn),
	.tx_start     (tx_start),
	.TXDATA       (tx_data),
	.tx_byte_size (tx_byte_size),
	.Rx           (Rx),
	.rx_valid_clr (rx_valid_clr),
	.rx_byte_size (rx_byte_size),
	.Tx           (Tx),
	.tx_busy      (tx_busy),
	.RXDATA       (rx_data),
	.rx_valid     (rx_valid)
);

endmodule
