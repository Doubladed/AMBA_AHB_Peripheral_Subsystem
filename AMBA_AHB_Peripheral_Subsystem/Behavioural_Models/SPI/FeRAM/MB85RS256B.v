
//-------------------------------------------------------------------
// This Library is a confidential and proprietary product
// of RAMXEED LIMITED. This Library may be used solely for the
// purpose of review and evaluation of FeRAM products 
// of RAMXEED LIMITED. Any unauthorized use, reproduction,
// publication, disclosure, distribution, transfer or other 
// exploitation of this Library is strictly prohibited.
// This Library is provided "AS IS" without warranty of any kind,
// express or implied. RAMXEED LIMITED is not liable for any loss
// or damage which may result from the use of this Library.
// Copyright (c) 2016 by RAMXEED LIMITED.
// All Rights Reserved.
//-------------------------------------------------------------------
//-- DATE          : 2017/08/25
//-- REVISION      : 2.0
//-------------------------------------------------------------------

`timescale 1ps/1ps

`define VDD_CHECK

module MB85RS256B(
	 CS_X
	,SCK
	,SI
	,SO
	,WP_X
	,HOLD_X
`ifdef VDD_CHECK
	,VDD 
	,VSS	
`endif
);

// 
	input	CS_X;	// Chip Select        | 0:active   , 1:standby(SO=Hi-Z, other input=don't care)
	input	SCK;    // Serial Clock
	input	SI;	// Serial Data Input  
	output	SO;	// Serial Data Output 
	input	WP_X;	// Write Protect      | 0:protected, 1:unprotected
	input	HOLD_X;	// Hold Setting       | 1:active   , 0:hold(SO=Hi-Z, SCK=SI=don't care)

`ifdef VDD_CHECK
	input	VDD;
	input	VSS;
`endif



//=============================================================================
// Parameter Description
//=============================================================================
	parameter p_ADR_width     = 15;       // 256kBit
	parameter p_DATA_width    = 2**p_ADR_width;
	parameter p_WPEN_initial  = 1'b0;
	parameter p_STATUS6_initial = 1'b0;
	parameter p_STATUS5_initial = 1'b0;
	parameter p_STATUS4_initial = 1'b0;
	parameter p_BP_initial    = 2'b00;

	parameter p_CNT_ADR     = (p_ADR_width > 16 )? 24 : 16;
	
	parameter p_ManuID        = 8'h04;
	parameter p_ContCode      = 8'h7F;
	parameter p_ProductID1    = 8'h05;
	parameter p_ProductID2    = 8'h09;

// ================
// Operation Code
// ================
	// SPI
	parameter	p_WREN  = 8'h06; // set   write enable latch
	parameter	p_WRDI  = 8'h04; // reset write enable latch
	parameter	p_RDSR  = 8'h05; // read  status register
	parameter	p_WRSR  = 8'h01; // write status register
	parameter	p_READ  = 8'h03; // read  memory
	parameter	p_WRITE = 8'h02; // write memory
	parameter	p_RDID  = 8'h9F; // read device ID
	parameter	p_FSTRD = 8'h0B; // fast read memory

// ================
// AC Parameter
// ================
//	parameter	p_tOD       =   20000; // ps(Max)  : SDO disable time
	parameter	p_tOD       =   0;     // ps(Max)  : SDO disable time
	parameter	p_tODV      =   13000; // ps(Max)  : SDO output valid time
	parameter	p_tODV_25M  =   18000; // ps(Max)  : SDO output valid time
	parameter	p_tOH       =   0;     // ps(Min)  : SDO output hold  time
//	parameter	p_tHZ       =   20000; // ps(Max)  : data floating time form posedge of HOLD_X to data Hi-Z
	parameter	p_tHZ       =   0;     // ps(Max)  : data floating time form posedge of HOLD_X to data Hi-Z
	parameter	p_tLZ       =   20000; // ps(Max)  : data active   time form negedge of HOLD_X to data active


// ==============================================================================
//   FeRAM Function (SPI I/F)
// ==============================================================================
	// SPI Operation State
	parameter p_ST_IDLE       = 32'h0000_0001;//Idle State
	parameter p_ST_CODE       = 32'h0000_0002;//Code Input State
	parameter p_ST_WREN       = 32'h0000_0004;//Set   WEL (WREN)
	parameter p_ST_WRDI       = 32'h0000_0008;//Clear WEL (WRDI)
	parameter p_ST_RDSR       = 32'h0000_0010;//Output Status Register (RDSR)
	parameter p_ST_WRSR       = 32'h0000_0020;//Input  Status Register (WRSR)
	parameter p_ST_READ_ADR   = 32'h0000_0040;//Address Input(READ)
	parameter p_ST_READ_DAT   = 32'h0000_0080;//Data Output  (READ)
	parameter p_ST_WRITE_ADR  = 32'h0000_0100;//Address Input(WRITE)
	parameter p_ST_WRITE_DAT  = 32'h0000_0200;//Data    Input(FSTRD)
	parameter p_ST_FSTRD_ADR  = 32'h0000_0400;//Address Input(FSTRD) 
	parameter p_ST_FSTRD_MOD  = 32'h0000_1000;//Data    DMY(FSTRD)
	parameter p_ST_FSTRD_DAT  = 32'h0000_2000;//Data    Output(FSTRD)
	parameter p_ST_RDID       = 32'h0000_4000;//Devivce ID Output(RDID) 
	parameter p_ST_MISMATCH   = 32'h8000_0000;//Error Code
	
	parameter p_F_delay       = 10;					// delay for function mode

// ==============================================================================
//   Register & Wire Description   
// ==============================================================================
	reg		r_SPI_MODE;			// indicate SPI mode(0:mode 0, 1:mode 3)
	reg	[31:0]	r_state;		// SPI state
	reg	[ 7:0]	r_CS_X_count;	// valid CS_X count
	reg	[ 7:0]	r_STATUS;		// status register
	reg	[ 7:0]  r_SI_DFF;		// valid SI
	reg	[p_CNT_ADR-1:0] r_FeRAM_ADR;	// FeRAM Address
	reg	[7:0]	FeRAM_MEM[p_DATA_width-1:0];

	wire		w_WPEN = r_STATUS[7];	// Write Protection for Status Register
	wire	[1:0]	w_BP   = r_STATUS[3:2]; // Write Protect(0:none, 1:uppr 0x600000, 2:upper 0x40000, 3: all area)
	wire		w_WEL  = r_STATUS[1];


	reg	[7:0]	r_RDATA;
	wire	[7:0]	w_RDATA;		// Read  Data(Register & FeRAM)
	wire	[7:0]	w_FRDATA;		// FeRAM Read  Data
	wire	[7:0]	w_FWDATA;		// FeRAM Write Data
	wire		w_FeRAM_WR_OK;
	wire		w_SO_DATA;

	reg		r_SO_OE;
	reg		r_SO_OE_H;
	reg		r_START;
	
	wire		w_cnt_exe; 
	wire		w_cnt_exe_frd; 
	reg		w_cnt_exe_d;

	wire		HOLD_X_MODE;

	wire	[p_ADR_width-1:0]		r_FeRAM_ADR2;
	wire	[p_CNT_ADR-p_ADR_width-1:0]	r_FeRAM_ADR_OVR;
	wire		CSB_OK_SPI;
	wire		CSB_OK;

	wire  [7:0]	w_sioin  = {r_SI_DFF[6:0],SI};

	assign HOLD_X_MODE = HOLD_X; 
	
initial begin
  	$readmemh("FeRAM_init.hex", FeRAM_MEM);
end
	event trg_disp; 

// initial setting
initial begin
`ifdef  SPI_MODE0
	r_SPI_MODE = 1'b0;
`else
	`ifdef  SPI_MODE3
		r_SPI_MODE = 1'b1;
	`else
		r_SPI_MODE = 1'b0;
	`endif
`endif
	r_state      <= p_ST_IDLE;
	r_STATUS     <= {p_WPEN_initial,p_STATUS6_initial,p_STATUS5_initial,p_STATUS4_initial,p_BP_initial,2'b00};
	r_CS_X_count <= 8'h00;
	r_SI_DFF     <= 8'h00;
	r_FeRAM_ADR   <= {p_CNT_ADR{1'b0}};
	r_START      <= 1'b1;
end

// =================
// Power On Control
// =================
`ifdef VDD_CHECK
always @(VDD or VSS) begin
	if((VDD !== 1'b1) | (VSS !== 1'b0)) begin
		r_state      <= p_ST_IDLE;
		r_STATUS[1]  <= 1'bx;
		r_CS_X_count <= 8'hXX;
		r_SI_DFF     <= 8'hXX;
		r_FeRAM_ADR   <= {p_CNT_ADR{1'b0}};
		if (~CS_X) begin
			$display(" Error   : CS_X=L during VDD=L or VSS=H: time=%dps", $time);
			-> trg_disp;
		end
	#1       force CS_X=1'b1;
	end
	else if((VDD === 1'b1) & (VSS === 1'b0)) begin
		r_state      <= p_ST_IDLE;
		r_STATUS[1]  <= 1'b0;
		r_CS_X_count <= 8'h00;
		r_SI_DFF     <= 8'h00;
		r_FeRAM_ADR   <= {p_CNT_ADR{1'b0}};
		release CS_X;
	end
end
`else
	initial
		r_STATUS     <= {p_WPEN_initial,p_STATUS6_initial,p_STATUS5_initial,p_STATUS4_initial,p_BP_initial,2'b00};
	begin
`endif

//=================================================================================================
// State : changed at posedge of SCK or posedge CS_X
//=================================================================================================
parameter p_CNT_CMD     = 8;
parameter p_CNT_EXE     = p_CNT_CMD + p_CNT_ADR;
parameter p_CNT_EXE_FRD = p_CNT_CMD + p_CNT_ADR + 8;
parameter p_CNT_LOP     = p_CNT_EXE     + 8;
parameter p_CNT_LOP_FRD = p_CNT_EXE_FRD + 8;

assign w_cnt_exe     = ( r_CS_X_count == p_CNT_EXE     -1 ) ;
assign w_cnt_exe_frd = ( r_CS_X_count == p_CNT_EXE_FRD -1 ) ;


always @(posedge SCK or posedge CS_X) begin
	if( CS_X ) begin
		r_state <= #p_F_delay p_ST_IDLE;
	end
	// ===================
	// Command Input Start
	// ===================
	else if(r_state == p_ST_IDLE & HOLD_X_MODE ) begin
		r_state <= p_ST_CODE;
	end
	// ==============
	// Command Check
	// ==============
	else if((r_state == p_ST_CODE)  & (r_CS_X_count == p_CNT_CMD-1) & HOLD_X ) begin
		case ( w_sioin )
			p_WREN  : r_state <= #p_F_delay p_ST_WREN;
			p_WRDI  : r_state <= #p_F_delay p_ST_WRDI;
			p_RDSR  : r_state <= #p_F_delay p_ST_RDSR;
			p_WRSR  : r_state <= #p_F_delay p_ST_WRSR;
			p_READ  : r_state <= #p_F_delay p_ST_READ_ADR;
			p_WRITE : r_state <= #p_F_delay p_ST_WRITE_ADR;
			p_FSTRD : r_state <= #p_F_delay p_ST_FSTRD_ADR;
			p_RDID  : r_state <= #p_F_delay p_ST_RDID;
			default :
				begin
					 r_state <= #p_F_delay p_ST_MISMATCH;
					$display(" Error   : FeRAM command(%h) is mismatched!! : time=%dps", w_sioin, $time);	
					-> trg_disp;
				end 	
		endcase
	end
	// Read  Access
	else if(r_state == p_ST_READ_ADR & w_cnt_exe & HOLD_X_MODE) begin
		r_state <= #p_F_delay p_ST_READ_DAT;
	end
	// WRITE Access
	else if(r_state == p_ST_WRITE_ADR & w_cnt_exe & HOLD_X_MODE) begin
		r_state <= #p_F_delay p_ST_WRITE_DAT;
	end
	// FAST READ Access
	else if(r_state == p_ST_FSTRD_ADR & w_cnt_exe & HOLD_X_MODE) begin 
		r_state <= #p_F_delay p_ST_FSTRD_MOD;
	end
	else if(r_state == p_ST_FSTRD_MOD & w_cnt_exe_frd & HOLD_X_MODE) begin 
		r_state <= #p_F_delay p_ST_FSTRD_DAT;
	end
end

//=================================================================================================
// WRSR Status Data Control
//=================================================================================================
reg     STATUS_REFRESH;
reg     [7:0]   r_STATUS_WRSR;
always @(posedge SCK or posedge CS_X) begin
        if (CS_X) begin
           r_STATUS_WRSR[7] <= 1'b0;
           r_STATUS_WRSR[6] <= 1'b0;
           r_STATUS_WRSR[5] <= 1'b0;
           r_STATUS_WRSR[4] <= 1'b0;
           r_STATUS_WRSR[3] <= 1'b0;
           r_STATUS_WRSR[2] <= 1'b0;
           r_STATUS_WRSR[1] <= 1'b0;
           r_STATUS_WRSR[0] <= 1'b0;
           STATUS_REFRESH   <= 1'b0;
        end
        else if ((r_state == p_ST_WRSR) & (r_CS_X_count==8'h0F) ) begin
           r_STATUS_WRSR[7] <= r_SI_DFF[6];
           r_STATUS_WRSR[6] <= r_SI_DFF[5];
           r_STATUS_WRSR[5] <= r_SI_DFF[4];
           r_STATUS_WRSR[4] <= r_SI_DFF[3];
           r_STATUS_WRSR[3] <= r_SI_DFF[2];
           r_STATUS_WRSR[2] <= r_SI_DFF[1];
           r_STATUS_WRSR[1] <= r_SI_DFF[0];
           r_STATUS_WRSR[0] <= SI;
           STATUS_REFRESH   <= 1'b1;
        end
end

//=================================================================================================
// Status Register Control
//=================================================================================================

always @(posedge SCK or posedge CS_X) begin
	if((r_state == p_ST_WREN) & CS_X) begin
		r_STATUS[1] <= #p_F_delay 1'b1;
	end
	else if((r_state == p_ST_WRDI) & CS_X) begin
		r_STATUS[1] <= #p_F_delay 1'b0;
	end
	else if((r_state == p_ST_WRSR) & CS_X) begin
		if(w_WEL & (~w_WPEN | WP_X) & STATUS_REFRESH) begin
			r_STATUS[7] <= #p_F_delay r_STATUS_WRSR[7];
			r_STATUS[6] <= #p_F_delay r_STATUS_WRSR[6];
			r_STATUS[5] <= #p_F_delay r_STATUS_WRSR[5];
			r_STATUS[4] <= #p_F_delay r_STATUS_WRSR[4];
			r_STATUS[3] <= #p_F_delay r_STATUS_WRSR[3];
			r_STATUS[2] <= #p_F_delay r_STATUS_WRSR[2];
		end
		r_STATUS[1] <= #p_F_delay 1'b0;
	end
	else if((r_state == p_ST_WRITE_DAT) & CS_X) begin
		r_STATUS[1] <= #p_F_delay 1'b0;
	end
end

// -------------------------------
// CS_X counter(Valid SI Count)
// -------------------------------
wire	w_cnt_lop_frd = (r_state == p_ST_FSTRD_DAT) & (r_CS_X_count == p_CNT_LOP_FRD -1 );
wire	w_cnt_lop_rw  = (r_state == p_ST_READ_DAT)  & (r_CS_X_count == p_CNT_LOP -1) |
                        (r_state == p_ST_WRITE_DAT) & (r_CS_X_count == p_CNT_LOP -1);
wire    w_cnt_lop     = w_cnt_lop_frd | w_cnt_lop_rw;

always @(posedge SCK or posedge CS_X) begin
	if(CS_X)
		r_CS_X_count <= #p_F_delay 8'h00;
	else if( (HOLD_X_MODE) & ~CS_X) begin // HOLD_X=1 
		if( w_cnt_lop_frd )
			r_CS_X_count <= #p_F_delay p_CNT_EXE_FRD; 
		else if( w_cnt_lop_rw )
			r_CS_X_count <= #p_F_delay p_CNT_EXE;
		else if ( r_CS_X_count != {8{1'b1}} )
			r_CS_X_count <= #p_F_delay r_CS_X_count + 1;
	end
end

// -------------------------------
// SI register
// -------------------------------
always @(posedge SCK or posedge CS_X) begin
	if(CS_X)
		r_SI_DFF <= #p_F_delay 8'h00;
	else if(HOLD_X_MODE)
		r_SI_DFF <= #p_F_delay w_sioin;
end
	
// -------------------------------
// Address Latch
// -------------------------------
always @(posedge SCK or posedge CS_X) begin
	if(CS_X)
		r_FeRAM_ADR <= #p_F_delay {p_CNT_ADR{1'b0}};
	else if( HOLD_X_MODE & ( (r_state == p_ST_READ_ADR)  | (r_state == p_ST_WRITE_ADR) | (r_state == p_ST_FSTRD_ADR) ) )
		r_FeRAM_ADR <= #p_F_delay {r_FeRAM_ADR[p_CNT_ADR-2:0]  ,SI};
	else if((r_state == p_ST_READ_DAT) & (r_CS_X_count == p_CNT_LOP -1) & HOLD_X_MODE)
		r_FeRAM_ADR <= #p_F_delay r_FeRAM_ADR + 1;
	else if((r_state == p_ST_WRITE_DAT) & (r_CS_X_count == p_CNT_LOP -1) & HOLD_X_MODE)
		r_FeRAM_ADR <= #p_F_delay r_FeRAM_ADR + 1;
	else if((r_state == p_ST_FSTRD_DAT) & (r_CS_X_count == p_CNT_LOP_FRD -1) & HOLD_X_MODE)
		r_FeRAM_ADR <= #p_F_delay r_FeRAM_ADR + 1;
end

assign r_FeRAM_ADR2    = r_FeRAM_ADR[p_ADR_width-1:0];
assign r_FeRAM_ADR_OVR = r_FeRAM_ADR[p_CNT_ADR-1:p_ADR_width-1];

//===========================================================
//  FeRAM Memory Control
//===========================================================
event trg_wr; 
event trg_rd; 
// Write Protect Control
assign  w_FeRAM_WR_OK =
		w_WEL & ( (w_BP == 2'b00)
		| ((w_BP == 2'b01) & (r_FeRAM_ADR2 < {2'b11,{(p_ADR_width-2){1'b0}}}))
		| ((w_BP == 2'b10) & (r_FeRAM_ADR2 < {1'b1, {(p_ADR_width-1){1'b0}}})));

assign w_FWDATA = w_sioin;
//  FeRAM Write  
always @(posedge SCK) begin
	if((r_state == p_ST_WRITE_DAT) & (r_CS_X_count == p_CNT_LOP-1) & HOLD_X_MODE & w_FeRAM_WR_OK) begin
		FeRAM_MEM[r_FeRAM_ADR2] <= #p_F_delay w_FWDATA;
		-> trg_wr;
	end
end

always @(posedge SCK) begin
	if ( (r_FeRAM_ADR_OVR != 0 ) & ((r_state == p_ST_READ_ADR ) | (r_state == p_ST_WRITE_ADR ) | (r_state == p_ST_FSTRD_ADR ) ) & w_cnt_exe & HOLD_X_MODE)  begin

		$display ("Error   : Address out of memory!!(add:%h) : time:%dps", {r_FeRAM_ADR,SI},$time);
		-> trg_disp;
	end
end

//===========================================================
//  Read Data Control
//===========================================================
// select read data
assign  w_FRDATA = FeRAM_MEM[r_FeRAM_ADR2];

// Output Data
always @(negedge SCK or posedge CS_X) begin
	if(CS_X)
		r_RDATA <= #p_tOD {8{1'bx}};
	else if(r_state == p_ST_RDSR) begin
		if(r_CS_X_count == p_CNT_CMD)
			r_RDATA <= #p_F_delay r_STATUS[7:0];
		else if(HOLD_X_MODE)
			r_RDATA <= #p_F_delay {r_RDATA[6:0], r_RDATA[7]};
	end
	else if(r_state == p_ST_READ_DAT) begin
		if(r_CS_X_count == p_CNT_EXE) begin
			r_RDATA <= #p_F_delay w_FRDATA;
			-> trg_rd;
		end
		else if(HOLD_X_MODE)
			r_RDATA <= #p_F_delay {r_RDATA[6:0], 1'bx};
	end
	else if(r_state == p_ST_FSTRD_DAT) begin
		if(r_CS_X_count == p_CNT_EXE_FRD) begin
			r_RDATA <= #p_F_delay w_FRDATA;
			-> trg_rd;
		end
		else if(HOLD_X_MODE)
			r_RDATA <= #p_F_delay {r_RDATA[6:0], 1'bx};
	end
	else if(r_state == p_ST_RDID) begin
		if(r_CS_X_count == p_CNT_CMD)
			r_RDATA <= #p_F_delay p_ManuID;
		else if(r_CS_X_count == p_CNT_CMD+8)
			r_RDATA <= #p_F_delay p_ContCode;
		else if(r_CS_X_count == p_CNT_CMD+16)
			r_RDATA <= #p_F_delay p_ProductID1;
		else if(r_CS_X_count == p_CNT_CMD+24)
			r_RDATA <= #p_F_delay p_ProductID2;
		else if(HOLD_X_MODE)
			r_RDATA <= #p_F_delay {r_RDATA[6:0], r_RDATA[0]};
	end
end

assign w_SO_DATA =  r_RDATA[7];

// Output Enable Control
always @(negedge SCK or posedge CS_X) begin
	if(CS_X) begin
		r_SO_OE <= #p_tOD 1'b0;
	end
	else if( (r_state == p_ST_RDSR) | (r_state == p_ST_FSTRD_DAT) | (r_state == p_ST_RDID) ) begin
		#p_tOH;
		r_SO_OE <= 1'b0;
		#(p_tODV - p_tOH);
		if ( ~CS_X ) r_SO_OE <= 1'b1;
	end
 	else if (r_state == p_ST_READ_DAT)  begin
		#p_tOH;
		r_SO_OE <= 1'b0;
		#(p_tODV_25M - p_tOH);
		if ( ~CS_X ) r_SO_OE <= 1'b1;
	end
end

// HOLDB SO LATCH
always @ ( SCK or HOLD_X ) begin
	if (SCK == 1'b1)
		r_SO_OE_H <=r_SO_OE_H;
	else if (HOLD_X==1'b1)
		if ( r_SO_OE_H  )
			r_SO_OE_H <=HOLD_X;
		else
			#p_tLZ r_SO_OE_H <=HOLD_X;
	else
		#p_tHZ r_SO_OE_H <=HOLD_X;
end     

// Output Driver
assign SO = ( r_SO_OE & r_SO_OE_H ) ?  w_SO_DATA : 1'bz ;

//=============================================================================
// Check Description
//=============================================================================



// =====================
// function check
// =====================
always @( WP_X ) begin
	if ( r_state == p_ST_WRSR ) begin
		$display(" Error   : WP_X illegal move   : time=%dps", $time);
		-> trg_disp;
	end
end

//===================================
// CSB Error Timing Check
//==================================

assign CSB_OK    = ((r_state== p_ST_WREN)      & (r_CS_X_count == 8'h08))  |     // WREN
                   ((r_state== p_ST_WRDI)      & (r_CS_X_count == 8'h08))  |     // WRDI
                   ((r_state== p_ST_WRSR)      & (r_CS_X_count == 8'h10))  |     // WRSR
                   ((r_state== p_ST_RDSR)      & (r_CS_X_count[2:0]  == 3'h0)) |     // RDSR
                   ((r_state== p_ST_RDID)      & (r_CS_X_count[2:0]  == 3'h0)) |     // RDID
                   ((r_state== p_ST_WRITE_DAT) & (r_CS_X_count == 8'h18))  |     // WRITE
                   ((r_state== p_ST_READ_DAT)  & (r_CS_X_count == 8'h18))  |     // READ
                   ((r_state== p_ST_FSTRD_DAT) & (r_CS_X_count == 8'h20))  |     // FSTRD
                   ((r_state== p_ST_MISMATCH)                           )  ;     


always @ (negedge CS_X)
      r_START<=1'b0;

always @ (posedge CS_X) begin
`ifdef VDD_CHECK
   if((VDD === 1'b1) & (VSS === 1'b0)) begin
`endif
     if (~CSB_OK & ~r_START) begin
        $display(" Error   : Illegal CS_X Reset Timing   : time=%dps", $time);
        -> trg_disp;
     end
`ifdef VDD_CHECK
   end
`endif
end



// *********************
// timing check
// ********************

reg	notifier;

// ======================================
//  tSU tH timing check (SI Setup & Hold)
// ====================================== 
	
wire  w_SI_valid = CS_X? 1'b0:
	( (r_state== p_ST_WRSR)
	| (r_state== p_ST_WRITE_ADR)	| (r_state== p_ST_WRITE_DAT)	
	| (r_state== p_ST_READ_ADR)	| (r_state== p_ST_FSTRD_ADR) 	
	| (r_state== p_ST_CODE)		| (r_state== p_ST_IDLE) );	// Code Setting

// =========================================
//  tHS tHH timing check (HOLD Setup & Hold)
// ========================================= 
wire w_HOLDX_valid = ~CS_X;

// =========================================
//  fCK timing check (Frequency check)
// ========================================= 

// READ CHECK TIMING
wire	w_READ = (r_state == p_ST_READ_ADR) | (r_state == p_ST_READ_DAT);
wire	w_READ_COM = ~CS_X & w_READ;

//tCL/tCH check Except READ_COM and CS_X=H
wire   w_EX_READ_COM =  CS_X ? 1'b0 : ~w_READ_COM;


// =========================================
//  tD timing check (unselected time)
// ========================================= 
	
`ifndef no_timing

specify
	specparam	s_tCH_RD    =  20000; // ps(Min)  : SCK high width for read
	specparam	s_tCL_RD    =  20000; // ps(Min)  : SCK low  width for read
	specparam	s_tCH       =  15000; // ps(Min)  : SCK high width
	specparam	s_tCL       =  15000; // ps(Min)  : SCK low  width
	specparam	s_tCSU      =  10000; // ps(Min)  : CS_X setup time
	specparam	s_tCSH      =  10000; // ps(Min)  : CS_X hold  time
	specparam	s_tOH       =      0; // ps(Min)  : SDO output hold  time
	specparam	s_tD_25MHz  =  60000; // ps(Min)  : CS_X high width(non-selected time)
	specparam	s_tD_33MHz  =  40000; // ps(Min)  : CS_X high width(non-selected time)
	specparam	s_tSU       =   5000; // ps(Min)  : data setup time
	specparam	s_tH        =   5000; // ps(Min)  : data hold  time
	specparam	s_tHS       =  10000; // ps(Min)  : HOLD_X_MODE setup time
	specparam	s_tHH       =  10000; // ps(Min)  : HOLD_X_MODE hold  time
	specparam	s_tHZ       =  20000; // ps(Max)  : data floating time form posedge of HOLD_X_MODE to data Hi-Z
	specparam	s_tLZ       =  20000; // ps(Max)  : data active   time form negedge of HOLD_X_MODE to data active
	specparam	s_tpd       = 200000; // ps(min)  : CS_X hold time at power down
	specparam	s_tpu       =  85000; // ps(min)  : CS_X hold time at power up

	specparam     s_25MHz	=   40000; // ps(Min)  : 25MHz cycle 
	specparam     s_33MHz	=   30000; // ps(Min)  : 33MHz cycle

`ifndef no_tCLK
// frequency check 
	$period (posedge SCK &&& w_READ_COM    , s_25MHz,notifier); // 25MHz Operation check 
	$period (posedge SCK &&& w_EX_READ_COM , s_33MHz,notifier); // 33MHz Operation check  

// tCL,tCH   
	$width (posedge SCK &&& w_READ_COM     ,  s_tCH_RD, 0, notifier) ;	// SCK high width at Read
	$width (negedge SCK &&& w_READ_COM     ,  s_tCL_RD, 0, notifier) ;	// SCK low  width at Read
	$width (posedge SCK &&& w_EX_READ_COM  ,  s_tCH   , 0, notifier) ;	// SCK high width
	$width (negedge SCK &&& w_EX_READ_COM  ,  s_tCL   , 0, notifier) ;	// SCK low  width
`endif

`ifndef no_tCSB

// tCSU ,tCSH
	$setup (negedge CS_X, posedge SCK,  s_tCSU, notifier) ;		// CS_X setup time
	$hold  (negedge SCK,  posedge CS_X, s_tCSH, notifier) ;		// CS_X hold  time
	$hold  (posedge SCK,  posedge CS_X, s_tCSH, notifier) ;		// CS_X hold  time

`endif

`ifndef no_tSI
// tSU ,tH
        $setuphold (posedge SCK &&& w_SI_valid, SI, s_tSU, s_tH, notifier) ;

`endif

`ifndef no_tHOLD
// tHS ,tHH   
	$setup (negedge SCK ,negedge HOLD_X &&& w_HOLDX_valid, s_tHS, notifier);
	$setup (negedge SCK ,posedge HOLD_X &&& w_HOLDX_valid, s_tHS, notifier);

	$setup (posedge SCK ,negedge HOLD_X &&& w_HOLDX_valid, s_tHS, notifier);
	$setup (posedge SCK ,posedge HOLD_X &&& w_HOLDX_valid, s_tHS, notifier);

	$hold  (negedge HOLD_X &&& w_HOLDX_valid, posedge SCK, s_tHH, notifier); 
	$hold  (posedge HOLD_X &&& w_HOLDX_valid, posedge SCK, s_tHH, notifier);
	
	$hold  (negedge HOLD_X &&& w_HOLDX_valid, negedge SCK, s_tHH, notifier); 
	$hold  (posedge HOLD_X &&& w_HOLDX_valid, negedge SCK, s_tHH, notifier);
`endif

`ifndef no_tD
// tD   
	$width (posedge CS_X  , s_tD_33MHz , 0, notifier) ;	// CS_X high width(non-selected time)
`endif

	
`ifdef VDD_CHECK
	$setup (posedge CS_X, negedge VDD , s_tpd, notifier) ;
	$hold  (posedge VDD,  negedge CS_X, s_tpu, notifier) ;
`endif
endspecify

`endif

endmodule

