module ahb_peripheral_top(

	input HCLK,
	input HRESETn,

	input [31:0] HADDR,
	input [31:0] HWDATA,
	input [3:0] HWSTRB,
	input HWRITE,
	input [1:0] HTRANS,

	output [31:0] HRDATA,
	output HREADY,

	input UART_Rx,
	output UART_Tx,

	output SPI_MOSI,
	input SPI_MISO,
	output SPI_SCK,
	output [3:0] SPI_CS_n,

	inout I2C_SDA,
	inout I2C_SCL
);

wire sram_sel;
wire uart_sel;
wire spi_sel;
wire i2c_sel;

wire [31:0] sram_rdata;
wire [31:0] uart_rdata;
wire [31:0] spi_rdata;
wire [31:0] i2c_rdata;

wire sram_readyout;
wire uart_readyout;
wire spi_readyout;
wire i2c_readyout;

ahb_decmux AHB_DECMUX(

	.HCLK         (HCLK),
	.HRESETn      (HRESETn),
	.HADDR        (HADDR),
	.HSEL_S0      (sram_sel),
	.HSEL_S1      (uart_sel),
	.HSEL_S2      (spi_sel),
	.HSEL_S3      (i2c_sel),
	.HRDATA_S0    (sram_rdata),
	.HRDATA_S1    (uart_rdata),
	.HRDATA_S2    (spi_rdata),
	.HRDATA_S3    (i2c_rdata),
	.HREADYOUT_S0 (sram_readyout),
	.HREADYOUT_S1 (uart_readyout),
	.HREADYOUT_S2 (spi_readyout),
	.HREADYOUT_S3 (i2c_readyout),
	.HRDATA       (HRDATA),
	.HREADY       (HREADY)
);

ahb_sram_wrapper AHB_SRAM_WRAPPER(

	.HCLK      (HCLK),
	.HRESETn   (HRESETn),
	.HADDR     (HADDR),
	.HWDATA    (HWDATA),
	.HWSTRB    (HWSTRB),
	.HWRITE    (HWRITE),
	.HSEL      (sram_sel),
	.HTRANS    (HTRANS),
	.HREADY    (HREADY),
	.HRDATA    (sram_rdata),
	.HREADYOUT (sram_readyout)
);

ahb_uart_wrapper AHB_UART_WRAPPER(

	.HCLK      (HCLK),
	.HRESETn   (HRESETn),
	.HADDR     (HADDR),
	.HWDATA    (HWDATA),
	.HWSTRB    (HWSTRB),
	.HWRITE    (HWRITE),
	.HSEL      (uart_sel),
	.HTRANS    (HTRANS),
	.HREADY    (HREADY),
	.HRDATA    (uart_rdata),
	.HREADYOUT (uart_readyout),
	.Rx        (UART_Rx),
	.Tx        (UART_Tx)
);

ahb_spi_wrapper AHB_SPI_WRAPPER(

	.HCLK      (HCLK),
	.HRESETn   (HRESETn),
	.HADDR     (HADDR),
	.HWDATA    (HWDATA),
	.HWSTRB    (HWSTRB),
	.HWRITE    (HWRITE),
	.HSEL      (spi_sel),
	.HTRANS    (HTRANS),
	.HREADY    (HREADY),
	.HRDATA    (spi_rdata),
	.HREADYOUT (spi_readyout),
	.MOSI      (SPI_MOSI),
	.MISO      (SPI_MISO),
	.SCK       (SPI_SCK),
	.CS_n      (SPI_CS_n)
);

ahb_i2c_wrapper AHB_I2C_WRAPPER(

	.HCLK      (HCLK),
	.HRESETn   (HRESETn),
	.HADDR     (HADDR),
	.HWDATA    (HWDATA),
	.HWSTRB    (HWSTRB),
	.HWRITE    (HWRITE),
	.HSEL      (i2c_sel),
	.HTRANS    (HTRANS),
	.HREADY    (HREADY),
	.HRDATA    (i2c_rdata),
	.HREADYOUT (i2c_readyout),
	.SDA       (I2C_SDA),
	.SCL       (I2C_SCL)
);

endmodule
