`timescale 1ns/1ps
// SRAM -> SPI EEPROM -> SRAM
module tb_spi_eeprom_sram;

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
	logic [7:0] sram_d1;

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

	sram_d1 = 8'h00;

	repeat (2) @(posedge HCLK);

	@(negedge HCLK);
	HRESETn = 1'b1;

	@(negedge HCLK);

	// WRITE D1 TO SRAM A1
	tb_addr  = 32'h0000_00A1;
	tb_wdata = 32'h0000_00d1;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// READ SRAM A1
	tb_addr  = 32'h0000_00A1;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold while SRAM A1 read completes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	sram_d1 = HRDATA[7:0];
	$display("Data read from SRAM A1 = %h", HRDATA);

	// STEP 1: Send WREN signal to EEPROM

	// WRITE to SPI TX REG
	tb_addr  = 32'h3000_0000;
	tb_wdata = 32'h0600_0000;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE to SPI CONTROL REG
	tb_addr  = 32'h3000_000c;
	tb_wdata = {23'b0, 2'd0, 3'd0, 3'd1, 1'b1}; // {23'b0, slave_select, rx_byte_size, tx_byte_size, spi_start}
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// Poll SPI STATUS REG until DONE
	do begin

		// READ SPI STATUS REG
		tb_addr  = 32'h3000_0008;
		tb_wstrb = 4'b1111;
		tb_write = 1'b0;
		tb_trans = 2'b10;

		@(posedge HCLK);
		while (!HREADY) @(posedge HCLK);
		@(negedge HCLK);

		tb_trans = 2'b00;

		// Hold while STATUS read completes
		while (HREADY) @(negedge HCLK);
		while (!HREADY) @(negedge HCLK);
	end
	while (HRDATA !== {29'b0, 1'b0, 1'b1, 1'b0}); // {29'b0, error, done, busy}

	// STEP 2: Write SRAM D1 to EEPROM address 16'h7FF0

	// WRITE to SPI TX REG: {WRITE command, EEPROM address, SRAM D1}
	tb_addr  = 32'h3000_0000;
	tb_wdata = {8'h02, 16'h7ff0, sram_d1};
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;
	$display("SPI EEPROM WRITE DATA = %h", {8'h02, 16'h7ff0, sram_d1});

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE to SPI CONTROL REG
	tb_addr  = 32'h3000_000c;
	tb_wdata = {23'b0, 2'd0, 3'd0, 3'd4, 1'b1}; // {23'b0, slave_select, rx_byte_size, tx_byte_size, spi_start}
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// Poll SPI STATUS REG until DONE
	do begin

		// READ SPI STATUS REG
		tb_addr  = 32'h3000_0008;
		tb_wstrb = 4'b1111;
		tb_write = 1'b0;
		tb_trans = 2'b10;

		@(posedge HCLK);
		while (!HREADY) @(posedge HCLK);
		@(negedge HCLK);

		tb_trans = 2'b00;

		// Hold while STATUS read completes
		while (HREADY) @(negedge HCLK);
		while (!HREADY) @(negedge HCLK);
	end
	while (HRDATA !== {29'b0, 1'b0, 1'b1, 1'b0}); // {29'b0, error, done, busy}

	#5_000_000; // EEPROM internal write cycle time (TWC) = 5 ms
	$display("Finished writing SRAM D1 to EEPROM, TWC = 5 ms");

	// STEP 3: Read D1 from EEPROM address 16'h7FF0

	// WRITE to SPI TX REG: {READ command, EEPROM address, padding}
	tb_addr  = 32'h3000_0000;
	tb_wdata = 32'h037f_f000;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE to SPI CONTROL REG
	tb_addr  = 32'h3000_000c;
	tb_wdata = {23'b0, 2'd0, 3'd1, 3'd3, 1'b1}; // {23'b0, slave_select, rx_byte_size, tx_byte_size, spi_start}
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// Poll SPI STATUS REG until DONE
	do begin

		// READ SPI STATUS REG
		tb_addr  = 32'h3000_0008;
		tb_wstrb = 4'b1111;
		tb_write = 1'b0;
		tb_trans = 2'b10;

		@(posedge HCLK);
		while (!HREADY) @(posedge HCLK);
		@(negedge HCLK);

		tb_trans = 2'b00;

		// Hold while STATUS read completes
		while (HREADY) @(negedge HCLK);
		while (!HREADY) @(negedge HCLK);
	end
	while (HRDATA !== {29'b0, 1'b0, 1'b1, 1'b0}); // {29'b0, error, done, busy}

	// READ SPI RX REG
	tb_addr  = 32'h3000_0004;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold while SPI RX read completes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	$display("Data read from SPI EEPROM = %h", HRDATA);

	// WRITE SPI RX DATA TO SRAM A2
	tb_addr  = 32'h0000_00A2;
	tb_wdata = HRDATA;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;
	$display("Write Data to SRAM A2 = %h", HRDATA);

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// READ SRAM A2
	tb_addr  = 32'h0000_00A2;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold while SRAM A2 read completes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	$display("Data read from SRAM A2 = %h", HRDATA);

	// IDLE
	tb_addr  = 32'h0000_0000;
	tb_wdata = 32'h0000_0000;
	tb_wstrb = 4'b0000;
	tb_write = 1'b0;
	tb_trans = 2'b00;

	#5_000_000;
	$finish;
end

endmodule
