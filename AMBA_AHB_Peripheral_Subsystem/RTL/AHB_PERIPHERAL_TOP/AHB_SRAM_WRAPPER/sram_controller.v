module sram_controller(

	input HCLK,
	input HRESETn,

	input [31:0] sl_addr,
	input [31:0] sl_wdata,
	input [3:0] sl_wstrb,
	input sl_write,
	input valid_trans,

	output reg [31:0] sl_rdata
);

wire [3:0] bank_sel;
wire [7:0] local_addr;
wire       write_en;

reg [15:0] cs_n;

wire [31:0] sram0_rdata;
wire [31:0] sram1_rdata;
wire [31:0] sram2_rdata;
wire [31:0] sram3_rdata;
wire [31:0] sram4_rdata;
wire [31:0] sram5_rdata;
wire [31:0] sram6_rdata;
wire [31:0] sram7_rdata;
wire [31:0] sram8_rdata;
wire [31:0] sram9_rdata;
wire [31:0] sram10_rdata;
wire [31:0] sram11_rdata;
wire [31:0] sram12_rdata;
wire [31:0] sram13_rdata;
wire [31:0] sram14_rdata;
wire [31:0] sram15_rdata;

assign bank_sel   = sl_addr[11:8];
assign local_addr = sl_addr[7:0];

assign write_en = valid_trans && sl_write && (sl_wstrb == 4'b1111);

// SRAM Bank Selection
always @(*) begin

	cs_n = 16'b1111_1111_1111_1111;

	if (HRESETn && valid_trans) begin

		case (bank_sel)

			4'b0000: cs_n[0]  = 1'b0;
			4'b0001: cs_n[1]  = 1'b0;
			4'b0010: cs_n[2]  = 1'b0;
			4'b0011: cs_n[3]  = 1'b0;
			4'b0100: cs_n[4]  = 1'b0;
			4'b0101: cs_n[5]  = 1'b0;
			4'b0110: cs_n[6]  = 1'b0;
			4'b0111: cs_n[7]  = 1'b0;
			4'b1000: cs_n[8]  = 1'b0;
			4'b1001: cs_n[9]  = 1'b0;
			4'b1010: cs_n[10] = 1'b0;
			4'b1011: cs_n[11] = 1'b0;
			4'b1100: cs_n[12] = 1'b0;
			4'b1101: cs_n[13] = 1'b0;
			4'b1110: cs_n[14] = 1'b0;
			4'b1111: cs_n[15] = 1'b0;
		endcase
	end
end

// Read Data Multiplexer
always @(*) begin

	case (bank_sel)

		4'b0000: sl_rdata = sram0_rdata;
		4'b0001: sl_rdata = sram1_rdata;
		4'b0010: sl_rdata = sram2_rdata;
		4'b0011: sl_rdata = sram3_rdata;
		4'b0100: sl_rdata = sram4_rdata;
		4'b0101: sl_rdata = sram5_rdata;
		4'b0110: sl_rdata = sram6_rdata;
		4'b0111: sl_rdata = sram7_rdata;
		4'b1000: sl_rdata = sram8_rdata;
		4'b1001: sl_rdata = sram9_rdata;
		4'b1010: sl_rdata = sram10_rdata;
		4'b1011: sl_rdata = sram11_rdata;
		4'b1100: sl_rdata = sram12_rdata;
		4'b1101: sl_rdata = sram13_rdata;
		4'b1110: sl_rdata = sram14_rdata;
		4'b1111: sl_rdata = sram15_rdata;

		default: sl_rdata = 32'h0000_0000;
	endcase
end

SRAM1RW256x32 SRAM0(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[0]),
	.I   (sl_wdata),
	.O   (sram0_rdata)
);


SRAM1RW256x32 SRAM1(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[1]),
	.I   (sl_wdata),
	.O   (sram1_rdata)
);


SRAM1RW256x32 SRAM2(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[2]),
	.I   (sl_wdata),
	.O   (sram2_rdata)
);


SRAM1RW256x32 SRAM3(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[3]),
	.I   (sl_wdata),
	.O   (sram3_rdata)
);


SRAM1RW256x32 SRAM4(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[4]),
	.I   (sl_wdata),
	.O   (sram4_rdata)
);


SRAM1RW256x32 SRAM5(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[5]),
	.I   (sl_wdata),
	.O   (sram5_rdata)
);


SRAM1RW256x32 SRAM6(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[6]),
	.I   (sl_wdata),
	.O   (sram6_rdata)
);


SRAM1RW256x32 SRAM7(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[7]),
	.I   (sl_wdata),
	.O   (sram7_rdata)
);


SRAM1RW256x32 SRAM8(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[8]),
	.I   (sl_wdata),
	.O   (sram8_rdata)
);


SRAM1RW256x32 SRAM9(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[9]),
	.I   (sl_wdata),
	.O   (sram9_rdata)
);


SRAM1RW256x32 SRAM10(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[10]),
	.I   (sl_wdata),
	.O   (sram10_rdata)
);


SRAM1RW256x32 SRAM11(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[11]),
	.I   (sl_wdata),
	.O   (sram11_rdata)
);


SRAM1RW256x32 SRAM12(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[12]),
	.I   (sl_wdata),
	.O   (sram12_rdata)
);


SRAM1RW256x32 SRAM13(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[13]),
	.I   (sl_wdata),
	.O   (sram13_rdata)
);


SRAM1RW256x32 SRAM14(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[14]),
	.I   (sl_wdata),
	.O   (sram14_rdata)
);


SRAM1RW256x32 SRAM15(

	.A   (local_addr),
	.CE  (HCLK),
	.WEB (~write_en),
	.OEB (sl_write),
	.CSB (cs_n[15]),
	.I   (sl_wdata),
	.O   (sram15_rdata)
);

endmodule
