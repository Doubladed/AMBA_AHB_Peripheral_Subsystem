module ahb_decmux(

	input HCLK,
	input HRESETn,

	// Address Decoder

	input [31:0] HADDR,

	output reg HSEL_S0,
	output reg HSEL_S1,
	output reg HSEL_S2,
	output reg HSEL_S3,

	// Response Multiplexer

	input [31:0] HRDATA_S0,
	input [31:0] HRDATA_S1,
	input [31:0] HRDATA_S2,
	input [31:0] HRDATA_S3,

	input HREADYOUT_S0,
	input HREADYOUT_S1,
	input HREADYOUT_S2,
	input HREADYOUT_S3,

	output reg [31:0] HRDATA,
	output reg HREADY
);

reg [1:0] mux_select;

// Address Decoder
always @(*) begin

	HSEL_S0 = ((HADDR >= 32'h0000_0000) && (HADDR <= 32'h0000_FFFF));
	HSEL_S1 = ((HADDR >= 32'h2000_0000) && (HADDR <= 32'h2000_00FF));
	HSEL_S2 = ((HADDR >= 32'h3000_0000) && (HADDR <= 32'h3000_00FF));
	HSEL_S3 = ((HADDR >= 32'h4000_0000) && (HADDR <= 32'h4000_00FF));
end


// Select Slave
always @(posedge HCLK or negedge HRESETn) begin

	if (!HRESETn) begin
	
		mux_select <= 2'd0;
	end
	else if (HREADY) begin

		if (HSEL_S0)
		mux_select <= 2'd0;

		else if (HSEL_S1)
		mux_select <= 2'd1;

		else if (HSEL_S2)
		mux_select <= 2'd2;

		else if (HSEL_S3)
		mux_select <= 2'd3;

		else
		mux_select <= 2'd0;
	end
end


// Response Multiplexer
always @(*) begin

	case (mux_select)

		2'd0: begin
		HRDATA = HRDATA_S0;
		HREADY = HREADYOUT_S0;
		end

		2'd1: begin
		HRDATA = HRDATA_S1;
		HREADY = HREADYOUT_S1;
		end

		2'd2: begin
		HRDATA = HRDATA_S2;
		HREADY = HREADYOUT_S2;
		end

		2'd3: begin
		HRDATA = HRDATA_S3;
		HREADY = HREADYOUT_S3;
		end

		default: begin
		HRDATA = 32'h0000_0000;
		HREADY = 1'b1;
		end
	endcase
end

endmodule
