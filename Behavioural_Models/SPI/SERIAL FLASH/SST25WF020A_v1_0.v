//**********************************************************************
//
//      Microchip 2M Serial Flash : SST25WF020A
//
//          --- Verilog-HDL MODEL ---
//
//----------------------------------------------------------------------
//  Ver  Date       Comment
//  1.0  7/3/13     Initial release
//----------------------------------------------------------------------
// Note: The following is the way to excute this model.
//    1. Reading the external file of the Flash memory data
//         When the verilog simulation is executed with "+define+datain",
//         the Flash memory data is loaded from the external file named
//         "from2m.dat".
//         This file need to be placed in the current directory that
//         executes simulation.
//         The format of the files is the following.
//              @00000
//           +- 01 02 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
//           |  11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 1f 20
//           |  21 22 23 24  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
//           +-----> 01
//                MSB  LSB
//         IN this example, the data of "00000h" address is "01h" and
//         "00001h" address is "02h". 
//         Thus, the data is arranged at address order. All data that 
//         is not set in this file are "XXh".
//
//    2. Reading the external file of the Status register non-volatile information
//         When the verilog simulation is executed with "+define+statusin",
//         the Flash memory status register non-volatile information is loaded
//            from the external file named "from2mstat.dat".
//         This file also need to be placed in the current directory that
//         executes simulation.
//         The format of the files is the following.
//           +- AC
//           +-----> AC
//                MSB  LSB
//         IN this example, the non-volatile information of "SRWP(Bit7)" is "1",
//         "TB(Bit5)" is "1","BP1(Bit3)" is "1" and "BP0(Bit2)" is "1". 
//         The data of "WEN(Bit1)" and "RDY#(Bit0)" are don`t care.
//
//    3. SHORT MODE simulation
//         When the verilog simulation is executed with "+define+shortsim",
//         The WRITE TIME(PAGE PROGRAM, SECTOR ERASE, BLOCK ERASE,
//         CHIP ERASE and STATUS REGISTER WRITE) is reduced.
//         tPP = 15us, tSE = 60us, tBE = 60us, tCE = 60us, tWRSR = 60us.
//           
//**************************************************************

`timescale 1ns / 10ps

module SST25WF020A ( SCK, SI, SO, CEB, WPB, HOLDB );

  input  SCK, CEB, SI, WPB, HOLDB;
 
  output SO;

  //`define datain
  //`define statusin
  //`define shortsim

//`protect

   `define  tCLHI_TIME	11.5
   `define  tCLLO_TIME	11.5
   `define  tCLHI2_TIME	14 		// READ(03h)
   `define  tCLLO2_TIME	14 		// READ(03h)
   `define  tCSS_TIME	10
   `define  tCSH_TIME	10
   `define  tDS_TIME	5
   `define  tDH_TIME	5
   `define  tCPH_TIME	25
   `define  tCHZ_TIME	15
   `define  tV_TIME	11
   `define  tHO_TIME	1
   `define  tHS_TIME	5
   `define  tHH_TIME	5
   `define  tHLZ_TIME	12
   `define  tHHZ_TIME	9
   `define  tWPS_TIME	20
   `define  tWPH_TIME	20
   `define  tDP_TIME	5_000
   `define  tPRB_TIME	5_000

`ifdef shortsim
   `define  tPP_TIME	15_000    
   `define  tSSE_TIME	60_000
   `define  tSE_TIME	60_000
   `define  tCHE_TIME	60_000
   `define  tSRW_TIME	60_000
  initial begin
    $display ("NOTICE!!");
    $display ("  This Flash memory simulation is SHORT MODE.");
    $display ("    WRITE TIME was changed for fast simulation.");
    $display ("    tPP = 15us, tSSE = 60us, tSE = 60us, tCHE = 60us, tSRW = 60us.");
    $display (" ");
  end
`else
   `define  tPP_TIME	3_500_000
   `define  tSSE_TIME	150_000_000
   `define  tSE_TIME	250_000_000
   `define  tCHE_TIME	33'd3_000_000_000
   `define  tSRW_TIME	10_000_000
`endif

 parameter COMMAND_WIDTH = 8;
 parameter DATA_CODE = 8;
 parameter ADDRESS_SIZE = 18;		// 2Mbit
 parameter SSEC_ADDRESS_SIZE = 6;	// 2Mbit
 parameter SEC_ADDRESS_SIZE = 2;	// 2Mbit
 parameter PAGE_ADDRESS_SIZE = 10;	// 2Mbit
 parameter MEMORY_SIZE = 262144;	// 2Mbit
 parameter PAGE_SIZE = 2048;
 parameter SCLK_SIZE = 12;
 parameter CMD_STORE_SIZE = 40;

 parameter tPP = `tPP_TIME;
 parameter tSSE = `tSSE_TIME;
 parameter tSE = `tSE_TIME;
 parameter tCHE = `tCHE_TIME;
 parameter tSRW = `tSRW_TIME;
 
 parameter tV = `tV_TIME;
 parameter tHO = `tHO_TIME;
 parameter tCHZ = `tCHZ_TIME;
 parameter tHHZ = `tHHZ_TIME;
 parameter tHLZ = `tHLZ_TIME;
 parameter tWPH_STORE = `tWPH_TIME;
 parameter tDP_STORE = `tDP_TIME;
 parameter tPRB_STORE = `tPRB_TIME;
 parameter tDH_STORE = `tDH_TIME;

 reg [COMMAND_WIDTH-1:0] CMD_CD;
 reg [DATA_CODE-1:0]     DT_CD;

 reg [ADDRESS_SIZE-1:0] ADDRESS;

 reg [ADDRESS_SIZE-1:0] PG_PROG_STORE_ADD;

 reg [7:0] fmemory[MEMORY_SIZE-1:0];

 reg [7:0] fmemorystat[0:0];

 reg [7:0] fstat_info;

 reg [PAGE_SIZE-1:0] fmpage;

 reg [SCLK_SIZE-1:0]  clk_count;

 reg [SCLK_SIZE-1:0]  DT_count;

 reg  clk_parity;

 reg [CMD_STORE_SIZE-1:0]  cmd_store_reg;
 
 reg  PG_data_entry_complete;

 reg  [2:0] prot_level;

 reg READ4_CMD;
 reg READ5_CMD;
 reg STATUS_READ_CMD;
 reg PDOWN_CMD;
 reg PDOWN_RELEASE_CMD;
 reg WRT_DSB_CMD;
 reg WRT_ENB_CMD;
 reg STATUS_WRT_CMD;

 reg WRT_DSB;
 reg WRT_ENB;
 reg STATUS_WRT;

 reg write_flag;

 reg single_bus_l;
 reg two_bus_l;
 reg four_bus_l;
 
 reg POWER_DOWN;
 reg PDOWN_ENTRY;
 reg PDOWN_RELEASE;

 reg WPB_store;
 reg HOLD_EVENT;
 reg hold_flag;
 reg no_erase_dat_fg;
 reg no_erase_fg;

 reg SRWP;
 reg TB;
 reg BP1;
 reg BP0;
 reg WEN;

 integer p, x, y;

 reg  [7:0] tmp;

 reg  [7:0] ADDRESS_inc;

 reg  [7:0] page[255:0];

 reg  spi_mode0;
 reg  spi_mode3;
 reg  every8bit;
 reg  IDREAD_9F_CMD;
 reg  IDREAD_AB_CMD;
 reg  SSERASE_CMD;
 reg  SERASE_CMD;
 reg  CERASE_CMD;
 reg  SSERASE_preset;
 reg  SERASE_preset;
 reg [SSEC_ADDRESS_SIZE-1:0] ADDRESS_ssers;
 reg [SEC_ADDRESS_SIZE-1:0] ADDRESS_sers;
 reg [PAGE_ADDRESS_SIZE-1:0] ADDRESS_page;
 reg [ADDRESS_SIZE-1:0] SSERS_START_ADD;
 reg [ADDRESS_SIZE-1:0] SSERS_END_ADD;
 reg [ADDRESS_SIZE-1:0] SERS_START_ADD;
 reg [ADDRESS_SIZE-1:0] SERS_END_ADD;
 reg  PROG_CMD;
 reg  PROG_preset;
 reg [ADDRESS_SIZE-1:0] ADDRESS_prg;
 reg  READ;
 reg  IDREAD_9F;
 reg  IDREAD_AB;
 reg  STATUS_READ;
 reg  SSERASE;
 reg  SERASE;
 reg  CERASE;
 reg  PROG;
 reg  [7:0] so_reg;
 reg  so_out;
 reg  OE_SO;

 reg  datain;
 reg  statusin;

 reg  [7:0] befor_data;
 reg  [7:0] after_data;
 
/* for timing check */
 reg error_tCLHI, error_tCLLO;
 reg error_tCLHI2, error_tCLLO2;
 reg error_tCSS, error_tCSH;
 reg error_tDS, error_tDH;
 reg error_tCPH;
 reg error_tHS, error_tHH;
 reg error_tWPS, error_tWPH;
 reg error_tDP, error_tPRB;

 reg ac_err_com_fg;

 reg error_tHS_fg, error_tHH_fg;

 wire WRT;
 
 integer n,i,j,k,l,m;

buf (_SCK, SCK);
buf (_SI, SI);
buf (_SO, SO);
buf (_CEB, CEB);
buf (_WPB, WPB);
buf (_HOLDB, HOLDB);

bufif1 ( SO, so_out, OE_SO );

/////////////////////////////////////
//       Initial data set          //
/////////////////////////////////////

`ifdef datain
  initial
    datain = 1;
`else
  initial
    datain = 0;
`endif

initial begin
  if( datain ) begin
    $readmemh ("from2m.dat",fmemory);
  end
  else if( !datain ) begin
    for ( n = 0; n < MEMORY_SIZE; n = n + 1 ) begin
      fmemory[n] = 8'hXX;
    end
  end
  $display (" Initial Data in");
  for ( n = 0; n <= 7; n = n + 1 ) begin
    $display ("Flashmemory Address=%h : Data=%h", n, fmemory[n]);
  end
  $display ("            :         ");
  $display ("            :         ");
  for ( n = MEMORY_SIZE-2; n <= MEMORY_SIZE-1; n = n + 1 ) begin
    $display ("Flashmemory Address=%h : Data=%h", n, fmemory[n]);
  end
end

`ifdef statusin
  initial
    statusin = 1;
`else
  initial
    statusin = 0;
`endif

initial begin
  if( statusin ) begin
    $readmemh ("from2mstat.dat",fmemorystat);
    fstat_info = fmemorystat[0];
    SRWP = fstat_info[7];
    TB   = fstat_info[5];
    BP1  = fstat_info[3];
    BP0  = fstat_info[2];
  end
  else if( !statusin ) begin
    SRWP = 1'h0;
    TB   = 1'h0;
    BP1  = 1'h0;
    BP0  = 1'h0;
  end
  $display ("                      ");
  $display (" Initial STATUS REGISTER Non-Volatile information in");
  $display ("Bit7(SRWP)=%h" , SRWP);
  $display ("Bit5(TB)=%h" , TB);
  $display ("Bit3(BP1)=%h" , BP1);
  $display ("Bit2(BP0)=%h" , BP0);
  $display ("                      ");
end

/////////////////////////////////////
//       SPI MODE detect           //
/////////////////////////////////////

always @( _CEB ) begin
  if( _CEB ) begin
    spi_mode0 <= #2 0;
    spi_mode3 <= #2 0;
  end
  else if( !_SCK && !_CEB ) 
    spi_mode0 <= 1;
  else if(  _SCK && !_CEB )
    spi_mode3 <= 1;
end

/////////////////////////////////////
//       CLK counter               //
/////////////////////////////////////

always @( posedge _SCK or posedge _CEB ) begin
  if( _CEB ) begin
    if( ( clk_count > 12'h000 && clk_count < 12'h008 ) && !clk_parity ) begin
      $display (" Warning : Command instruction less than a byte unit.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
    end
    clk_count <= 0;
  end
  else if( !hold_flag ) begin
    clk_count <= clk_count + 1;
  end
end

always @( posedge _CEB or posedge OE_SO ) begin
  clk_parity <= 0;
end

always @( posedge _SCK ) begin
  if( clk_count == 12'hFFF ) begin
    clk_parity <= 1;
  end
end

/////////////////////////////////////
//       COMMAND store             //
/////////////////////////////////////

always @( posedge _CEB ) begin
  cmd_store_reg <= 0;
end

always @( posedge _SCK ) begin
  if( !_CEB && !OE_SO && !hold_flag ) begin
    cmd_store_reg <= cmd_store_reg << 1;
    cmd_store_reg[0] <= _SI;
  end
end

/////////////////////////////////////
//       COMMAND code entry        //
/////////////////////////////////////

always @( negedge _SCK or posedge _CEB && _SCK ) begin
  if( clk_count == 12'h08 && !clk_parity && !hold_flag && !WRT && !POWER_DOWN ) begin
    case(cmd_store_reg[7:0])
      8'h03: READ4_CMD  <= 1;
      8'h0B: READ5_CMD  <= 1;
      8'hD7: SSERASE_CMD  <= 1;
      8'h20: SSERASE_CMD  <= 1;
      8'hD8: SERASE_CMD  <= 1;
      8'hC7: CERASE_CMD  <= 1;
      8'h60: CERASE_CMD  <= 1;
      8'h02: PROG_CMD  <= 1;
      8'h06: WRT_ENB_CMD    <= 1;
      8'h04: WRT_DSB_CMD    <= 1;
      8'h05: STATUS_READ_CMD  <= 1;
      8'h01: STATUS_WRT_CMD  <= 1;
      8'h9F: IDREAD_9F_CMD <= 1;
      8'hAB: begin
        IDREAD_AB_CMD <= 1;
        PDOWN_RELEASE_CMD <= 1;
      end
      8'hB9: PDOWN_CMD  <= 1;
      default: begin 
        $display (" Error : undefined command instruction entry.  (Time=%.3f, %m)",$realtime);
        $display ("          ");
      end
    endcase
  end
  else if( clk_count == 12'h08 && !clk_parity && !hold_flag && WRT && !POWER_DOWN ) begin
    if (cmd_store_reg[7:0] == 8'h05) begin
       STATUS_READ_CMD  <= 1;
    end
    else begin
      $display (" Warning : During write, all operations except STATUS READ are ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
    end
  end
  else if( clk_count == 12'h08 && !clk_parity && !hold_flag && POWER_DOWN ) begin
    if (cmd_store_reg[7:0] == 8'hAB) begin
      IDREAD_AB_CMD <= 1;
      PDOWN_RELEASE_CMD <= 1;
    end
    else begin
      $display (" Warning : POWER DOWN state has ignored all commands except IDREAD_AB and POWER DOWN RELEASE command.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
    end
  end
end

always @( posedge _CEB ) begin
  if( _CEB ) begin
    READ4_CMD <= 0;
    READ5_CMD <= 0;
    STATUS_READ_CMD <= 0;
    IDREAD_9F_CMD <= 0;
    IDREAD_AB_CMD <= 0;
    i <= #tCHZ 0;
    m <= #tCHZ 0;
  end
end

always @( negedge _CEB ) begin
  if( !_CEB ) begin
    WRT_ENB_CMD <= 0;
    WRT_DSB_CMD <= 0;
    SSERASE_CMD <= 0;
    SERASE_CMD <= 0;
    CERASE_CMD <= 0;
    PROG_CMD <= 0;
    STATUS_WRT_CMD <= 0;
    PDOWN_CMD <= 0;
    PDOWN_RELEASE_CMD <= 0;
  end
end
 
/////////////////////////////////////
//       ADDRESS entry             //
/////////////////////////////////////

always @( negedge _SCK or posedge _CEB ) begin
  if( _CEB )
    ADDRESS <= 0;
  else if( clk_count == 12'h20 && !clk_parity && !WRT )    /* 32 cycles */
    ADDRESS[ADDRESS_SIZE-1:0] <= cmd_store_reg[ADDRESS_SIZE-1:0];
  else if( clk_count == 12'h14 && !clk_parity && SSERASE_CMD )    /* 20 cycles */
    ADDRESS_ssers <= cmd_store_reg[SSEC_ADDRESS_SIZE-1:0];
  else if( clk_count == 12'h10 && !clk_parity && SERASE_CMD )    /* 16 cycles */
    ADDRESS_sers <= cmd_store_reg[SEC_ADDRESS_SIZE-1:0];
end
      

////////////////////////////////
//   PROGRAM / DATA entry     //
////////////////////////////////

always @( posedge _SCK ) begin
  if( ( clk_count > 12'h20 || clk_parity ) && PROG_CMD ) begin
    #1 if( clk_count == DT_count ) begin
      fmpage = fmpage << 8; 
      fmpage[7:0] = cmd_store_reg[7:0];
      DT_count  = DT_count + 8;
      if( j > 255 )
        l = l + 1;
      j  = j + 1;
      PG_data_entry_complete <= 1;
    end
    else
      PG_data_entry_complete <= 0;
  end
  else if( STATUS_WRT_CMD ) begin
    #1 if( clk_count == 12'h10 && !clk_parity ) begin
      DT_CD[7:0] = cmd_store_reg[7:0];
      PG_data_entry_complete <= 1;
    end
    else
      PG_data_entry_complete <= 0;
  end
end

always @( negedge WRT or negedge _CEB ) begin
  if( !WRT ) begin
    DT_count <=12'h28;
    PG_data_entry_complete <= 0;
    j = 0;
    l = 0;
  end
end


/////////////////////////////////////
//       READ mode                 //
/////////////////////////////////////
 
initial begin
  OE_SO <= 0;
end

always @( negedge _SCK or posedge _CEB ) begin
  if( _CEB ) begin
    OE_SO <= #tCHZ 0;
    READ <= 0;
  end
  else if( READ4_CMD && clk_count == 12'h20 && !clk_parity && !WRT && !hold_flag ) begin
    if( !ac_err_com_fg ) begin
      OE_SO <= 1;
      READ <= 1;
    end
    else begin
      $display ("  Error : AC violation occured during 4bus READ command instruction and hence");
      $display ("        that command input was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      ac_err_com_fg <= 0;
    end
  end
  else if( READ5_CMD && clk_count == 12'h28 && !clk_parity && !WRT && !hold_flag ) begin
    if( !ac_err_com_fg ) begin
      OE_SO <= 1;
      READ <= 1;
    end
    else begin
      $display (" Error : AC violation occured during 5bus READ command instruction and hence");
      $display ("        that command input was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      ac_err_com_fg <= 0;
    end
  end
end

always @( negedge _SCK or posedge _CEB or posedge READ ) begin
  if( _CEB ) begin
    i = #tCHZ 0;
    so_out = #tCHZ 1'bX;
  end
  else if( READ && !hold_flag && !ac_err_com_fg ) begin
    if( i == 8 ) begin
      ADDRESS = ADDRESS + 1;
      i = 0;
    end
    #tHO so_out = 1'bX;
    so_reg = fmemory[ADDRESS];  
    #(tV-tHO) so_out = so_reg[7-i];
    if( !_CEB )
      i = i + 1;
  end
  else if( READ && ac_err_com_fg ) begin
    $display (" Error : AC violation occured during READ and hence the corresponding output goes to ");
    $display ("        indefinite momentarily.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    ac_err_com_fg <= 0;
    if( !_CEB ) begin
      #tHO so_out = 1'bX;
      i = i + 1;
    end
  end
end

always @( posedge _CEB or posedge READ4_CMD or posedge READ5_CMD ) begin
  if( READ4_CMD && _CEB && clk_count < 12'h20 && !clk_parity ) begin
    READ4_CMD <= 0;
    $display (" Error : 4bus READ command ignored due to the transmitted data length is less than 4bus cycles.");
    $display ("                                                              (Time=%.3f, %m)",$realtime);
  end
  else if( READ5_CMD && _CEB && clk_count < 12'h28 && !clk_parity ) begin
    READ5_CMD <= 0;
    $display (" Error : 5bus READ command ignored due to the transmitted data length is less than 5bus cycles.");
    $display ("                                                              (Time=%.3f, %m)",$realtime);
  end
end

always @( posedge _CEB ) begin
  if( READ4_CMD && clk_count == 12'h20 && !clk_parity && _SCK ) begin
    READ4_CMD <= 0;
    $display (" Warning : For 4bus READ command, there is no clk availabale for output data transmission.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
  else if( READ5_CMD && clk_count == 12'h28 && !clk_parity && _SCK ) begin
    READ5_CMD <= 0;
    $display (" Warning : For 5bus READ command, there is no clk availabale for output data transmission.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
end


/////////////////////////////////////
//     STATUS REGISTER mode        //      
/////////////////////////////////////

//  STATUS REGISTER READ

initial
  STATUS_READ <= 0;

always @( posedge _CEB or posedge STATUS_READ_CMD ) begin
  if( _CEB ) begin
    OE_SO <= #tCHZ 0;
    STATUS_READ <= 0;
    STATUS_READ_CMD <= 0;
  end
  else if( STATUS_READ_CMD && clk_count == 12'h08 && !clk_parity && !hold_flag ) begin
    if( !ac_err_com_fg ) begin 
      OE_SO <= 1;
      STATUS_READ <= 1;
    end
    else begin
      $display (" Error : AC violation occured during STATUS READ command instruction and hence");
      $display ("        that command input was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      ac_err_com_fg <= 0;
    end
  end
end
 
always @( negedge _SCK or posedge _CEB or posedge STATUS_READ ) begin
  if( _CEB ) begin
    i = #tCHZ 0;
    so_out = #tCHZ 1'bX;
  end
  else if( STATUS_READ && !hold_flag && !ac_err_com_fg ) begin
    if( i == 8 ) begin
      i = 0;
    end
    so_reg[7] = SRWP;
    so_reg[6] = 1'b0;
    so_reg[5] = TB;
    so_reg[4] = 1'b0;
    so_reg[3] = BP1;
    so_reg[2] = BP0;
    so_reg[1] = WEN;
    so_reg[0] = WRT;
    #tHO so_out = 1'bX;
    #(tV-tHO) so_out = so_reg[7-i];
    if( !_CEB )
      i = i + 1;
  end
  else if( STATUS_READ && ac_err_com_fg ) begin
    $display (" Error : AC violation occured during STATUS READ and hence the corresponding output");
    $display ("        goes to indefinite momentarily.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    ac_err_com_fg <= 0;
    if( !_CEB ) begin
      #tHO so_out = 1'bX;
      i = i + 1;
    end
  end
end

always @( posedge _CEB ) begin
  if( STATUS_READ_CMD && clk_count == 12'h08 && !clk_parity && _SCK ) begin
    $display (" Warning : For STATUS READ command, there is no clk availabale for output data transmission.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
end

// STATUS REGISTER WRITE

initial begin
  WPB_store <= 0;
  STATUS_WRT <= 0;
  STATUS_WRT_CMD  <= 0;
end

always @( posedge _CEB or posedge STATUS_WRT_CMD ) begin
  if( STATUS_WRT_CMD && PG_data_entry_complete && WEN && _CEB ) begin
    WPB_store = _WPB;
    STATUS_WRT_CMD  = 0;
    #tWPH_STORE
    if( SRWP === 1'hX ) begin
      TB  = 1'hX;
      BP1 = 1'hX;
      BP0 = 1'hX;
      $display (" Error : STATUS REGISTER Non-Volatile information (SRWP) is not defined.  (Time=%.3f, %m)",$realtime - tWPH_STORE );
      $display (" STATUS REGISTER WRITE is not executed.");
      $display ("          ");
    end
    else if( ( !SRWP || WPB_store ) && !ac_err_com_fg ) begin
      STATUS_WRT = 1;
      $display (" STATUS REGISTER WRITE started.  (Time= %.3f, %m)", $realtime-tSRW);
      #(tSRW-tWPH_STORE) STATUS_WRT <= 0;
      SRWP = DT_CD[7];
      TB  = DT_CD[5];
      BP1 = DT_CD[3];
      BP0 = DT_CD[2];
      $display (" STATUS REGISTER WRITE completed.  (Time= %.3f, %m)", $realtime);
      $display (" STATUS REGISTER Non-Volatile information : Bit7(SRWP)=%h" , SRWP);
      $display ("                                          : Bit5(TB)=%h" , TB);
      $display ("                                          : Bit3(BP1)=%h" , BP1);
      $display ("                                          : Bit2(BP0)=%h" , BP0);
      $display ("          ");
    end
    else if( SRWP == 1 && WPB_store == 0 && !ac_err_com_fg ) begin
      $display (" Warning : STATUS REGISTER is write protected because SRWP is Hi and WP# pin is Lo.");
      $display ("                                                                   (Time=%.3f, %m)",$realtime);
      $display (" STATUS REGISTER WRITE is not executed.");
      $display (" STATUS REGISTER Non-Volatile information : Bit7(SRWP)=%h" , SRWP);
      $display ("                                          : Bit5(TB)=%h" , TB);
      $display ("                                          : Bit3(BP1)=%h" , BP1);
      $display ("                                          : Bit2(BP0)=%h" , BP0);
      $display ("          ");
    end
    else if( ac_err_com_fg ) begin
      SRWP  = 1'hX;
      TB  = 1'hX;
      BP1 = 1'hX;
      BP0 = 1'hX;
      $display (" Error : STATUS REGISTER WRITE failed due to AC violation in the input command sequence.");
      $display ("                                                              (Time=%.3f, %m)",$realtime - tWPH_STORE );
      $display (" STATUS REGISTER Non-Volatile information : Bit7(SRWP)=%h" , SRWP);
      $display ("                                          : Bit5(TB)=%h" , TB);
      $display ("                                          : Bit3(BP1)=%h" , BP1);
      $display ("                                          : Bit2(BP0)=%h" , BP0);
      $display ("          ");
      ac_err_com_fg <= 0;
    end
  end
  else if( STATUS_WRT_CMD && PG_data_entry_complete && !WEN && _CEB ) begin
    $display (" Warning : WEN bit is not set to 1 and hence STATUS REGISTER WRITE command was ignored.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    STATUS_WRT_CMD  <=  0;
  end
  else if( STATUS_WRT_CMD && !single_bus_l && WEN && _CEB ) begin
    $display (" Error : No register data supplied and hence STATUS REGISTER WRITE command was ignored.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    STATUS_WRT_CMD  <=  0;
  end
  else if( STATUS_WRT_CMD && two_bus_l && WEN && _CEB ) begin
    $display (" Error : STATUS REGISTER WRITE command ignored due to the transmitted data length is");
    $display ("        more than 2 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    STATUS_WRT_CMD <= 0;
  end
  else if( STATUS_WRT_CMD && !PG_data_entry_complete && WEN && _CEB ) begin
    $display (" Error : STATUS REGISTER WRITE command ignored due to the transmitted data length is");
    $display ("        less than 2 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    STATUS_WRT_CMD <= 0;
  end
end

/////////////////////////////////////
//     WRITE ENABLE / DISABLE      //      
/////////////////////////////////////

always @( posedge _CEB or posedge WRT_ENB_CMD ) begin
  if( WRT_ENB_CMD  && !single_bus_l && _CEB ) begin
    if( ac_err_com_fg ) begin
      $display (" Error : AC violation occured and hence WRITE ENABLE command was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      WRT_ENB_CMD  <=   0;
      ac_err_com_fg <= 0;
    end
    else begin
      WRT_ENB <= 1;
      WRT_ENB_CMD  <= 0;
    end
  end
  else if( WRT_ENB_CMD && single_bus_l && _CEB ) begin
    $display (" Error : WRITE ENABLE command ignored due to the transmitted data length is more than 1 bus cycle .  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    WRT_ENB_CMD  <=   0;
  end
end

always @( posedge _CEB or posedge WRT_DSB_CMD ) begin
  if( WRT_DSB_CMD && !single_bus_l && _CEB ) begin
    if( ac_err_com_fg ) begin
      $display (" Error : AC violation occured and hence WRITE DISABLE command was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      WRT_DSB_CMD  <=   0;
      ac_err_com_fg <= 0;
    end
    else begin
      WRT_DSB <= 1;
      WRT_DSB_CMD  <=   0;
    end
  end
  else if( WRT_DSB_CMD && single_bus_l && _CEB ) begin
    $display (" Error : WRITE DISABLE command ignored due to the transmitted data length is more than 1 bus cycle .  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    WRT_DSB_CMD  <=  0;
  end
end
 
initial begin
  WEN <= 0;
  WRT_ENB <= 0;
  WRT_ENB_CMD <= 0;
  WRT_DSB <= 0;
  WRT_DSB_CMD <= 0;
end

always @( negedge WRT or posedge WRT_DSB ) begin
  if( WRT_DSB && !WEN ) begin
    $display (" Warning : WRITE DISABLE was requested while WEN bit is not set to 1.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    WRT_DSB <= 0;
  end
  else begin
    WEN <= 0;
    WRT_DSB <= 0;
  end
end

always @( posedge WRT_ENB ) begin
  if( WEN ) begin
    $display (" Warning : WRITE EABLE was requested while WEN bit is set to 1.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    WRT_ENB <= 0;
  end
  else begin
    WEN <= 1;
    WRT_ENB <= 0;
  end
end

//////////////////////////////////////////////////
//      Protection level setting conditions     //
/////////////////////////////////////////////////

always @( negedge _CEB ) begin
  if( ( TB === 1'hx ) || ( BP1 === 1'hX ) || ( BP0 === 1'hX ) )
    prot_level = 3'hX;
  else if( {BP1,BP0} === 2'h0 )
    prot_level = 3'h0; 			//no protect
  else if( {TB,BP1,BP0} === 3'h1 )
    prot_level = 3'h1;
  else if( {TB,BP1,BP0} === 3'h2 )
    prot_level = 3'h2;
  else if( {TB,BP1,BP0} === 3'h5 )
    prot_level = 3'h5;
  else if( {TB,BP1,BP0} === 3'h6 )
    prot_level = 3'h6;
  else
    prot_level = 3'h7;			//all protect
  //$display ("                      Set prot_level=%h",prot_level);
end

/////////////////////////////////////
//     POWER DOWN mode             //
/////////////////////////////////////

// POWER DOWN

always @( posedge _CEB or posedge PDOWN_CMD ) begin
  if( PDOWN_CMD && !single_bus_l && _CEB ) begin
    if( !ac_err_com_fg ) begin
      PDOWN_ENTRY <= 1;
      PDOWN_CMD  <=  0;
      $display (" POWER DOWN command executed.  (Time=%.3f, %m)",$realtime );
      $display (" POWER DOWN state will be entered from Time=%.3f.",$realtime + tDP_STORE );
      $display ("          ");
      POWER_DOWN <= #tDP_STORE 1;
      PDOWN_ENTRY <= #tDP_STORE 0; 
    end
    else begin
      $display (" Error : AC violation occured during POWER DOWN command instruction and hence that command input was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      PDOWN_CMD  <=  0;
      ac_err_com_fg <= 0;
    end
  end
  else if( PDOWN_CMD && single_bus_l ) begin
    if( _CEB ) begin
      $display (" Error : POWER DOWN command ignored due to the transmitted data length is more than 1 bus cycle.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      PDOWN_CMD  <=  0;
    end
  end
end

// POWER DOWN RELEASE

always @( posedge _CEB or posedge PDOWN_RELEASE_CMD ) begin
  if( PDOWN_RELEASE_CMD && _CEB ) begin
    if( POWER_DOWN ) begin
      if( !ac_err_com_fg ) begin
        PDOWN_RELEASE <= 1;
        PDOWN_RELEASE_CMD <= 0;
        $display (" POWER DOWN RELEASE command executed.  (Time=%.3f, %m)",$realtime );
        $display (" POWER DOWN state will be exited from Time=%.3f.",$realtime + tPRB_STORE );
        $display ("          ");
        POWER_DOWN <= #tPRB_STORE 0;
        PDOWN_RELEASE <= #tPRB_STORE 0; 
      end
      else begin
        $display (" Error : AC violation occured during POWER DOWN RELEASE command instruction and hence that command input was ignored.  (Time=%.3f, %m)",$realtime);
        $display ("          ");
        PDOWN_RELEASE_CMD <=  0;
        ac_err_com_fg <= 0;
      end
    end
    else if( !POWER_DOWN && clk_count < 12'h20 && !clk_parity ) begin
      $display (" Warning : POWER DOWN RELEASE was requested while POWER DOWN state is not entered.  (Time=%.3f, %m)",$realtime);    
      $display ("          ");
      PDOWN_RELEASE_CMD <=  0;
    end
  end
end

initial begin
  PDOWN_CMD <= 0; 
  PDOWN_RELEASE_CMD <= 0; 
  POWER_DOWN <= 0; 
  PDOWN_ENTRY <= 0; 
  PDOWN_RELEASE <= 0; 
end

always @( negedge _CEB ) begin
  if( PDOWN_ENTRY ) begin
    PDOWN_ENTRY <= 0; 
    $display (" Error : POWER DOWN failed due to insufficient power down time, tDP.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
  else if( PDOWN_RELEASE ) begin
    PDOWN_RELEASE <= 0; 
    $display (" Error : POWER DOWN RELEASE failed due to insufficient power down recovery time, tPRB.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
end

////////////////////////////////////
//     READID mode                /r
////////////////////////////////////

//  IDREAD_9F

initial begin
  IDREAD_9F_CMD <= 0;
  IDREAD_9F <= 0;
end

always @( posedge _CEB or posedge IDREAD_9F_CMD ) begin
  if( _CEB ) begin
    OE_SO <= #tCHZ 0;
    IDREAD_9F_CMD <= 0;
    IDREAD_9F <= 0;
  end
  else if( clk_count == 12'h08 && !clk_parity && IDREAD_9F_CMD && !hold_flag ) begin
    if( !ac_err_com_fg ) begin 
      OE_SO <= 1;
      IDREAD_9F <= 1;
    end
    else begin
      $display (" Error : AC violation occured during IDREAD_9F command instruction and hence");
      $display ("        that command input was ignored.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      ac_err_com_fg <= 0;
    end
  end
end
 
always @( negedge _SCK or posedge _CEB or posedge IDREAD_9F ) begin
  if( _CEB ) begin
    i = #tCHZ 0;
    m = #tCHZ 0;
    so_out = #tCHZ 1'bX;
  end
  else if( IDREAD_9F && !hold_flag && !ac_err_com_fg ) begin
    if( m == 0 ) begin
      if( i == 8)
        i = 0;
      so_reg = 8'h62;       /* SANYO */
      #tHO so_out = 1'bX;
      #(tV-tHO) so_out = so_reg[7-i];
      i = i + 1;
      if( i == 8)
        m = 1;
    end
    else if( m == 1 ) begin
      if( i == 8)
        i = 0;
      so_reg = 8'h16;       /* MEMORY TYPE */
      #tHO so_out = 1'bX;
      #(tV-tHO) so_out = so_reg[7-i];
      i = i + 1;
      if( i == 8)
        m = 2;
    end
    else if( m == 2 ) begin
      if( i == 8)
        i = 0;
      so_reg = 8'h12;       /* MEMORY CAPACITY */
      #tHO so_out = 1'bX;
      #(tV-tHO) so_out = so_reg[7-i];
      i = i + 1;
      if( i == 8)
        m = 3;
    end
    else if( m == 3 ) begin
      if( i == 8)
        i = 0;
      so_reg = 8'h00;       /* Reserved */
      #tHO so_out = 1'bX;
      #(tV-tHO) so_out = so_reg[7-i];
      i = i + 1;
      if( i == 8)
        m = 0;
    end
  end
  else if( IDREAD_9F && ac_err_com_fg ) begin
    $display (" Error : AC violation occured during IDREAD_9F and hence the corresponding output");
    $display ("        goes to indefinite momentarily.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    ac_err_com_fg <= 0;
    if( !_CEB ) begin
      #tHO so_out = 1'bX;
      i = i + 1;
    end
  end
end

always @( posedge _CEB ) begin
  if( IDREAD_9F_CMD && clk_count == 12'h08 && !clk_parity && _SCK ) begin
    IDREAD_9F_CMD <= 0;
    IDREAD_9F <= 0;
    $display (" Warning : For IDREAD_9F command, there is no clk availabale for output data transmission.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
end


//  IDREAD_AB

initial begin
  IDREAD_AB_CMD <= 0;
  IDREAD_AB <= 0;
end

always @( negedge _SCK or posedge _CEB ) begin
  if( _CEB ) begin
    OE_SO <= #tCHZ 0;
    IDREAD_AB_CMD <= 0;
    IDREAD_AB <= 0;
  end
  else if( clk_count == 12'h20 && !clk_parity && IDREAD_AB_CMD && !hold_flag ) begin
    if( !ac_err_com_fg ) begin
      OE_SO <= 1;
      IDREAD_AB <= 1;
    end
    else begin
      if( !POWER_DOWN ) begin
        $display (" Error : AC violation occured during IDREAD_AB command instruction and hence");
        $display ("        that command input was ignored.  (Time=%.3f, %m)",$realtime);
        $display ("          ");
        ac_err_com_fg <= 0;
      end
    end
  end
end
 
always @( negedge _SCK or posedge _CEB or posedge IDREAD_AB ) begin
  if( _CEB ) begin
    i = #tCHZ 0;
    so_out = #tCHZ 1'bX;
  end
  else if( IDREAD_AB && !hold_flag && !ac_err_com_fg ) begin
    if( i == 8 ) begin
      i = 0;
    end
    so_reg = 8'h34;        /* LE25S20 */
    #tHO so_out = 1'bX;
    #(tV-tHO) so_out = so_reg[7-i];
    if( !_CEB )
      i = i + 1;
    if( i == 8 )
      ADDRESS[0] = 0;  
  end
  else if( IDREAD_AB && ac_err_com_fg ) begin
    $display (" Error : AC violation occured during IDREAD_AB and hence the corresponding output");
    $display ("        goes to indefinite momentarily.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    ac_err_com_fg <= 0;
    if( !_CEB ) begin
      #tHO so_out = 1'bX;
      i = i + 1;
    end
  end
end

always @( posedge _CEB ) begin
  if( IDREAD_AB_CMD && ( clk_count > 12'h08 && clk_count < 12'h20 ) && !clk_parity && !POWER_DOWN ) begin
    IDREAD_AB_CMD <= 0;
    $display (" Error : IDREAD_AB command ignored due to the transmitted data length is less than 4 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
  else if( IDREAD_AB_CMD && clk_count == 12'h20 && !clk_parity && _SCK && !POWER_DOWN ) begin
    IDREAD_AB_CMD <= 0;
    $display (" Warning : For IDREAD_AB command, there is no clk availabale for output data transmission.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
end

/////////////////////////////////////
//     HOLD Function               //
/////////////////////////////////////

initial begin
  HOLD_EVENT <= 0; 
  hold_flag <= 0;
end

always @( posedge _CEB or _HOLDB ) begin
  if( _CEB ) begin
    hold_flag <= 0;
    OE_SO <= #tCHZ 0;
    HOLD_EVENT <= 0;
  end
  else begin
    HOLD_EVENT <= 1; 
  end
end

always @( posedge HOLD_EVENT ) begin
  if( !_CEB && !_SCK && !_HOLDB ) begin
     if( error_tHH_fg ) begin
      $display (" Error : HOLD entry function fails due to hold time violation, tHH.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      OE_SO <= 1'bX;
      hold_flag <= 1'bX;
      HOLD_EVENT <= 0; 
      error_tHH_fg <= 0;
    end
    else begin
      hold_flag <= 1;
      HOLD_EVENT <= 0; 
      #tHHZ if ( error_tHS !== 1 && error_tHH !== 1 ) begin
        OE_SO <= 0;
      end
    end
  end
  else if( !_CEB && _HOLDB && !_SCK ) begin
    if( error_tHH_fg ) begin
      $display (" Error : HOLD release function fails due to violation in Hold time, tHH.  (Time=%.3f, %m)",$realtime);
      $display ("          ");
      OE_SO <= 1'bX;
      hold_flag <= 1'bX;
      HOLD_EVENT <= 0; 
      error_tHH_fg <= 0;
    end
    else begin
      hold_flag <= 0;
      HOLD_EVENT <= 0; 
      if( READ || STATUS_READ || IDREAD_9F || IDREAD_AB ) begin
        #tHLZ if ( error_tHS !== 1 && error_tHH !== 1 ) begin
          OE_SO <= 1;
        end
      end
    end
  end
  else if( !_CEB && !_HOLDB && _SCK ) begin
    $display (" Warning : HOLD entry function cannot accept during EXSCK=1.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    HOLD_EVENT <= 0; 
  end
  else if( !_CEB && _HOLDB && _SCK ) begin
    $display (" Warning : HOLD release function cannot accept during EXSCK=1.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    HOLD_EVENT <= 0; 
  end
end

always @( posedge error_tHS_fg ) begin
  if( !_CEB && !_HOLDB && _SCK ) begin
    $display (" Error : HOLD entry function fails due to setup time violation, tHS.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    OE_SO <= 1'bX;
    hold_flag <= 1'bX;
    error_tHS_fg <= 0;
  end
  else if( !_CEB && _HOLDB && _SCK ) begin
    $display (" Error : HOLD release function fails due to violation in Hold time, tHS.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    OE_SO <= 1'bX;
    hold_flag <= 1'bX;
    error_tHS_fg <= 0;
  end
end

always @( negedge _CEB ) begin
  if( !_CEB && !_HOLDB ) begin
    hold_flag <= 1;
  end
end

always @(  SCK ) begin
  if( !_CEB & _HOLDB === 1'bX ) begin
    $display (" Error : HOLD pin is not certain.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    hold_flag <= 1'bX;
  end
end
    
/////////////////////////////////////
//     WRITE status                //
/////////////////////////////////////
 
assign WRT = SSERASE | SERASE | PROG | CERASE | STATUS_WRT;

/////////////////////////////////////
//     WRITE setup                 //
/////////////////////////////////////
 
always @( posedge _SCK ) begin
  if( clk_count[2:0] == 3'h7 && !_CEB)
    every8bit <= 1;
  if( clk_count[2:0] == 3'h0 && !_CEB)
    every8bit <= 0;
end

always @(_SCK ) begin
  //check only for 1 bus cycle
  if( clk_count == 12'h8 && !clk_parity && !_CEB && _SCK)
    single_bus_l <= 1;
  //check only for 2 bus cycles
  if( clk_count == 12'h10 && !clk_parity && !_CEB && _SCK)
    two_bus_l <= 1;  
  //check only for 4 bus cycles
  if( clk_count == 12'h20 && !clk_parity && !_CEB && _SCK)
    four_bus_l <= 1;
end

always @( negedge _CEB ) begin
  if( !_CEB ) begin
    every8bit <= 0;
    single_bus_l <= 0;
    two_bus_l <= 0;
    four_bus_l <= 0;
  end
end

/////////////////////////////////////
//       ERASE mode                //
/////////////////////////////////////

/* SMALL SECTOR ERASE */

initial begin
  SSERASE <= 0;
  SSERASE_preset <= 0;
  SSERASE_CMD  <= 0;
  write_flag <= 0;
end

always @( posedge _CEB ) begin
  if( clk_count < 12'h20 && !clk_parity && SSERASE_CMD && _CEB ) begin
    SSERASE_CMD  <= 0;
    $display (" Error : SMALL SECTOR ERASE command ignored due to the transmitted data length is less than 4 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
  else if( clk_count == 12'h20 && !clk_parity && SSERASE_CMD && _CEB ) begin
    SSERASE_preset <= 1;
  end
  else if( ( clk_count > 12'h20 || clk_parity ) && SSERASE_CMD && _CEB ) begin
    $display (" Error : SMALL SECTOR ERASE command ignored due to the transmitted data length is");
    $display ("        more than 4 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    SSERASE_CMD  <=  0;
  end
end

always @( negedge WRT ) begin
  if( !WRT ) begin
    write_flag <= 0;
    j = 0;
    l = 0;
  end
end

always @( posedge SSERASE_preset ) begin
  if( SSERASE_CMD && SSERASE_preset && !four_bus_l && WEN ) begin
    if( _CEB ) begin
      SSERASE_preset = 0;
      SSERASE_CMD  = 0;
      case( prot_level )
        3'hX : write_flag = 0;
        3'h7 : write_flag = 0;
        3'h6 : begin
                 if( ADDRESS_ssers > 6'h1F )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h5 : begin
                 if( ADDRESS_ssers > 6'h0F )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h2 : begin
                 if( ADDRESS_ssers < 6'h20 )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h1 : begin
                 if( ADDRESS_ssers < 6'h30 )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h0 : write_flag = 1;
        default write_flag = 0;
      endcase
      SSERS_START_ADD = { ADDRESS_ssers, 12'h000 };
      SSERS_END_ADD = { ADDRESS_ssers, 12'hFFF };
      if( ac_err_com_fg ) begin
        for ( j = SSERS_START_ADD; j <= SSERS_END_ADD; j = j + 1 ) begin
          fmemory[j] = 8'hXX;
        end
        $display (" Error : SMALL SECTOR ERASE failed due to AC violation in the input command sequence.");
        $display ("                                                    (Time=%.3f, %m)",$realtime);
        for ( j = SSERS_START_ADD; j <= SSERS_START_ADD + 7; j = j + 1 ) begin
          $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
        end
        $display ("          :");
        $display ("          :");
        $display ("          :");
        $display ("Flashmemory Address=%h : Data=%h", SSERS_END_ADD-1, fmemory[SSERS_END_ADD-1]);
        $display ("Flashmemory Address=%h : Data=%h", SSERS_END_ADD-0, fmemory[SSERS_END_ADD]);
        $display ("          ");
        ac_err_com_fg <= 0;
      end
      else if( !write_flag ) begin
        if( prot_level === 3'hX )
          $display (" Error : STATUS REGISTER Non-Volatile information is not defined.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h7 )
          $display (" Warning : Entire chip area is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h6 )
          $display (" Warning : Address=1ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h5 )
          $display (" Warning : Address=0ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h2 )
          $display (" Warning : Address=3ffff~20000 is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h1 )
          $display (" Warning : Address=3ffff~30000 is write protected.  (Time=%.3f, %m)",$realtime);
        $display (" SMALL SECTOR ERASE is not executed.");
        for ( j = SSERS_START_ADD; j <= SSERS_START_ADD + 7; j = j + 1 ) begin
          $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
        end
        $display ("          :");
        $display ("          :");
        $display ("          :");
        $display ("Flashmemory Address=%h : Data=%h", SSERS_END_ADD-1, fmemory[SSERS_END_ADD-1]);
        $display ("Flashmemory Address=%h : Data=%h", SSERS_END_ADD-0, fmemory[SSERS_END_ADD]);
        $display ("          ");
      end
      else if( write_flag ) begin
        SSERASE = 1;
        $display (" SMALL SECTOR ERASE started ......  (Time= %.3f, %m)", $realtime);
        #tSSE SSERASE <= 0;  
        for ( j = SSERS_START_ADD; j <= SSERS_END_ADD; j = j + 1 ) begin
          fmemory[j] = 8'hFF;
        end
        $display (" SMALL SECTOR ERASE completed.  (Time= %.3f, %m)", $realtime );
        for ( j = SSERS_START_ADD; j <= SSERS_START_ADD + 7; j = j + 1 ) begin
          $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
        end
        $display ("          :");
        $display ("          :");
        $display ("          :");
        $display ("Flashmemory Address=%h : Data=%h", SSERS_END_ADD-1, fmemory[SSERS_END_ADD-1]);
        $display ("Flashmemory Address=%h : Data=%h", SSERS_END_ADD-0, fmemory[SSERS_END_ADD]);
        $display ("          ");
      end
    end
  end
  else if( SSERASE_CMD && SSERASE_preset && !four_bus_l && !WEN ) begin
    $display (" Warning : WEN bit is not set to 1 and hence SMALL SECTOR ERASE command was ignored.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    SSERASE_CMD  <=  0;
    SSERASE_preset <= 0;
  end
end

/* SECTOR ERASE */

initial begin
  SERASE <= 0;
  SERASE_preset <= 0;
  SERASE_CMD  <= 0;
  write_flag <= 0;
end

always @( posedge _CEB ) begin
  if( clk_count < 12'h20 && !clk_parity && SERASE_CMD && _CEB ) begin
    SERASE_CMD  <= 0;
    $display (" Error : SECTOR ERASE command ignored due to the transmitted data length is less than 4 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
  else if( clk_count == 12'h20 && !clk_parity && SERASE_CMD && _CEB ) begin
    SERASE_preset <= 1;
  end
  else if( ( clk_count > 12'h20 || clk_parity ) && SERASE_CMD && _CEB ) begin
    $display (" Error : SECTOR ERASE command ignored due to the transmitted data length is");
    $display ("        more than 4 bus cycles.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    SERASE_CMD  <=  0;
  end
end

always @( negedge WRT ) begin
  if( !WRT ) begin
    write_flag <= 0;
    j = 0;
    l = 0;
  end
end

always @( posedge SERASE_preset ) begin
  if( SERASE_CMD && SERASE_preset && !four_bus_l && WEN ) begin
    if( _CEB ) begin
      SERASE_preset = 0;
      SERASE_CMD  = 0;
      case( prot_level )
        3'hX : write_flag = 0;
        3'h7 : write_flag = 0;
        3'h6 : begin
                 if( ADDRESS_sers > 2'h1 )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h5 : begin
                 if( ADDRESS_sers > 2'h0 )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h2 : begin
                 if( ADDRESS_sers < 2'h2 )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h1 : begin
                 if( ADDRESS_sers < 2'h3 )
                   write_flag = 1;
                 else
                   write_flag = 0;
               end
        3'h0 : write_flag = 1;
        default write_flag = 0;
      endcase
      SERS_START_ADD = { ADDRESS_sers, 16'h0000 };
      SERS_END_ADD = { ADDRESS_sers, 16'hFFFF };
      if( ac_err_com_fg ) begin
        for ( j = SERS_START_ADD; j <= SERS_END_ADD; j = j + 1 ) begin
          fmemory[j] = 8'hXX;
        end
        $display (" Error : SECTOR ERASE failed due to AC violation in the input command sequence.");
        $display ("                                                    (Time=%.3f, %m)",$realtime);
        for ( j = SERS_START_ADD; j <= SERS_START_ADD + 7; j = j + 1 ) begin
          $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
        end
        $display ("          :");
        $display ("          :");
        $display ("          :");
        $display ("Flashmemory Address=%h : Data=%h", SERS_END_ADD-1, fmemory[SERS_END_ADD-1]);
        $display ("Flashmemory Address=%h : Data=%h", SERS_END_ADD-0, fmemory[SERS_END_ADD]);
        $display ("          ");
        ac_err_com_fg <= 0;
      end
      else if( !write_flag ) begin
        if( prot_level === 3'hX )
          $display (" Error : STATUS REGISTER Non-Volatile information is not defined.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h7 )
          $display (" Warning : Entire chip area is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h6 )
          $display (" Warning : Address=1ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h5 )
          $display (" Warning : Address=0ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h2 )
          $display (" Warning : Address=3ffff~20000 is write protected.  (Time=%.3f, %m)",$realtime);
        else if( prot_level == 3'h1 )
          $display (" Warning : Address=3ffff~30000 is write protected.  (Time=%.3f, %m)",$realtime);
        $display (" SECTOR ERASE is not executed.");
        for ( j = SERS_START_ADD; j <= SERS_START_ADD + 7; j = j + 1 ) begin
          $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
        end
        $display ("          :");
        $display ("          :");
        $display ("          :");
        $display ("Flashmemory Address=%h : Data=%h", SERS_END_ADD-1, fmemory[SERS_END_ADD-1]);
        $display ("Flashmemory Address=%h : Data=%h", SERS_END_ADD-0, fmemory[SERS_END_ADD]);
        $display ("          ");
      end
      else if( write_flag ) begin
        SERASE = 1;
        $display (" SECTOR ERASE started ......  (Time= %.3f, %m)", $realtime);
        #tSE SERASE <= 0;  
        for ( j = SERS_START_ADD; j <= SERS_END_ADD; j = j + 1 ) begin
          fmemory[j] = 8'hFF;
        end
        $display (" SECTOR ERASE completed.  (Time= %.3f, %m)", $realtime );
        for ( j = SERS_START_ADD; j <= SERS_START_ADD + 7; j = j + 1 ) begin
          $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
        end
        $display ("          :");
        $display ("          :");
        $display ("          :");
        $display ("Flashmemory Address=%h : Data=%h", SERS_END_ADD-1, fmemory[SERS_END_ADD-1]);
        $display ("Flashmemory Address=%h : Data=%h", SERS_END_ADD-0, fmemory[SERS_END_ADD]);
        $display ("          ");
      end
    end
  end
  else if( SERASE_CMD && SERASE_preset && !four_bus_l && !WEN ) begin
    $display (" Warning : WEN bit is not set to 1 and hence SECTOR ERASE command was ignored.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    SERASE_CMD  <=  0;
    SERASE_preset <= 0;
  end
end

/* CHIP ERASE */
 
initial begin
  CERASE <= 0;
  CERASE_CMD  <= 0;
end
 
always @( negedge WRT ) begin
  if( !WRT ) begin
    k = 0;
  end
end

always @( posedge _CEB or posedge CERASE_CMD ) begin
  if( CERASE_CMD  && !single_bus_l && _CEB && WEN ) begin
    CERASE_CMD = 0;
    case( prot_level )
      3'hX : write_flag = 0;
      3'h7 : write_flag = 0;
      3'h6 : write_flag = 0;
      3'h5 : write_flag = 0;
      3'h2 : write_flag = 0;
      3'h1 : write_flag = 0;
      3'h0 : write_flag = 1;
      default write_flag = 0;
    endcase
    if( ac_err_com_fg ) begin
      for ( k = 0; k < MEMORY_SIZE; k = k + 1 ) begin
        fmemory[k] = 8'hXX;
      end
      $display (" Error : CHIP ERASE failed due to AC violation in the input command sequence.");
      $display ("                                                  (Time=%.3f, %m)",$realtime);
      for ( j = 0; j <= 7; j = j + 1 ) begin
        $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
      end
      $display ("          :");
      $display ("          :");
      $display ("          :");
      $display ("Flashmemory Address=%h : Data=%h", MEMORY_SIZE-2, fmemory[MEMORY_SIZE-2]);
      $display ("Flashmemory Address=%h : Data=%h", MEMORY_SIZE-1, fmemory[MEMORY_SIZE-1]);
      $display ("          ");
      ac_err_com_fg <= 0;
    end
    else if( !write_flag ) begin
      if( prot_level === 3'hX )
        $display (" Error : STATUS REGISTER Non-Volatile information is not defined.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h7 )
        $display (" Warning : Entire chip area is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h6 )
          $display (" Warning : Address=1ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h5 )
          $display (" Warning : Address=0ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h2 )
        $display (" Warning : Address=3ffff~20000 is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h1 )
        $display (" Warning : Address=3ffff~30000 is write protected.  (Time=%.3f, %m)",$realtime);
      $display (" CHIP ERASE is not executed.");
      for ( j = 0; j <= 7; j = j + 1 ) begin
        $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
      end
      $display ("          :");
      $display ("          :");
      $display ("          :");
      $display ("Flashmemory Address=%h : Data=%h", MEMORY_SIZE-2, fmemory[MEMORY_SIZE-2]);
      $display ("Flashmemory Address=%h : Data=%h", MEMORY_SIZE-1, fmemory[MEMORY_SIZE-1]);
      $display ("          ");
    end
    else if( write_flag ) begin
      CERASE  = 1;
      $display (" CHIP ERASE started......  (Time= %.3f, %m)", $realtime);
      #tCHE CERASE <= 0;
      for ( k = 0; k < MEMORY_SIZE; k = k + 1 ) begin
        fmemory[k] = 8'hFF;
      end
      $display (" CHIP ERASE completed.  (Time= %.3f, %m)", $realtime );
      for ( j = 0; j <= 7; j = j + 1 ) begin
        $display ("Flashmemory Address=%h : Data=%h", j, fmemory[j]);
      end
      $display ("          :");
      $display ("          :");
      $display ("          :");
      $display ("Flashmemory Address=%h : Data=%h", MEMORY_SIZE-2, fmemory[MEMORY_SIZE-2]);
      $display ("Flashmemory Address=%h : Data=%h", MEMORY_SIZE-1, fmemory[MEMORY_SIZE-1]);
      $display ("           ");
    end
  end
  else if( CERASE_CMD && !single_bus_l && _CEB && !WEN ) begin
    $display (" Warning : WEN bit is not set to 1 and hence CHIP ERASE command was ignored.  (Time=%.3f, %m)",$realtime); 
    $display ("          ");
    CERASE_CMD  <=  0;
  end
  else if( CERASE_CMD && single_bus_l && _CEB && WEN ) begin
    $display (" Error : CHIP ERASE command ignored due to the transmitted data length is");
    $display ("        more than 1 bus cycle.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    CERASE_CMD  <=  0;
  end
end

/////////////////////////////////////
//       PROG  mode                //
/////////////////////////////////////
 
/* Prog Address latch */
 
always @( posedge _CEB ) begin
  if( clk_count < 12'h20 && !clk_parity && PROG_CMD && _CEB ) begin
    $display (" Error : Input command sequence less than 4 bus cycles and hence PAGE PROGRAM command was ignored.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    PROG_CMD  <= 0;
  end
  else if( clk_count == 12'h20 && !clk_parity && PROG_CMD &_CEB ) begin
    $display (" Error : No program data supplied and hence PAGE PROGRAM command was ignored.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
    PROG_CMD  <= 0;
  end
  else if( ( clk_count > 12'h20 || clk_parity ) && every8bit && PROG_CMD && _CEB ) begin
    PROG_preset <= 1;
  end
  else if( ( clk_count > 12'h20 || clk_parity ) && !every8bit && PROG_CMD && _CEB ) begin
    PROG_CMD  = 0;
    $display (" Error : PAGE PROGRAM command ignored due to the last transmitted data before _CEB going high is");
    $display ("        less or more than a byte unit.  (Time=%.3f, %m)",$realtime);
    $display ("          ");
  end
end

always @( posedge _SCK ) begin
  if( clk_count == 12'h20 && !clk_parity && PROG_CMD && !_CEB ) begin
    ADDRESS_prg <= ADDRESS;
  end
end

/* PAGE PROG */
 
initial begin
  PROG <= 0;
  PROG_preset <= 0;
  PROG_CMD  <= 0;
end

always @( posedge PROG_preset ) begin
  if( PROG_CMD && PROG_preset && PG_data_entry_complete && WEN ) begin
    PROG_preset = 0;
    PROG_CMD  = 0;
    no_erase_dat_fg = 0;
    no_erase_fg = 0;

    ADDRESS_page = ADDRESS_prg[ADDRESS_SIZE-1:8];
    ADDRESS_inc = ADDRESS_prg[7:0];

    case( prot_level )
      3'hX : write_flag = 0;
      3'h7 : write_flag = 0;
      3'h6 : begin
               if( ADDRESS_page > 10'h1FF )
                 write_flag = 1;
               else
                 write_flag = 0;
             end
      3'h5 : begin
               if( ADDRESS_page > 10'h0FF )
                 write_flag = 1;
               else
                 write_flag = 0;
             end
      3'h2 : begin
               if( ADDRESS_page < 10'h200 )
                 write_flag = 1;
               else
                 write_flag = 0;
             end
      3'h1 : begin
               if( ADDRESS_page < 10'h300 )
                 write_flag = 1;
               else
                 write_flag = 0;
             end
      3'h0 : write_flag = 1;
    endcase

    if( ac_err_com_fg ) begin
      PROG <= 0;
      $display (" Error : PAGE PROGRAM failed due to AC violation in the input command sequence.");
      $display ("                                                    (Time= %.3f, %m)", $realtime);
      ADDRESS_inc = ADDRESS_inc + l;
      for ( n = j; n > l; n = n - 1 ) begin
        PG_PROG_STORE_ADD = { ADDRESS_page, ADDRESS_inc };
        fmemory[PG_PROG_STORE_ADD] = 8'hXX;
        $display ("Flashmemory Address=%h : Data=%h", PG_PROG_STORE_ADD, fmemory[PG_PROG_STORE_ADD]);
        ADDRESS_inc = ADDRESS_inc + 1;
      end
      $display ("          ");
      ac_err_com_fg <= 0;
    end
    else if( !write_flag ) begin
      if( prot_level === 3'hX )
        $display (" Error : STATUS REGISTER Non-Volatile information is not defined.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h7 )
        $display (" Warning : Entire chip area is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h6 )
          $display (" Warning : Address=1ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h5 )
          $display (" Warning : Address=0ffff~00000 is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h2 )
        $display (" Warning : Address=3ffff~20000 is write protected.  (Time=%.3f, %m)",$realtime);
      else if( prot_level == 3'h1 )
        $display (" Warning : Address=3ffff~30000 is write protected.  (Time=%.3f, %m)",$realtime);
      $display (" PAGE PROGRAM is not executed.");
      ADDRESS_inc = ADDRESS_inc + l;
      for ( n = j; n > l; n = n - 1 ) begin
        PG_PROG_STORE_ADD = { ADDRESS_page, ADDRESS_inc };
        $display ("Flashmemory Address=%h : Data=%h", PG_PROG_STORE_ADD, fmemory[PG_PROG_STORE_ADD]);
        ADDRESS_inc = ADDRESS_inc + 1;
      end
      $display ("          ");
    end
    else if( write_flag ) begin
      PROG = 1;
      for(y = 0; y < j; y = y + 1 ) begin
        for(x = 0; x < 8; x = x + 1)
          tmp[x] = fmpage[8*y+x];
        page[y] = tmp;
      end    
      ADDRESS_inc = ADDRESS_inc + l;
      for ( n = j; n > l; n = n - 1 ) begin
        PG_PROG_STORE_ADD = { ADDRESS_page, ADDRESS_inc };
        befor_data = fmemory[PG_PROG_STORE_ADD];
        if( befor_data === 8'hXX ) begin
          no_erase_dat_fg = 1;
          n = 0;
        end
        else if( befor_data !== 8'hFF ) begin
          no_erase_fg = 1;
          n = 0;
        end
          ADDRESS_inc = ADDRESS_inc + 1;
      end 

      ADDRESS_page = ADDRESS_prg[ADDRESS_SIZE-1:8];
      ADDRESS_inc = ADDRESS_prg[7:0];
      if( no_erase_dat_fg ) begin
        PROG <= 0;
        $display (" Error : You have to execute ERASE at the requested addresses before PAGE PROGRAM command execute.  (Time= %.3f, %m)", $realtime);
        ADDRESS_inc = ADDRESS_inc + l;
        for ( n = j; n > l; n = n - 1 ) begin
          PG_PROG_STORE_ADD = { ADDRESS_page, ADDRESS_inc };
          fmemory[PG_PROG_STORE_ADD] = 8'hXX;
          $display ("Flashmemory Address=%h : Data=%h", PG_PROG_STORE_ADD, fmemory[PG_PROG_STORE_ADD]);
          ADDRESS_inc = ADDRESS_inc + 1;
        end
        $display ("          ");
      end
      else if( no_erase_fg ) begin
        PROG <= 0;
        $display (" Error : PAGE PROGRAM failed because there is some data other than FFh at the requested addresses.");
        $display ("                                                                         (Time= %.3f, %m)", $realtime);
        ADDRESS_inc = ADDRESS_inc + l;
        for ( n = j; n > l; n = n - 1 ) begin
          PG_PROG_STORE_ADD = { ADDRESS_page, ADDRESS_inc };
          fmemory[PG_PROG_STORE_ADD] = 8'hXX;
          $display ("Flashmemory Address=%h : Data=%h", PG_PROG_STORE_ADD, fmemory[PG_PROG_STORE_ADD]);
            ADDRESS_inc = ADDRESS_inc + 1;
        end
        $display ("          ");
      end
      else begin  
        $display(" PAGE PROGRAM started ......  (Time=%.3f, %m)",$realtime) ;
        #tPP PROG <= 0;
        ADDRESS_inc = ADDRESS_inc + l;
        $display (" PAGE PROGRAM completed.  (Time= %.3f, %m)", $realtime );
        for ( n = j; n > l; n = n - 1 ) begin
          PG_PROG_STORE_ADD = { ADDRESS_page, ADDRESS_inc };
          fmemory[PG_PROG_STORE_ADD] = page[n-l-1];
          $display ("Flashmemory Address=%h : Data=%h", PG_PROG_STORE_ADD, fmemory[PG_PROG_STORE_ADD]);
          ADDRESS_inc = ADDRESS_inc + 1;
        end
        $display ("          ");
      end
    end    
  end
  else if( PROG_CMD && PROG_preset && PG_data_entry_complete && !WEN ) begin
    $display (" Warning : WEN bit is not set to 1 and hence PAGE PROGRAM command was ignored.  (Time=%.3f, %m)",$realtime); 
    $display ("          ");
    PROG_CMD  <= 0;
    PROG_preset <= 0;
  end
end

/////////////////////////////////////
//    Timing check                 //
/////////////////////////////////////

not I0 ( cs, CEB );
buf I1 ( pdown_entry, PDOWN_ENTRY );
buf I2 ( pdown_release, PDOWN_RELEASE );
or  I5 ( read_output, READ, STATUS_READ, IDREAD_9F, IDREAD_AB );
and I6 ( command_entry, cs, ~read_output );
buf I7 ( read_03h, READ4_CMD );

initial begin
  ac_err_com_fg <= 0;
  error_tHS_fg <= 0;
  error_tHH_fg <= 0;
  error_tCLHI <= 0;
  error_tCLLO <= 0;
  error_tCLHI2 <= 0;
  error_tCLLO2 <= 0;
  error_tCSS <= 0;
  error_tCSH <= 0;
  error_tDS <= 0;
  error_tDH <= 0;
  error_tCPH <= 0;
  error_tHS <= 0;
  error_tHH <= 0;
  error_tWPS <= 0;
  error_tWPH <= 0;
  error_tDP <= 0;
  error_tPRB <= 0;
end

always @( error_tCLHI or error_tCLLO or error_tCLHI2 or error_tCLLO2 or error_tCSS or error_tCSH or error_tDS or error_tDH or error_tCPH or error_tHS or error_tHH or error_tWPS or error_tWPH or error_tDP or error_tPRB ) begin
  if ( error_tCLHI || error_tCLLO || error_tCLHI2 || error_tCLLO2 || error_tCSS || error_tCSH || error_tDS || error_tDH || error_tCPH || error_tHS || error_tHH || error_tWPS || error_tWPH || error_tDP || error_tPRB ) begin
    ac_err_com_fg <= 1;
  end
end

always @( error_tHS or posedge _CEB ) begin
  if( _CEB )
    error_tHS_fg <= 0;
  else 
    error_tHS_fg <= 1;
end

always @( error_tHH or posedge _CEB ) begin
  if( _CEB )
    error_tHH_fg <= 0;
  else 
    error_tHH_fg <= 1;
end

specify

 specparam tCLHI = `tCLHI_TIME;
 specparam tCLLO = `tCLLO_TIME;
 specparam tCLHI2 = `tCLHI2_TIME;
 specparam tCLLO2 = `tCLLO2_TIME;
 specparam tCSS = `tCSS_TIME;
 specparam tCSH = `tCSH_TIME;
 specparam tDS = `tDS_TIME;
 specparam tDH = `tDH_TIME;
 specparam tCPH = `tCPH_TIME;
 specparam tHS   = `tHS_TIME;
 specparam tHH   = `tHH_TIME;
 specparam tWPS  = `tWPS_TIME;
 specparam tWPH  = `tWPH_TIME;
 specparam tDP   = `tDP_TIME;
 specparam tPRB  = `tPRB_TIME;

  $width ( posedge SCK, tCLHI, 0, error_tCLHI );
  $width ( negedge SCK, tCLLO, 0, error_tCLLO );
  $width ( posedge SCK &&& read_03h, tCLHI2, 0, error_tCLHI2 );
  $width ( negedge SCK &&& read_03h, tCLLO2, 0, error_tCLLO2 );
  $setup ( CEB, posedge SCK, tCSS, error_tCSS );
  $hold ( posedge SCK, CEB, tCSH, error_tCSH );
  $setup ( SI &&& command_entry, posedge SCK, tDS, error_tDS );
  $hold ( posedge SCK, SI &&& command_entry, tDH, error_tDH );
  $width ( posedge CEB, tCPH, 0, error_tCPH );
  $setup ( HOLDB, posedge SCK, tHS, error_tHS );
  $hold ( negedge SCK, HOLDB, tHH, error_tHH );
  $setup ( WPB, negedge CEB, tWPS, error_tWPS );
  $hold ( posedge CEB, WPB, tWPH, error_tWPH );
  $width ( posedge pdown_entry, tDP, 0, error_tDP );
  $width ( posedge pdown_release, tPRB, 0, error_tPRB );

endspecify

//`endprotect

endmodule


