`timescale 1ns/1ps

module tb_sram_sram;

	logic HCLK;
	logic HRESETn;

	logic [31:0] HRDATA;
	logic HREADY;

	logic [31:0] HADDR;
	logic [31:0] HWDATA;
	logic [3:0] HWSTRB;
	logic HWRITE;
	logic [1:0] HTRANS;

	// Testbench Stimulus
	logic [31:0] tb_addr;
	logic [31:0] tb_wdata;
	logic [3:0] tb_wstrb;
	logic tb_write;
	logic [1:0] tb_trans;

	logic [31:0] tb_rdata;

	// UART Loopback
	logic UART_Rx;
	logic UART_Tx;

	// SPI EEPROM Interface
	logic SPI_MOSI;
	wire SPI_MISO;
	logic SPI_SCK;
	logic [3:0] SPI_CS_n;

	// I2C RTCC Interface
	tri I2C_SDA;
	tri I2C_SCL;

assign UART_Rx = UART_Tx;

pullup(I2C_SDA);
pullup(I2C_SCL);

ahb_bfm AHB_BFM(

	.HCLK(HCLK),
	.HRESETn(HRESETn),

	.HRDATA(HRDATA),
	.HREADY(HREADY),

	.HADDR(HADDR),
	.HWDATA(HWDATA),
	.HWSTRB(HWSTRB),
	.HWRITE(HWRITE),
	.HTRANS(HTRANS),

	.tb_addr(tb_addr),
	.tb_wdata(tb_wdata),
	.tb_wstrb(tb_wstrb),
	.tb_write(tb_write),
	.tb_trans(tb_trans),

	.tb_rdata(tb_rdata)
);

ahb_peripheral_top DUT(

	.HCLK(HCLK),
	.HRESETn(HRESETn),

	.HADDR(HADDR),
	.HWDATA(HWDATA),
	.HWSTRB(HWSTRB),
	.HWRITE(HWRITE),
	.HTRANS(HTRANS),

	.HRDATA(HRDATA),
	.HREADY(HREADY),

	.UART_Rx(UART_Rx),
	.UART_Tx(UART_Tx),

	.SPI_MOSI(SPI_MOSI),
	.SPI_MISO(SPI_MISO),
	.SPI_SCK(SPI_SCK),
	.SPI_CS_n(SPI_CS_n),

	.I2C_SDA(I2C_SDA),
	.I2C_SCL(I2C_SCL)
);

M25AA256 SPI_EEPROM(

	.SI(SPI_MOSI),
	.SO(SPI_MISO),
	.SCK(SPI_SCK),
	.CS_N(SPI_CS_n[0]),
	.WP_N(1'b1),
	.HOLD_N(1'b1),
	.RESET(~HRESETn)
);

MB85RS256B SPI_FERAM(

	.CS_X(SPI_CS_n[1]),
	.SCK(SPI_SCK),
	.SI(SPI_MOSI),
	.SO(SPI_MISO),
	.WP_X(1'b1),
	.HOLD_X(1'b1),
	.VDD(1'b1),
	.VSS(1'b0)
);

MCP7940M I2C_RTCC(

	.X1(1'b0),
	.X2(),
	.MFP(),
	.SDA(I2C_SDA),
	.SCL(I2C_SCL),
	.VCC(1'b1),
	.RESET(~HRESETn)
);

M24AA256 I2C_EEPROM(

	.A0(1'b0),
	.A1(1'b0),
	.A2(1'b0),
	.WP(1'b0),
	.SDA(I2C_SDA),
	.SCL(I2C_SCL),
	.RESET(~HRESETn)
);

initial begin

	$vcdpluson;
end

initial begin

	HCLK = 0;
	forever #5 HCLK = ~HCLK;
end

initial begin

	HRESETn = 1'b0;

	tb_addr  = 32'h0000_0000;
	tb_wdata = 32'h0000_0000;
	tb_wstrb = 4'b0000;
	tb_write = 1'b0;
	tb_trans = 2'b00;

	repeat (100) @(posedge HCLK);

	@(negedge HCLK);
	HRESETn = 1'b1;

	repeat (100) @(posedge HCLK);

	@(negedge HCLK);

	// WRITE A1 / D1
	tb_addr  = 32'h0000_00A1;
	tb_wdata = 32'hd1d1_d1d1;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE A2
	tb_addr  = 32'h0000_00A2;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;
	tb_wdata = 32'hd2d2_d2d2;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE A3
	tb_addr  = 32'h0000_00A3;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;
	tb_wdata = 32'hd3d3_d3d3;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE A4
	tb_addr  = 32'h0000_00A4;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;
	tb_wdata = 32'hd4d4_d4d4;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// READ A1
	tb_addr  = 32'h0000_00A1;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold until READ A1 finishes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	// READ A2
	tb_addr  = 32'h0000_00A2;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold until READ A2 finishes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	// READ A3
	tb_addr  = 32'h0000_00A3;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold until READ A3 finishes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	// READ A4
	tb_addr  = 32'h0000_00A4;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold until READ A4 finishes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	// IDLE
	tb_addr  = 32'h0000_0000;
	tb_wdata = 32'h0000_0000;
	tb_wstrb = 4'b0000;
	tb_write = 1'b0;
	tb_trans = 2'b00;

	#1000;
	$finish;
end

endmodule
