module ahb_i2c_wrapper(

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

	inout SDA,
	inout SCL
);

wire [31:0] sl_addr;
wire [31:0] sl_wdata;
wire [3:0]  sl_wstrb;
wire        sl_write;
wire        valid_trans;
wire [31:0] sl_rdata;

wire        i2c_start;
wire [31:0] tx_data;
wire [31:0] rx_data;
wire [2:0]  tx_byte_size;
wire [2:0]  rx_byte_size;
wire        busy;
wire        done;
wire        error;

ahb_i2c_sub AHB_I2C_SUB(

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

i2c_reg I2C_REG(

	.CLK          (HCLK),
	.RST_n        (HRESETn),
	.sl_addr      (sl_addr),
	.sl_wdata     (sl_wdata),
	.sl_wstrb     (sl_wstrb),
	.sl_write     (sl_write),
	.valid_trans  (valid_trans),
	.sl_rdata     (sl_rdata),
	.i2c_start    (i2c_start),
	.tx_data      (tx_data),
	.rx_data      (rx_data),
	.tx_byte_size (tx_byte_size),
	.rx_byte_size (rx_byte_size),
	.busy         (busy),
	.done         (done),
	.error        (error)
);

i2c_controller I2C_CONTROLLER(

	.CLK          (HCLK),
	.RST_n        (HRESETn),
	.i2c_start    (i2c_start),
	.tx_data      (tx_data),
	.rx_data      (rx_data),
	.tx_byte_size (tx_byte_size),
	.rx_byte_size (rx_byte_size),
	.busy         (busy),
	.done         (done),
	.error        (error),
	.SDA          (SDA),
	.SCL          (SCL)
);

endmodule
