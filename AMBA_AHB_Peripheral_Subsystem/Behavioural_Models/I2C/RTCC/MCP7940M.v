// *******************************************************************************************************
// **                                                                                                   **
// **   MCP7940M.v - MCP7940M I2C RTC/CALENDAR/SRAM (VCC = +1.8V TO +5.5V)                              **
// **                                                                                                   **
// *******************************************************************************************************
// **                                                                                                   **
// **                   This information is distributed under license from Young Engineering.           **
// **                              COPYRIGHT (c) 2020 YOUNG ENGINEERING                                 **
// **                                      ALL RIGHTS RESERVED                                          **
// **                                                                                                   **
// **   Young Engineering provides design expertise for the digital world                               **
// **   Started in 1990, Young Engineering offers products and services for your electronic design      **
// **   project.  We have the expertise in PCB, FPGA, ASIC, firmware, and software design.              **
// **   From concept to prototype to production, we can help you.                                       **
// **                                                                                                   **
// **   http://www.young-engineering.com/                                                               **
// **                                                                                                   **
// *******************************************************************************************************
// **   This information is provided to you for your convenience and use with Microchip products only.  **
// **   Microchip disclaims all liability arising from this information and its use.                    **
// **                                                                                                   **
// **   THIS INFORMATION IS PROVIDED "AS IS." MICROCHIP MAKES NO REPRESENTATION OR WARRANTIES OF        **
// **   ANY KIND WHETHER EXPRESS OR IMPLIED, WRITTEN OR ORAL, STATUTORY OR OTHERWISE, RELATED TO        **
// **   THE INFORMATION PROVIDED TO YOU, INCLUDING BUT NOT LIMITED TO ITS CONDITION, QUALITY,           **
// **   PERFORMANCE, MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR PURPOSE.                         **
// **   MICROCHIP IS NOT LIABLE, UNDER ANY CIRCUMSTANCES, FOR SPECIAL, INCIDENTAL OR CONSEQUENTIAL      **
// **   DAMAGES, FOR ANY REASON WHATSOEVER.                                                             **
// **                                                                                                   **
// **   It is your responsibility to ensure that your application meets with your specifications.       **
// **                                                                                                   **
// *******************************************************************************************************
// **   Revision       : 1.0                                                                            **
// **   Modified Date  : 12/16/2020                                                                     **
// **   Revision History:                                                                               **
// **                                                                                                   **
// **   12/16/2020:  Initial design                                                                     **
// **                                                                                                   **
// *******************************************************************************************************
// **                                       TABLE OF CONTENTS                                           **
// *******************************************************************************************************
// **---------------------------------------------------------------------------------------------------**
// **   DECLARATIONS                                                                                    **
// **---------------------------------------------------------------------------------------------------**
// **---------------------------------------------------------------------------------------------------**
// **   INITIALIZATION                                                                                  **
// **---------------------------------------------------------------------------------------------------**
// **---------------------------------------------------------------------------------------------------**
// **   I/O LOGIC - XTAL                                                                                **
// **---------------------------------------------------------------------------------------------------**
// **   1.01:  Xtal2 Output                                                                             **
// **   1.02:  Oscillator Clock Divider                                                                 **
// **   1.03:  Digital Trimming                                                                         **
// **   1.04:  Oscillator Active Detect                                                                 **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   I/O LOGIC - I2C                                                                                 **
// **---------------------------------------------------------------------------------------------------**
// **   2.01:  START Bit Detection                                                                      **
// **   2.02:  STOP Bit Detection                                                                       **
// **   2.03:  Power Loss Detection                                                                     **
// **   2.04:  Input Shift Register                                                                     **
// **   2.05:  Input Bit Counter                                                                        **
// **   2.06:  Control Byte Processor                                                                   **
// **   2.07:  Address Byte Processor                                                                   **
// **   2.08:  Write Data Buffer                                                                        **
// **   2.09:  Write Acknowledge Generator                                                              **
// **   2.10:  Acknowledge Detect                                                                       **
// **   2.11:  STOP Flag Removal                                                                        **
// **   2.12:  Read Data Processor                                                                      **
// **   2.13:  Read Data Increment                                                                      **
// **   2.14:  SDA Data I/O Buffer                                                                      **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   I/O LOGIC - MFP                                                                                 **
// **---------------------------------------------------------------------------------------------------**
// **   3.01:  Output Pin Open-Drain Driver                                                             **
// **   3.02:  Output Pin Signal Select                                                                 **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   CORE LOGIC - RTCC                                                                               **
// **---------------------------------------------------------------------------------------------------**
// **   4.01:  RTCC Register Reset                                                                      **
// **   4.02:  RTCC Control and Data Registers Write Logic                                              **
// **   4.03:  RTCC Time and Date - Seconds                                                             **
// **   4.04:  RTCC Time and Date - Minutes                                                             **
// **   4.05:  RTCC Time and Date - Hours                                                               **
// **   4.06:  RTCC Time and Date - Days                                                                **
// **   4.07:  RTCC Time and Date - Year/Month/Date                                                     **
// **   4.08:  RTCC Time and Date - Status Signals                                                      **
// **   4.09:  RTCC Alarm #0 Logic                                                                      **
// **   4.10:  RTCC Alarm #1 Logic                                                                      **
// **   4.11:  RTCC Alarm Output Signal                                                                 **
// **   4.12:  RTCC Power Fail Detect                                                                   **
// **   4.13:  RTCC Read Data Multiplexor                                                               **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   CORE LOGIC - SRAM                                                                               **
// **---------------------------------------------------------------------------------------------------**
// **   5.01:  SRAM Write Logic                                                                         **
// **   5.02:  SRAM Read Logic                                                                          **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   LOGIC FUNCTIONS                                                                                 **
// **---------------------------------------------------------------------------------------------------**
// **   6.01:  DateNext - Compute the Next Year-Month-Date                                              **
// **   6.02:  BCDtoHex - Convert BCD to Hex Value                                                      **
// **   6.03:  HexToBCD - Convert Hex to BCD Value                                                      **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   DEBUG LOGIC                                                                                     **
// **---------------------------------------------------------------------------------------------------**
// **   7.01:  SRAM Memory Data Bytes                                                                   **
// **                                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **   TIMING CHECKS                                                                                   **
// **---------------------------------------------------------------------------------------------------**
// **                                                                                                   **
// *******************************************************************************************************


`timescale 1ns/10ps

// The following defines select which I2C timing set to use.
//`define I2C_100KHZ_TIMING                             // Uncomment to select 100 kHz timing set
`define I2C_400KHZ_TIMING                               // Uncomment to select 400 kHz timing set

module MCP7940M (X1, X2, MFP, SDA, SCL, VCC, RESET);

   input                X1;                             // crystal/external oscillator input
   output               X2;                             // crystal output

   output               MFP;                            // multi-function pin (open-drain)

   inout                SDA;                            // serial data I/O
   input                SCL;                            // serial data clock

   input                VCC;                            // primary power pin

   input                RESET;                          // system reset (disable timing checks)


// *******************************************************************************************************
// **   DECLARATIONS                                                                                    **
// *******************************************************************************************************

   parameter            CTRL_BYTE_RTCCSR = 7'b1101111;  // control byte for RTCC/SRAM access

   integer              T_AA;                           // timing parameter

// .......................................................................................................

   reg  [14:00]         OscDivider;                     // oscillator clock divider
   wire                 OscDividerEn;                   // oscillator clock divider enable
   reg  [16:00]         OscFailCount;                   // oscillator failure detect counter
   wire                 Clk1Hz;                         // internal clock
   wire                 Clk64Hz;                        // internal clock
   wire                 Clk4096Hz;                      // internal clock
   wire                 Clk8192Hz;                      // internal clock
   wire                 Clk32768Hz;                     // internal clock

   reg                  Clk1Hz_D1;                      // internal clock - delayed 1ns

   reg  [07:00]         OscTrimCount;                   // oscillator digital trim counter
   
   reg                  TrimOp;                         // trim operation flag
   
// .......................................................................................................

   reg                  SDA_DO;                         // I2C serial data - output
   reg                  SDA_OE;                         // I2C serial data - output enable

   wire                 SDA_DriveEnable;                // I2C serial data output enable
   reg                  SDA_DriveEnableDlyd;            // I2C serial data output enable - delayed

   reg  [03:00]         I2C_BitCounter;                 // I2C serial bit counter
   
   reg                  STRT_Rcvd;                      // START bit received flag
   reg                  STOP_Rcvd;                      // STOP bit received flag
   reg                  CTRL_Rcvd;                      // control byte received flag
   reg                  ADDR_Rcvd;                      // byte address received flag
   reg                  MACK_Rcvd;                      // master acknowledge received flag

   reg                  RTCCSR_Access;                  // RTCC/SRAM access operation

   reg                  WrOperation;                    // memory write operation
   reg                  RdOperation;                    // memory read operation

   reg  [07:00]         DataShifter;                    // input data shift register

   reg  [07:00]         ControlByte;                    // control byte register
   wire                 CTRL_Valid;                     // control byte valid

   reg                  I2C_FirstRead;                  // I2C first data read flag

   reg  [07:00]         AddressPointer;                 // memory access address pointer
   reg  [07:00]         ByteCounter;                    // memory access byte counter

   wire                 AddressValid;                   // valid address

   wire [07:00]         RdDataByte;                     // I2C read data

   reg  [07:00]         RTCCSR_WrData;                  // RTCC/SRAM write data
   event                RTCC_WrEvent;                   // RTCC write event
   event                SRAM_WrEvent;                   // SRAM write event
   event                POR_Event;                      // POR event

// .......................................................................................................

   wire                 MFP;                            // multi-function output pin
   reg                  MFP_DO;                         // multi-function output signal

// .......................................................................................................

   reg  [07:00]         RTCC_Memory [00:31];            // RTCC registers
   reg  [07:00]         RTCC_RDBuffer [00:31];          // RTCC read buffer
 
   wire [07:00]         RTCC_RTCSEC = RTCC_Memory[0];                               // timekeeping seconds register
   wire                 RTCC_ST = RTCC_Memory[0][7];                                // start oscillator bit
   wire [02:00]         RTCC_RTCSECTEN = RTCC_Memory[0][6:4];                       // timekeeping second's tens digit
   wire [03:00]         RTCC_RTCSECONE = RTCC_Memory[0][3:0];                       // timekeeping second's ones digit
   
   wire [07:00]         RTCC_RTCMIN = RTCC_Memory[1];                               // timekeeping minutes register
   wire [02:00]         RTCC_RTCMINTEN = RTCC_Memory[1][6:4];                       // timekeeping minute's tens digit
   wire [03:00]         RTCC_RTCMINONE = RTCC_Memory[1][3:0];                       // timekeeping minute's ones digit
   
   wire [07:00]         RTCC_RTCHOUR = RTCC_Memory[2];                              // timekeeping hours register
   wire                 RTCC_RTC1224 = RTCC_Memory[2][6];                           // timekeeping 12/24 hour format
   wire                 RTCC_RTCAMPM = RTCC_Memory[2][5];                           // timekeeping AM/PM flag
   wire [01:00]         RTCC_RTCHRTEN = RTCC_RTC1224 ? {1'b0,RTCC_Memory[2][4]} :   // timekeeping hour's tens digit
                                                       RTCC_Memory[2][5:4];
   wire [03:00]         RTCC_RTCHRONE = RTCC_Memory[2][3:0];                        // timekeeping hour's ones digit
   
   wire [07:00]         RTCC_RTCWKDAY = RTCC_Memory[3];                             // timekeeping weekday register
   wire                 RTCC_OSCRUN = RTCC_Memory[3][5];                            // oscillator status bit
   wire [02:00]         RTCC_RTCWKDAYBITS = RTCC_Memory[3][2:0];                    // timekeeping day of week
   
   wire [07:00]         RTCC_RTCDATE = RTCC_Memory[4];                              // timekeeping date register
   wire [01:00]         RTCC_RTCDATETEN = RTCC_Memory[4][5:4];                      // timekeeping date's tens digit
   wire [03:00]         RTCC_RTCDATEONE = RTCC_Memory[4][3:0];                      // timekeeping date's ones digit
   
   wire [07:00]         RTCC_RTCMTH = RTCC_Memory[5];                               // timekeeping month register
   wire                 RTCC_RTCLPYR = RTCC_Memory[5][5];                           // timekeeping leap year flag
   wire                 RTCC_RTCMTHTEN = RTCC_Memory[5][4];                         // timekeeping month's tens digit
   wire [03:00]         RTCC_RTCMTHONE = RTCC_Memory[5][3:0];                       // timekeeping month's ones digit
   
   wire [07:00]         RTCC_RTCYEAR = RTCC_Memory[6];                              // timekeeping year register
   wire [03:00]         RTCC_YRTEN = RTCC_Memory[6][7:4];                           // timekeeping year's tens digit
   wire [03:00]         RTCC_YRONE = RTCC_Memory[6][3:0];                           // timekeeping year's ones digit
   
   wire [07:00]         RTCC_CONTROL = RTCC_Memory[7];                              // control register
   wire                 RTCC_OUT = RTCC_Memory[7][7];                               // general purpose output logic level
   wire                 RTCC_SQWEN = RTCC_Memory[7][6];                             // square wave output enable
   wire                 RTCC_ALM1EN = RTCC_Memory[7][5];                            // alarm 1 enable
   wire                 RTCC_ALM0EN = RTCC_Memory[7][4];                            // alarm 0 enable
   wire                 RTCC_EXTOSC = RTCC_Memory[7][3];                            // external oscillator enable
   wire                 RTCC_CRSTRIM = RTCC_Memory[7][2];                           // coarse trim mode enable
   wire [01:00]         RTCC_SQWFS = RTCC_Memory[7][1:0];                           // square wave clock output frequency select
   
   wire [07:00]         RTCC_OSCTRIM = RTCC_Memory[8];                              // oscillator digital trim register
   wire                 RTCC_SIGN = RTCC_Memory[8][7];                              // trim sign bit
   wire [06:00]         RTCC_TRIMVAL = RTCC_Memory[8][6:0];                         // oscillator trim value
   
   wire [07:00]         RTCC_ALM0SEC = RTCC_Memory[10];                             // alarm 0 seconds register
   wire [02:00]         RTCC_ALM0SECTEN = RTCC_Memory[10][6:4];                     // alarm 0 second's tens digit
   wire [03:00]         RTCC_ALM0SECONE = RTCC_Memory[10][3:0];                     // alarm 0 second's ones digit
   
   wire [07:00]         RTCC_ALM0MIN = RTCC_Memory[11];                             // alarm 0 minutes register
   wire [02:00]         RTCC_ALM0MINTEN = RTCC_Memory[11][6:4];                     // alarm 0 minute's tens digit
   wire [03:00]         RTCC_ALM0MINONE = RTCC_Memory[11][3:0];                     // alarm 0 minute's ones digit
   
   wire [07:00]         RTCC_ALM0HOUR = RTCC_Memory[12];                            // alarm 0 hours register
   wire                 RTCC_ALM01224 = RTCC_Memory[2][6];                          // alarm 0 12/24 hour format
   wire                 RTCC_ALM0AMPM = RTCC_Memory[12][5];                         // alarm 0 AM/PM flag
   wire [01:00]         RTCC_ALM0HRTEN = RTCC_ALM01224 ? {1'b0,RTCC_Memory[12][4]} :    // alarm 0 hour's tens digit
                                                         RTCC_Memory[12][5:4];
   wire [03:00]         RTCC_ALM0HRONE = RTCC_Memory[12][3:0];                      // alarm 0 hour's ones digit
   
   wire [07:00]         RTCC_ALM0WKDAY = RTCC_Memory[13];                           // alarm 0 weekday register
   wire                 RTCC_ALM0ALMPOL = RTCC_Memory[13][7];                       // alarm 0 interrupt output polarity
   wire [02:00]         RTCC_ALM0MSK = RTCC_Memory[13][6:4];                        // alarm 0 mask bits
   wire                 RTCC_ALM0IF = RTCC_Memory[13][3];                           // alarm 0 interrupt flag
   wire [02:00]         RTCC_ALM0WKDAYBITS = RTCC_Memory[13][2:0];                  // alarm 0 day of week
   
   wire [07:00]         RTCC_ALM0DATE = RTCC_Memory[14];                            // alarm 0 date register
   wire [01:00]         RTCC_ALM0DATETEN = RTCC_Memory[14][5:4];                    // alarm 0 date's tens digit
   wire [03:00]         RTCC_ALM0DATEONE = RTCC_Memory[14][3:0];                    // alarm 0 date's ones digit
   
   wire [07:00]         RTCC_ALM0MTH = RTCC_Memory[15];                             // alarm 0 month register
   wire                 RTCC_ALM0MTHTEN = RTCC_Memory[15][4];                       // alarm 0 month's tens digit
   wire [03:00]         RTCC_ALM0MTHONE = RTCC_Memory[15][3:0];                     // alarm 0 month's ones digit
 
   wire [07:00]         RTCC_ALM1SEC = RTCC_Memory[17];                             // alarm 1 seconds register
   wire [02:00]         RTCC_ALM1SECTEN = RTCC_Memory[17][6:4];                     // alarm 1 second's tens digit
   wire [03:00]         RTCC_ALM1SECONE = RTCC_Memory[17][3:0];                     // alarm 1 second's ones digit
   
   wire [07:00]         RTCC_ALM1MIN = RTCC_Memory[18];                             // alarm 1 minutes register
   wire [02:00]         RTCC_ALM1MINTEN = RTCC_Memory[18][6:4];                     // alarm 1 minute's tens digit
   wire [03:00]         RTCC_ALM1MINONE = RTCC_Memory[18][3:0];                     // alarm 1 minute's ones digit
   
   wire [07:00]         RTCC_ALM1HOUR = RTCC_Memory[19];                            // alarm 1 hours register
   wire                 RTCC_ALM11224 = RTCC_Memory[2][6];                          // alarm 1 12/24 hour format
   wire                 RTCC_ALM1AMPM = RTCC_Memory[19][5];                         // alarm 1 AM/PM flag
   wire [01:00]         RTCC_ALM1HRTEN = RTCC_ALM11224 ? {1'b0,RTCC_Memory[19][4]} :    // alarm 1 hour's tens digit
                                                         RTCC_Memory[19][5:4];
   wire [03:00]         RTCC_ALM1HRONE = RTCC_Memory[19][3:0];                      // alarm 1 hour's ones digit
   
   wire [07:00]         RTCC_ALM1WKDAY = RTCC_Memory[20];                           // alarm 1 weekday register
   wire                 RTCC_ALM1ALMPOL = RTCC_Memory[13][7];                       // alarm 1 interrupt output polarity
   wire [02:00]         RTCC_ALM1MSK = RTCC_Memory[20][6:4];                        // alarm 1 mask bits
   wire                 RTCC_ALM1IF = RTCC_Memory[20][3];                           // alarm 1 interrupt flag
   wire [02:00]         RTCC_ALM1WKDAYBITS = RTCC_Memory[20][2:0];                  // alarm 1 day of week
   
   wire [07:00]         RTCC_ALM1DATE = RTCC_Memory[21];                            // alarm 1 date register
   wire [01:00]         RTCC_ALM1DATETEN = RTCC_Memory[21][5:4];                    // alarm 1 date's tens digit
   wire [03:00]         RTCC_ALM1DATEONE = RTCC_Memory[21][3:0];                    // alarm 1 date's ones digit
   
   wire [07:00]         RTCC_ALM1MTH = RTCC_Memory[22];                             // alarm 1 month register
   wire                 RTCC_ALM1MTHTEN = RTCC_Memory[22][4];                       // alarm 1 month's tens digit
   wire [03:00]         RTCC_ALM1MTHONE = RTCC_Memory[22][3:0];                     // alarm 1 month's ones digit

   wire                 IsMidnight;                     // midnight 12AM flag

   reg                  Alarm0_True;                    // alarm condition true
   reg                  Alarm1_True;                    // alarm condition true

   reg                  RTCC_AlarmOut;                  // alarm output signal
   
   event                SecRollover;                    // seconds rollover event
   event                MinRollover;                    // minutes rollover event
   event                HourRollover;                   // hours rollover event

   reg  [07:00]         RTCCSR_RdData;                  // multiplexed read data

// .......................................................................................................

   reg  [07:00]         SRAM_Memory [0:63];             // SRAM memory array
   wire [07:00]         SRAM_RdData;                    // SRAM memory read data
   wire [05:00]         SRAM_Address;                   // SRAM memory address

// *******************************************************************************************************
// **   INITIALIZATION                                                                                  **
// *******************************************************************************************************

   initial begin
      `ifdef I2C_100KHZ_TIMING      // 100 kHz timing
         T_AA = 3500;               // SCL to SDA output delay
      `else
      `ifdef I2C_400KHZ_TIMING      // 400 kHz timing
         T_AA = 900;                // SCL to SDA output delay
      `else                         // No timing specified, default to 400 kHz
         T_AA = 900;                // SCL to SDA output delay
      `endif
      `endif
   end

   initial begin
      OscDivider   = 0;
      OscTrimCount = 0;
      
      TrimOp = 0;
   end

   initial begin
      SDA_DO = 0;
      SDA_OE = 0;
   end

   initial begin
      STRT_Rcvd = 0;
      STOP_Rcvd = 0;
      CTRL_Rcvd = 0;
      ADDR_Rcvd = 0;
      MACK_Rcvd = 0;
   end

   initial begin
      I2C_BitCounter = 0;
      ControlByte = 0;
      AddressPointer = 0;
   end

   initial begin
      WrOperation = 0;
      RdOperation = 0;

      RTCCSR_Access = 0;
   end

   initial
       ->POR_Event;


// *******************************************************************************************************
// **   I/O LOGIC - XTAL                                                                                **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      1.01:  Xtal2 Output
// -------------------------------------------------------------------------------------------------------

   assign X2 = RTCC_EXTOSC ? 1'bZ : !X1;

// -------------------------------------------------------------------------------------------------------
//      1.02:  Oscillator Clock Divider
// -------------------------------------------------------------------------------------------------------

   assign OscDividerEn = RTCC_ST | RTCC_EXTOSC;
   
   always @(posedge OscDividerEn) begin
      OscDivider <= 0;
   end

   always @(posedge X1) begin
      if (OscDividerEn) begin
         if (OscTrimCount[6:0] > 7'h0) begin
            if (OscTrimCount[7]) begin              // Add clocks to correct for slow time
               OscDivider <= OscDivider + {1'b0,OscTrimCount[6:0]} + 1;
               OscTrimCount[6:0] <= 7'h0;
            end
            else begin                              // Suppress clocks to correct for fast time
               OscTrimCount[6:0] <= OscTrimCount[6:0] - 1;
               // Intentionally skip incrementing OscDivider here to suppress this clock cycle
            end
         end
         else
            OscDivider <= OscDivider + 1;
      end
   end

   assign Clk32768Hz = X1;
   assign Clk8192Hz  = OscDivider[01];
   assign Clk4096Hz  = OscDivider[02];
   assign Clk64Hz    = OscDivider[8];
   assign Clk1Hz     = OscDivider[14];

   always @(Clk1Hz) Clk1Hz_D1 <= #1 Clk1Hz;

// -------------------------------------------------------------------------------------------------------
//      1.03:  Digital Trimming
// -------------------------------------------------------------------------------------------------------
 
   always @(SecRollover) begin
      if (!RTCC_CRSTRIM)
         OscTrimCount <= RTCC_OSCTRIM;
   end
   
   always @(posedge OscDivider[7]) begin
      if (RTCC_CRSTRIM)
         OscTrimCount <= RTCC_OSCTRIM;
   end
 
// -------------------------------------------------------------------------------------------------------
//      1.04:  Oscillator Active Detect
// -------------------------------------------------------------------------------------------------------

   always @(negedge OscDividerEn) begin
      RTCC_Memory[3][5] = 0;
   end

   always @(posedge OscDivider[5]) begin
      RTCC_Memory[3][5] = 1;    // Set OSCRUN flag when OscDivider first reaches 32
   end
   
   initial begin
      // Oscillator fail detect clock, 10 ns period
      forever #10; OscFailCount <= OscFailCount + 1;
   end
   
   always @(OscDivider) begin
      // Reset osc fail detect clock upon every OscDivider transition
      OscFailCount <= 0;
   end
   
   always @(OscFailCount) begin
      // Reset OSCRUN bit if OscFailCount reaches 100,000 (1 ms based on 10 ns resolution)
      if (OscFailCount >= 17'd100000)
         RTCC_Memory[3][5] = 0;      
   end

// *******************************************************************************************************
// **   I/O LOGIC - I2C                                                                                 **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      2.01:  START Bit Detection
// -------------------------------------------------------------------------------------------------------

   always @(negedge SDA) begin
      if (SCL == 1 && VCC) begin
         STRT_Rcvd <= 1;
         STOP_Rcvd <= 0;
         CTRL_Rcvd <= 0;
         ADDR_Rcvd <= 0;
         MACK_Rcvd <= 0;
         I2C_FirstRead  <= 1;
         I2C_BitCounter <= 0;

         WrOperation <= #1 0;
         RdOperation <= #1 0;

         RTCCSR_Access <= #1 0;
      end
   end

// -------------------------------------------------------------------------------------------------------
//      2.02:  STOP Bit Detection
// -------------------------------------------------------------------------------------------------------

   always @(posedge SDA) begin
      if (SCL == 1) begin
         STRT_Rcvd <= 0;
         STOP_Rcvd <= 1;
         CTRL_Rcvd <= 0;
         ADDR_Rcvd <= 0;
         MACK_Rcvd <= 0;
         I2C_FirstRead  <= 0;
         I2C_BitCounter <= 10;

         WrOperation <= #1 0;
         RdOperation <= #1 0;

         RTCCSR_Access <= #1 0;
      end
   end

// -------------------------------------------------------------------------------------------------------
//      2.03:  Power Loss Detection
// -------------------------------------------------------------------------------------------------------

   always @(negedge VCC) begin
      STRT_Rcvd <= 0;
      STOP_Rcvd <= 0;
      CTRL_Rcvd <= 0;
      ADDR_Rcvd <= 0;
      MACK_Rcvd <= 0;
      I2C_FirstRead  <= 0;
      I2C_BitCounter <= 10;

      WrOperation <= #1 0;
      RdOperation <= #1 0;

      RTCCSR_Access <= #1 0;
   end

// -------------------------------------------------------------------------------------------------------
//      2.04:  Input Shift Register
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      DataShifter <= {DataShifter[6:0], SDA};
   end

// -------------------------------------------------------------------------------------------------------
//      2.05:  Input Bit Counter
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      I2C_BitCounter <= I2C_BitCounter + 1;
   end

   always @(negedge SCL) begin
      if (I2C_BitCounter == 9) begin I2C_BitCounter <= 0; ByteCounter <= ByteCounter + 1; end
   end

// -------------------------------------------------------------------------------------------------------
//      2.06:  Control Byte Processor
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      if (STRT_Rcvd && (I2C_BitCounter == 7)) begin
         if (SDA == 0) begin
            WrOperation <= 1;
         end
         if (SDA == 1) RdOperation <= 1;

         ControlByte <= {DataShifter[6:0],SDA};
         ByteCounter <= 0;
         CTRL_Rcvd <= 1;

         if (DataShifter[6:0] == CTRL_BYTE_RTCCSR) RTCCSR_Access <= 1;
         STRT_Rcvd <= 0;
      end
   end

   assign CTRL_Valid = CTRL_Rcvd && (ControlByte[7:1]==CTRL_BYTE_RTCCSR);

// -------------------------------------------------------------------------------------------------------
//      2.07:  Address Byte Processor
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      if (CTRL_Valid && WrOperation && (I2C_BitCounter == 7)) begin
         AddressPointer <= {DataShifter[6:0],SDA};

         CTRL_Rcvd <= 0;
         ADDR_Rcvd <= 1;
      end
   end

   assign AddressValid = RTCCSR_Access && AddressPointer < 8'h60;

// -------------------------------------------------------------------------------------------------------
//      2.08:  Write Data Buffer
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      if (ADDR_Rcvd && (I2C_BitCounter == 7) && AddressValid && WrOperation) begin
         if (RTCCSR_Access) begin
            RTCCSR_WrData <= {DataShifter[6:0],SDA};
            
            #(1);
            if (AddressPointer < 8'h20) begin ->RTCC_WrEvent; end
            else if (AddressPointer < 8'h60) begin ->SRAM_WrEvent; end

            if (AddressPointer == 8'h1F) AddressPointer <= 0;
            else if (AddressPointer == 8'h5F) AddressPointer <= 8'h20;
            else AddressPointer <= AddressPointer + 1;
         end
      end
   end

// -------------------------------------------------------------------------------------------------------
//      2.09:  Write Acknowledge Generator
// -------------------------------------------------------------------------------------------------------

   always @(negedge SCL) begin
      if ((CTRL_Valid || (ADDR_Rcvd && AddressValid)) && WrOperation) begin
         if (I2C_BitCounter == 8) begin
            SDA_DO <= 0;
            SDA_OE <= 1;
         end 
         if (I2C_BitCounter == 9) begin
            SDA_DO <= 0;
            SDA_OE <= 0;
         end
      end
   end

// -------------------------------------------------------------------------------------------------------
//      2.10:  Acknowledge Detect
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      if (RdOperation && (I2C_BitCounter == 8)) begin
         if (SDA_OE == 0) begin
            if (SDA == 0) MACK_Rcvd <= 1;
            else begin
               CTRL_Rcvd <= 0;
               ADDR_Rcvd <= 0;
               MACK_Rcvd <= 0;
               I2C_FirstRead  <= 0;
               I2C_BitCounter <= 10;

               WrOperation <= #1 0;
               RdOperation <= #1 0;

               RTCCSR_Access <= #1 0;
            end
         end
         if ((SDA == 0) && (SDA_OE == 0)) MACK_Rcvd <= 1;
      end
   end

   always @(negedge SCL) MACK_Rcvd <= 0;

// -------------------------------------------------------------------------------------------------------
//      2.11:  STOP Flag Removal 
// -------------------------------------------------------------------------------------------------------

   always @(posedge STOP_Rcvd) begin
      #(1);
      STOP_Rcvd = 0;
   end

// -------------------------------------------------------------------------------------------------------
//      2.12:  Read Data Processor
// -------------------------------------------------------------------------------------------------------

   always @(negedge SCL) begin
      if (RdOperation && CTRL_Valid && AddressValid) begin
         if (I2C_FirstRead) begin
            if (I2C_BitCounter == 8) begin
               SDA_DO <= 0;
               SDA_OE <= 1;
            end
            if (I2C_BitCounter == 9) begin
               SDA_DO <= RdDataByte[7];
               SDA_OE <= 1;
               I2C_FirstRead <= 0;
            end
         end
         else begin
            if (I2C_BitCounter == 8) begin
               SDA_DO <= 0;
               SDA_OE <= 0;
            end
            else if (I2C_BitCounter == 9) begin
               SDA_DO <= RdDataByte[7];
               SDA_OE <= MACK_Rcvd;
            end
            else begin
               SDA_DO <= RdDataByte[7-I2C_BitCounter];
            end
         end
      end
   end

// -------------------------------------------------------------------------------------------------------
//      2.13:  Read Address Increment
// -------------------------------------------------------------------------------------------------------

   always @(posedge SCL) begin
      if (I2C_BitCounter == 8 && RdOperation && !I2C_FirstRead) begin
         if (RTCCSR_Access) begin
            if (AddressPointer == 8'h1F) AddressPointer <= 0;
            else if (AddressPointer == 8'h5F) AddressPointer <= 8'h20;
            else AddressPointer <= AddressPointer + 1;
         end
      end
   end

   assign RdDataByte = RTCCSR_RdData;

// -------------------------------------------------------------------------------------------------------
//      2.14:  SDA Data I/O Buffer
// -------------------------------------------------------------------------------------------------------

   bufif1 (SDA, 1'b0, SDA_DriveEnableDlyd);

   assign SDA_DriveEnable = !SDA_DO & SDA_OE;
   always @(SDA_DriveEnable) SDA_DriveEnableDlyd <= #(T_AA) SDA_DriveEnable;


// *******************************************************************************************************
// **   I/O LOGIC - MFP                                                                                 **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      3.01:  Output Pin Open-Drain Driver
// -------------------------------------------------------------------------------------------------------

   bufif1 (MFP, 1'b0, (MFP_DO == 0) & VCC);

// -------------------------------------------------------------------------------------------------------
//      3.02:  Output Pin Signal Select
// -------------------------------------------------------------------------------------------------------

   always @(RTCC_OUT or RTCC_SQWEN or RTCC_SQWFS or RTCC_CRSTRIM or RTCC_AlarmOut or
            Clk64Hz or Clk1Hz or Clk4096Hz or Clk8192Hz or Clk32768Hz) begin
      casex ({RTCC_SQWEN, RTCC_CRSTRIM, RTCC_SQWFS})
         4'b0_x00:  MFP_DO = RTCC_OUT;
         4'b0_xxx:  MFP_DO = RTCC_AlarmOut;
         4'b1_1xx:  MFP_DO = Clk64Hz;
         4'b1_000:  MFP_DO = Clk1Hz;
         4'b1_001:  MFP_DO = Clk4096Hz;
         4'b1_010:  MFP_DO = Clk8192Hz;
         4'b1_011:  MFP_DO = Clk32768Hz;
      endcase
   end

// *******************************************************************************************************
// **   CORE LOGIC - RTCC                                                                               **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      4.01:  RTCC Register Reset
// -------------------------------------------------------------------------------------------------------

   always @(POR_Event or RESET) begin
      RTCC_Memory[0] = 8'h00;
      RTCC_Memory[1] = 8'h00;
      RTCC_Memory[2] = 8'h00;
      RTCC_Memory[3] = 8'h01;
      RTCC_Memory[4] = 8'h01;
      RTCC_Memory[5] = 8'h01;
      RTCC_Memory[6] = 8'h01;
      RTCC_Memory[7] = 8'h80;
      RTCC_Memory[8] = 8'h00;

      RTCC_Memory[10] = 8'h00;
      RTCC_Memory[11] = 8'h00;
      RTCC_Memory[12] = 8'h00;
      RTCC_Memory[13] = 8'h01;
      RTCC_Memory[14] = 8'h01;
      RTCC_Memory[15] = 8'h01;

      RTCC_Memory[17] = 8'h00;
      RTCC_Memory[18] = 8'h00;
      RTCC_Memory[19] = 8'h00;
      RTCC_Memory[20] = 8'h01;
      RTCC_Memory[21] = 8'h01;
      RTCC_Memory[22] = 8'h01;

      RTCC_Memory[24] = 8'h00;
      RTCC_Memory[25] = 8'h00;
      RTCC_Memory[26] = 8'h00;
      RTCC_Memory[27] = 8'h00;

      RTCC_Memory[28] = 8'h00;
      RTCC_Memory[29] = 8'h00;
      RTCC_Memory[30] = 8'h00;
      RTCC_Memory[31] = 8'h00;
   end

// -------------------------------------------------------------------------------------------------------
//      4.02:  RTCC Control and Data Registers Write Logic
// -------------------------------------------------------------------------------------------------------

   always @(RTCC_WrEvent) begin
      case (AddressPointer)
         8'h01:   RTCC_Memory[1]  <= {1'b0,RTCCSR_WrData[6:0]};
         8'h02:   RTCC_Memory[2]  <= {1'b0,RTCCSR_WrData[6:0]};
         8'h03:   RTCC_Memory[3]  <= {2'b00,RTCC_OSCRUN,1'b0,RTCCSR_WrData[3:0]};
         8'h04:   RTCC_Memory[4]  <= {2'b00,RTCCSR_WrData[5:0]};
         8'h05:   RTCC_Memory[5]  <= {2'b00,RTCC_RTCLPYR,RTCCSR_WrData[4:0]};
         8'h09:   RTCC_Memory[9]  <= 0;
         8'h0A:   RTCC_Memory[10] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h0B:   RTCC_Memory[11] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h0C:   RTCC_Memory[12] <= {1'b0,RTCC_ALM01224,RTCCSR_WrData[5:0]};
         8'h0D:   RTCC_Memory[13] <= {RTCCSR_WrData[7:4],1'b0,RTCCSR_WrData[2:0]};
         8'h0E:   RTCC_Memory[14] <= {2'b00,RTCCSR_WrData[5:0]};
         8'h0F:   RTCC_Memory[15] <= {3'b000,RTCCSR_WrData[4:0]};
         8'h11:   RTCC_Memory[17] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h12:   RTCC_Memory[18] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h13:   RTCC_Memory[19] <= {1'b0,RTCC_ALM11224,RTCCSR_WrData[5:0]};
         8'h14:   RTCC_Memory[20] <= {RTCCSR_WrData[7:4],1'b0,RTCCSR_WrData[2:0]};
         8'h15:   RTCC_Memory[21] <= {2'b00,RTCCSR_WrData[5:0]};
         8'h16:   RTCC_Memory[22] <= {3'b000,RTCCSR_WrData[4:0]};
         8'h18:   RTCC_Memory[24] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h19:   RTCC_Memory[25] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h1A:   RTCC_Memory[26] <= {2'b00,RTCCSR_WrData[5:0]};
         8'h1C:   RTCC_Memory[28] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h1D:   RTCC_Memory[29] <= {1'b0,RTCCSR_WrData[6:0]};
         8'h1E:   RTCC_Memory[30] <= {2'b00,RTCCSR_WrData[5:0]};
         default: RTCC_Memory[AddressPointer] <= RTCCSR_WrData;
      endcase
   end
   
// -------------------------------------------------------------------------------------------------------
//      4.03:  RTCC Time and Date - Seconds
// -------------------------------------------------------------------------------------------------------

   always @(posedge Clk1Hz) begin
      if (RTCC_Memory[0][3:0]==4'h9) begin
         if (RTCC_Memory[0][6:4]==3'h5) begin
            RTCC_Memory[0][6:0] <= 7'h0;
            ->SecRollover;
         end
         else RTCC_Memory[0][6:0] <= {RTCC_Memory[0][6:4]+1'b1,4'h0};
      end
      else RTCC_Memory[0][3:0] <= RTCC_Memory[0][3:0] + 1;
   end

// -------------------------------------------------------------------------------------------------------
//      4.04:  RTCC Time and Date - Minutes
// -------------------------------------------------------------------------------------------------------

   always @(SecRollover) begin
      if (RTCC_Memory[1][3:0]==4'h9) begin
         if (RTCC_Memory[1][6:4]==3'h5) begin
            RTCC_Memory[1][6:0] <= 7'h0;
            ->MinRollover;
         end
         else RTCC_Memory[1][6:0] <= {RTCC_Memory[1][6:4]+1'b1,4'h0};
      end
      else RTCC_Memory[1][3:0] <= RTCC_Memory[1][3:0] + 1;
   end

// -------------------------------------------------------------------------------------------------------
//      4.05:  RTCC Time and Date - Hours
// -------------------------------------------------------------------------------------------------------

   always @(MinRollover) begin
      if (RTCC_Memory[2][6] == 0) begin  // 24 hour format
         if      (RTCC_Memory[2][5:0]==6'h09)    RTCC_Memory[2][5:0] <= {2'h1,4'h0};
         else if (RTCC_Memory[2][5:0]==6'h19)    RTCC_Memory[2][5:0] <= {2'h2,4'h0};
         else if (RTCC_Memory[2][5:0]==6'h23)    begin RTCC_Memory[2][5:0] <= {2'h0,4'h0}; ->HourRollover; end
         else                                    RTCC_Memory[2][3:0] <= RTCC_Memory[2][3:0] + 1;
      end
      else begin                         // 12 hour format
         if      (RTCC_Memory[2][5:0]==6'h09)    RTCC_Memory[2][5:0] <= {2'h1,4'h0};
         else if (RTCC_Memory[2][5:0]==6'h11)    RTCC_Memory[2][5:0] <= {2'h3,4'h2};
         else if (RTCC_Memory[2][5:0]==6'h12)    RTCC_Memory[2][5:0] <= {2'h0,4'h1};
         else if (RTCC_Memory[2][5:0]==6'h29)    RTCC_Memory[2][5:0] <= {2'h3,4'h0};
         else if (RTCC_Memory[2][5:0]==6'h31)    begin RTCC_Memory[2][5:0] <= {2'h1,4'h2}; ->HourRollover; end
         else if (RTCC_Memory[2][5:0]==6'h32)    RTCC_Memory[2][5:0] <= {2'h2,4'h1};
         else                                    RTCC_Memory[2][3:0] <= RTCC_Memory[2][3:0] + 1;
      end
   end

// -------------------------------------------------------------------------------------------------------
//      4.06:  RTCC Time and Date - Days
// -------------------------------------------------------------------------------------------------------

   always @(HourRollover) begin
      if (RTCC_Memory[3][2:0]==7)  RTCC_Memory[3][2:0] <= {3'h1};
      else                         RTCC_Memory[3][2:0] <= RTCC_Memory[3][2:0] + 1;
   end

// -------------------------------------------------------------------------------------------------------
//      4.07:  RTCC Time and Date - Year/Month/Date
// -------------------------------------------------------------------------------------------------------

   always @(HourRollover) begin
      {RTCC_Memory[6],RTCC_Memory[5],RTCC_Memory[4]} <= DateNext(RTCC_Memory[6][7:0],RTCC_Memory[5][4:0],RTCC_Memory[4][5:0]);
   end

// -------------------------------------------------------------------------------------------------------
//      4.08:  RTCC Time and Date - Status Signals
// -------------------------------------------------------------------------------------------------------

   always @(RTCC_RTCYEAR) begin
      RTCC_Memory[5][5] <= ((BCDtoHex(RTCC_Memory[6]) % 4) == 0) ? 1 : 0;
   end

   assign IsMidnight = (RTCC_Memory[2][6] ? (RTCC_Memory[2][5:0] == 6'h12) : (RTCC_Memory[2][5:0] == 6'h00))
                     & (RTCC_Memory[0][6:0] == 0) 
                     & (RTCC_Memory[1][6:0] == 0);

// -------------------------------------------------------------------------------------------------------
//      4.09:  RTCC Alarm #0 Logic
// -------------------------------------------------------------------------------------------------------

   always @(RTCC_Memory[0] or RTCC_Memory[1] or RTCC_Memory[2] or RTCC_Memory[3] or RTCC_Memory[4] or RTCC_Memory[5] or
            RTCC_Memory[10] or RTCC_Memory[11] or RTCC_Memory[12] or RTCC_Memory[13] or RTCC_Memory[14] or RTCC_Memory[15] or
            RTCC_ALM0MSK or IsMidnight) begin
      Alarm0_True = 0;
      case (RTCC_ALM0MSK)
         3'h0:  if ((RTCC_Memory[0][6:0] == RTCC_Memory[10][6:0])) Alarm0_True = 1; 
         3'h1:  if ((RTCC_Memory[1][6:0] == RTCC_Memory[11][6:0])) Alarm0_True = 1; 
         3'h2:  if ((RTCC_Memory[2][5:0] == RTCC_Memory[12][5:0])) Alarm0_True = 1; 
         3'h3:  if ((RTCC_Memory[3][2:0] == RTCC_Memory[13][2:0]) && IsMidnight) Alarm0_True = 1;
         3'h4:  if ((RTCC_Memory[4][5:0] == RTCC_Memory[14][5:0])) Alarm0_True = 1; 
         3'h7:  if ((RTCC_Memory[0][6:0] == RTCC_Memory[10][6:0]) &&
                    (RTCC_Memory[1][6:0] == RTCC_Memory[11][6:0]) &&
                    (RTCC_Memory[2][5:0] == RTCC_Memory[12][5:0]) &&
                    (RTCC_Memory[4][5:0] == RTCC_Memory[14][5:0]) &&
                    (RTCC_Memory[5][4:0] == RTCC_Memory[15][4:0])) Alarm0_True = 1;
      endcase
   end

   always @(posedge Clk1Hz_D1) if (Alarm0_True) RTCC_Memory[13][3] <= 1;

// -------------------------------------------------------------------------------------------------------
//      4.10:  RTCC Alarm #1 Logic
// -------------------------------------------------------------------------------------------------------

   always @(RTCC_Memory[0] or RTCC_Memory[1] or RTCC_Memory[2] or RTCC_Memory[3] or RTCC_Memory[4] or RTCC_Memory[5] or
            RTCC_Memory[17] or RTCC_Memory[18] or RTCC_Memory[19] or RTCC_Memory[20] or RTCC_Memory[21] or RTCC_Memory[22] or
            RTCC_ALM1MSK or IsMidnight) begin
      Alarm1_True = 0;
      case (RTCC_ALM1MSK)
         3'h0:  if ((RTCC_Memory[0][6:0] == RTCC_Memory[17][6:0])) Alarm1_True = 1;
         3'h1:  if ((RTCC_Memory[1][6:0] == RTCC_Memory[18][6:0])) Alarm1_True = 1;
         3'h2:  if ((RTCC_Memory[2][5:0] == RTCC_Memory[19][5:0])) Alarm1_True = 1;
         3'h3:  if ((RTCC_Memory[3][2:0] == RTCC_Memory[20][2:0]) && IsMidnight) Alarm1_True = 1;
         3'h4:  if ((RTCC_Memory[4][5:0] == RTCC_Memory[21][5:0])) Alarm1_True = 1;
         3'h7:  if ((RTCC_Memory[0][6:0] == RTCC_Memory[17][6:0]) &&
                    (RTCC_Memory[1][6:0] == RTCC_Memory[18][6:0]) &&
                    (RTCC_Memory[2][5:0] == RTCC_Memory[19][5:0]) &&
                    (RTCC_Memory[4][5:0] == RTCC_Memory[21][5:0]) &&
                    (RTCC_Memory[5][4:0] == RTCC_Memory[22][4:0])) Alarm1_True = 1;
      endcase
   end

   always @(posedge Clk1Hz_D1) if (Alarm1_True) RTCC_Memory[20][3] <= 1;

// -------------------------------------------------------------------------------------------------------
//      4.11:  RTCC Alarm Output Signal
// -------------------------------------------------------------------------------------------------------

   always @(RTCC_ALM0IF or RTCC_ALM1IF or RTCC_ALM0ALMPOL or RTCC_ALM1ALMPOL or RTCC_ALM0EN or RTCC_ALM1EN or RTCC_OUT) begin
      case ({RTCC_ALM1EN, RTCC_ALM0EN})
         2'b00:  RTCC_AlarmOut = RTCC_OUT;
         2'b01:  RTCC_AlarmOut = RTCC_ALM0IF ^ !RTCC_ALM0ALMPOL;
         2'b10:  RTCC_AlarmOut = RTCC_ALM1IF ^ !RTCC_ALM1ALMPOL;
         2'b11:  RTCC_AlarmOut = (RTCC_ALM0IF ^ !RTCC_ALM0ALMPOL) | (RTCC_ALM1IF ^ !RTCC_ALM1ALMPOL);
      endcase
   end

// -------------------------------------------------------------------------------------------------------
//      4.12:  RTCC Power Fail Detect
// -------------------------------------------------------------------------------------------------------

   always @(negedge VCC) begin
      ->POR_Event;
   end

// -------------------------------------------------------------------------------------------------------
//      4.13:  RTCC Read Data Multiplexor
// -------------------------------------------------------------------------------------------------------

   integer i;
   always @(CTRL_Valid or AddressPointer) begin
      if (CTRL_Valid || (AddressPointer == 7'h0)) begin
         for (i = 0; i < 32; i=i+1) begin
            RTCC_RDBuffer[i] <= RTCC_Memory[i];
         end
      end
   end

   always @(SRAM_RdData or AddressPointer) begin 
      if (!AddressPointer[5]) RTCCSR_RdData = RTCC_RDBuffer[AddressPointer];
      else RTCCSR_RdData = SRAM_RdData;
   end

// *******************************************************************************************************
// **   CORE LOGIC - SRAM                                                                               **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      5.01:  SRAM Write Logic
// -------------------------------------------------------------------------------------------------------

   assign SRAM_Address = AddressPointer - 7'h20;

   always @(SRAM_WrEvent) begin
      SRAM_Memory[SRAM_Address] = RTCCSR_WrData;
   end

// -------------------------------------------------------------------------------------------------------
//      5.02:  SRAM Read Logic
// -------------------------------------------------------------------------------------------------------

   assign SRAM_RdData = SRAM_Memory[SRAM_Address];

// *******************************************************************************************************
// **   LOGIC FUNCTIONS                                                                                 **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      6.01:  DateNext - Compute the Next Year-Month-Date
// -------------------------------------------------------------------------------------------------------

   function [23:00] DateNext;

      input [07:00] Year;
      input [04:00] Month;
      input [05:00] Date;

      reg           LeapYear;

      reg   [07:00] ThisYear;
      reg   [07:00] ThisMonth;
      reg   [07:00] ThisDate;

      reg   [07:00] NextYear;
      reg   [07:00] NextMonth;
      reg   [07:00] NextDate;

      begin
         ThisYear  = BCDtoHex(Year[7:0]);
         ThisMonth = BCDtoHex({3'h0,Month[4:0]});
         ThisDate  = BCDtoHex({2'h0,Date [5:0]});

         NextYear  = ThisYear;
         NextMonth = ThisMonth;
         NextDate  = ThisDate;

         LeapYear = ((ThisYear % 4) == 0) ? 1 : 0;

         if      ((ThisMonth ==  1) && (ThisDate == 31)) begin NextMonth =  2; NextDate = 1; end
         else if ((ThisMonth ==  2) && (ThisDate == 28) && !LeapYear) begin NextMonth = 3; NextDate = 1; end
         else if ((ThisMonth ==  2) && (ThisDate == 29) &&  LeapYear) begin NextMonth = 3; NextDate = 1; end
         else if ((ThisMonth ==  3) && (ThisDate == 31)) begin NextMonth =  4; NextDate = 1; end
         else if ((ThisMonth ==  4) && (ThisDate == 30)) begin NextMonth =  5; NextDate = 1; end
         else if ((ThisMonth ==  5) && (ThisDate == 31)) begin NextMonth =  6; NextDate = 1; end
         else if ((ThisMonth ==  6) && (ThisDate == 30)) begin NextMonth =  7; NextDate = 1; end
         else if ((ThisMonth ==  7) && (ThisDate == 31)) begin NextMonth =  8; NextDate = 1; end
         else if ((ThisMonth ==  8) && (ThisDate == 31)) begin NextMonth =  9; NextDate = 1; end
         else if ((ThisMonth ==  9) && (ThisDate == 30)) begin NextMonth = 10; NextDate = 1; end
         else if ((ThisMonth == 10) && (ThisDate == 31)) begin NextMonth = 11; NextDate = 1; end
         else if ((ThisMonth == 11) && (ThisDate == 30)) begin NextMonth = 12; NextDate = 1; end
         else if ((ThisMonth == 12) && (ThisDate == 31)) begin NextMonth =  1; NextDate = 1; NextYear = ThisYear + 1; end
         else NextDate = ThisDate + 1;

         NextYear  = HexToBCD(NextYear);
         NextMonth = HexToBCD(NextMonth);
         NextDate  = HexToBCD(NextDate);

         DateNext = {NextYear[7:0],3'h0,NextMonth[4:0],2'h0,NextDate[5:0]};
      end
   endfunction

// -------------------------------------------------------------------------------------------------------
//      6.02:  BCDtoHex - Convert BCD to Hex Value
// -------------------------------------------------------------------------------------------------------

   function [07:00] BCDtoHex;

      input [07:00] BCD;

      reg   [07:00] Tens;
      reg   [07:00] Ones;

      begin
         Tens = BCD[07:04] * 10;
         Ones = BCD[03:00];

         BCDtoHex = Tens + Ones; 
      end
   endfunction

// -------------------------------------------------------------------------------------------------------
//      6.03:  HexToBCD - Convert Hex to BCD Value
// -------------------------------------------------------------------------------------------------------

   function [07:00] HexToBCD;

      input [07:00] Hex;

      reg   [03:00] Tens;
      reg   [03:00] Ones;

      begin
         Tens = Hex / 10;
         Ones = Hex % 10;
         HexToBCD = {Tens[3:0],Ones[3:0]}; 
      end
   endfunction


// *******************************************************************************************************
// **   DEBUG LOGIC                                                                                     **
// *******************************************************************************************************
// -------------------------------------------------------------------------------------------------------
//      7.01:  SRAM Memory Data Bytes
// -------------------------------------------------------------------------------------------------------

   wire [07:00] SRAM_Byte00 = SRAM_Memory[00];
   wire [07:00] SRAM_Byte01 = SRAM_Memory[01];
   wire [07:00] SRAM_Byte02 = SRAM_Memory[02];
   wire [07:00] SRAM_Byte03 = SRAM_Memory[03];
   wire [07:00] SRAM_Byte04 = SRAM_Memory[04];
   wire [07:00] SRAM_Byte05 = SRAM_Memory[05];
   wire [07:00] SRAM_Byte06 = SRAM_Memory[06];
   wire [07:00] SRAM_Byte07 = SRAM_Memory[07];
   wire [07:00] SRAM_Byte08 = SRAM_Memory[08];
   wire [07:00] SRAM_Byte09 = SRAM_Memory[09];
   wire [07:00] SRAM_Byte0A = SRAM_Memory[10];
   wire [07:00] SRAM_Byte0B = SRAM_Memory[11];
   wire [07:00] SRAM_Byte0C = SRAM_Memory[12];
   wire [07:00] SRAM_Byte0D = SRAM_Memory[13];
   wire [07:00] SRAM_Byte0E = SRAM_Memory[14];
   wire [07:00] SRAM_Byte0F = SRAM_Memory[15];
   wire [07:00] SRAM_Byte10 = SRAM_Memory[16];
   wire [07:00] SRAM_Byte11 = SRAM_Memory[17];
   wire [07:00] SRAM_Byte12 = SRAM_Memory[18];
   wire [07:00] SRAM_Byte13 = SRAM_Memory[19];
   wire [07:00] SRAM_Byte14 = SRAM_Memory[20];
   wire [07:00] SRAM_Byte15 = SRAM_Memory[21];
   wire [07:00] SRAM_Byte16 = SRAM_Memory[22];
   wire [07:00] SRAM_Byte17 = SRAM_Memory[23];
   wire [07:00] SRAM_Byte18 = SRAM_Memory[24];
   wire [07:00] SRAM_Byte19 = SRAM_Memory[25];
   wire [07:00] SRAM_Byte1A = SRAM_Memory[26];
   wire [07:00] SRAM_Byte1B = SRAM_Memory[27];
   wire [07:00] SRAM_Byte1C = SRAM_Memory[28];
   wire [07:00] SRAM_Byte1D = SRAM_Memory[29];
   wire [07:00] SRAM_Byte1E = SRAM_Memory[30];
   wire [07:00] SRAM_Byte1F = SRAM_Memory[31];
   wire [07:00] SRAM_Byte20 = SRAM_Memory[32];
   wire [07:00] SRAM_Byte21 = SRAM_Memory[33];
   wire [07:00] SRAM_Byte22 = SRAM_Memory[34];
   wire [07:00] SRAM_Byte23 = SRAM_Memory[35];
   wire [07:00] SRAM_Byte24 = SRAM_Memory[36];
   wire [07:00] SRAM_Byte25 = SRAM_Memory[37];
   wire [07:00] SRAM_Byte26 = SRAM_Memory[38];
   wire [07:00] SRAM_Byte27 = SRAM_Memory[39];
   wire [07:00] SRAM_Byte28 = SRAM_Memory[40];
   wire [07:00] SRAM_Byte29 = SRAM_Memory[41];
   wire [07:00] SRAM_Byte2A = SRAM_Memory[42];
   wire [07:00] SRAM_Byte2B = SRAM_Memory[43];
   wire [07:00] SRAM_Byte2C = SRAM_Memory[44];
   wire [07:00] SRAM_Byte2D = SRAM_Memory[45];
   wire [07:00] SRAM_Byte2E = SRAM_Memory[46];
   wire [07:00] SRAM_Byte2F = SRAM_Memory[47];
   wire [07:00] SRAM_Byte30 = SRAM_Memory[48];
   wire [07:00] SRAM_Byte31 = SRAM_Memory[49];
   wire [07:00] SRAM_Byte32 = SRAM_Memory[50];
   wire [07:00] SRAM_Byte33 = SRAM_Memory[51];
   wire [07:00] SRAM_Byte34 = SRAM_Memory[52];
   wire [07:00] SRAM_Byte35 = SRAM_Memory[53];
   wire [07:00] SRAM_Byte36 = SRAM_Memory[54];
   wire [07:00] SRAM_Byte37 = SRAM_Memory[55];
   wire [07:00] SRAM_Byte38 = SRAM_Memory[56];
   wire [07:00] SRAM_Byte39 = SRAM_Memory[57];
   wire [07:00] SRAM_Byte3A = SRAM_Memory[58];
   wire [07:00] SRAM_Byte3B = SRAM_Memory[59];
   wire [07:00] SRAM_Byte3C = SRAM_Memory[60];
   wire [07:00] SRAM_Byte3D = SRAM_Memory[61];
   wire [07:00] SRAM_Byte3E = SRAM_Memory[62];
   wire [07:00] SRAM_Byte3F = SRAM_Memory[63];

// *******************************************************************************************************
// **   TIMING CHECKS                                                                                   **
// *******************************************************************************************************

   wire TimingCheckEnable = (RESET == 0) & (SDA_OE == 0);

   specify
      `ifdef I2C_100KHZ_TIMING
         specparam                                  // 100 kHz timing
            tHI = 4000,                             // SCL pulse width - high
            tLO = 4700,                             // SCL pulse width - low
            tSU_STA = 4700,                         // SCL to SDA setup time
            tHD_STA = 4000,                         // SCL to SDA hold time
            tSU_DAT = 250,                          // SDA to SCL setup time
            tSU_STO = 4000,                         // SCL to SDA setup time
            tBUF = 4700;                            // Bus free time
      `else
      `ifdef I2C_400KHZ_TIMING
         specparam                                  // 400 kHz timing
            tHI = 600,                              // SCL pulse width - high
            tLO = 1300,                             // SCL pulse width - low
            tSU_STA = 600,                          // SCL to SDA setup time
            tHD_STA = 600,                          // SCL to SDA hold time
            tSU_DAT = 100,                          // SDA to SCL setup time
            tSU_STO = 600,                          // SCL to SDA setup time
            tBUF = 1300;                            // Bus free time
      `else
         specparam                                  // No timing specified, default to 400 kHz
            tHI = 600,                              // SCL pulse width - high
            tLO = 1300,                             // SCL pulse width - low
            tSU_STA = 600,                          // SCL to SDA setup time
            tHD_STA = 600,                          // SCL to SDA hold time
            tSU_DAT = 100,                          // SDA to SCL setup time
            tSU_STO = 600,                          // SCL to SDA setup time
            tBUF = 1300;                            // Bus free time
      `endif
      `endif

      $width (posedge SCL, tHI);
      $width (negedge SCL, tLO);

      $width (posedge SDA &&& SCL, tBUF);

      $setup (posedge SCL, negedge SDA &&& TimingCheckEnable, tSU_STA);
      $setup (SDA, posedge SCL &&& TimingCheckEnable, tSU_DAT);
      $setup (posedge SCL, posedge SDA &&& TimingCheckEnable, tSU_STO);

      $hold  (negedge SDA &&& TimingCheckEnable, negedge SCL, tHD_STA);
   endspecify

endmodule
