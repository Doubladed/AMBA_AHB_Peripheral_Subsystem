module ahb_spi_wrapper(

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

	output MOSI,
	input MISO,
	output SCK,
	output [3:0] CS_n
);

wire [31:0] sl_addr;
wire [31:0] sl_wdata;
wire [3:0]  sl_wstrb;
wire        sl_write;
wire        valid_trans;
wire [31:0] sl_rdata;

wire        spi_start;
wire [31:0] tx_data;
wire [31:0] rx_data;
wire [2:0]  tx_byte_size;
wire [2:0]  rx_byte_size;
wire [1:0]  slave_select;
wire        busy;
wire        done;
wire        error;

ahb_spi_sub AHB_SPI_SUB(

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

spi_reg SPI_REG(

	.CLK          (HCLK),
	.RST_n        (HRESETn),
	.sl_addr      (sl_addr),
	.sl_wdata     (sl_wdata),
	.sl_wstrb     (sl_wstrb),
	.sl_write     (sl_write),
	.valid_trans  (valid_trans),
	.sl_rdata     (sl_rdata),
	.spi_start    (spi_start),
	.tx_data      (tx_data),
	.rx_data      (rx_data),
	.tx_byte_size (tx_byte_size),
	.rx_byte_size (rx_byte_size),
	.slave_select (slave_select),
	.busy         (busy),
	.done         (done),
	.error        (error)
);

spi_controller SPI_CONTROLLER(

	.CLK          (HCLK),
	.RST_n        (HRESETn),
	.spi_start    (spi_start),
	.tx_data      (tx_data),
	.rx_data      (rx_data),
	.tx_byte_size (tx_byte_size),
	.rx_byte_size (rx_byte_size),
	.slave_select (slave_select),
	.busy         (busy),
	.done         (done),
	.error        (error),
	.MOSI         (MOSI),
	.MISO         (MISO),
	.SCK          (SCK),
	.CS_n         (CS_n)
);

endmodule
