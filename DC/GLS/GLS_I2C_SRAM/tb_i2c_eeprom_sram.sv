`timescale 1ns/1ps
// SRAM -> I2C EEPROM -> SRAM
module tb_i2c_eeprom_sram;

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

	// SPI EEPROM and FeRAM Interface
	logic SPI_MOSI;
	wire SPI_MISO;
	logic SPI_SCK;
	logic [3:0] SPI_CS_n;

	// I2C RTCC and EEPROM Interface
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

// Full-Cycle -> 100 MHz = 10ns, Half-Cycle = 5ns
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

	repeat (100) @(posedge HCLK);

	@(negedge HCLK);
	HRESETn = 1'b1;

	repeat (100) @(posedge HCLK);

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

	// STEP 1: Write SRAM D1 to EEPROM address 16'h7FF0

	// BYTE WRITE:
	// Control byte      = 8'hA0
	// Address high byte = 8'h7F
	// Address low byte  = 8'hF0
	// Write data        = SRAM D1

	// WRITE to I2C TX REG
	tb_addr  = 32'h4000_0000;
	tb_wdata = {8'ha0, 16'h7ff0, sram_d1};
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;
	$display("I2C EEPROM WRITE DATA = %h", {8'ha0, 16'h7ff0, sram_d1});

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE to I2C CONTROL REG
	tb_addr  = 32'h4000_000c;
	tb_wdata = {25'b0, 3'd0, 3'd4, 1'b1}; // {25'b0, rx_byte_size, tx_byte_size, i2c_start}
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// Poll I2C STATUS REG until DONE
	do begin

		// READ I2C STATUS REG
		tb_addr  = 32'h4000_0008;
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

	$display("Finished writing SRAM D1 to I2C EEPROM address 16'h7FF0");

	// EEPROM internal write cycle time (tWC) = 5 ms
	#5_000_000;
	$display("Finished EEPROM internal write cycle, waited 5.0 ms");

	// STEP 2: Read D1 from EEPROM address 16'h7FF0

	// RANDOM READ:
	// Read control byte = 8'hA1
	// EEPROM address    = 16'h7FF0

	// WRITE to I2C TX REG
	tb_addr  = 32'h4000_0000;
	tb_wdata = 32'ha17f_f000;
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// WRITE to I2C CONTROL REG
	tb_addr  = 32'h4000_000c;
	tb_wdata = {25'b0, 3'd1, 3'd3, 1'b1}; // {25'b0, rx_byte_size, tx_byte_size, i2c_start}
	tb_wstrb = 4'b1111;
	tb_write = 1'b1;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	// Poll I2C STATUS REG until DONE
	do begin

		// READ I2C STATUS REG
		tb_addr  = 32'h4000_0008;
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

	// READ I2C RX REG
	tb_addr  = 32'h4000_0004;
	tb_wstrb = 4'b1111;
	tb_write = 1'b0;
	tb_trans = 2'b10;

	@(posedge HCLK);
	while (!HREADY) @(posedge HCLK);
	@(negedge HCLK);

	tb_trans = 2'b00;

	// Hold while I2C RX read completes
	while (HREADY) @(negedge HCLK);
	while (!HREADY) @(negedge HCLK);

	$display("Data read from I2C EEPROM = %h", HRDATA);

	// WRITE I2C RX DATA TO SRAM A2
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

	#1_000_000;
	$finish;
end

endmodule
