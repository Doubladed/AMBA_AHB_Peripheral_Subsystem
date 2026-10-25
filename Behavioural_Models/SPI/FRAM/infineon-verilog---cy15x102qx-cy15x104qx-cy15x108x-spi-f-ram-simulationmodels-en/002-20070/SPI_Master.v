//********************************************************************************************************
// Copyright(c) Cypress Semiconductor, 2019. All rights reserved.
// This model is the property of Cypress Semiconductor Corp.
// and is protected by the US copyright laws, any unauthorized
// copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional 
// specifications without any prior notice.
// Cypress is not liable for any damages which may result from
// the use of this functional model
// -------------------------------------------------------------------------------------------------------
// File name : SPI_Master.v
// -------------------------------------------------------------------------------------------------------
// Functionality : Verilog behavourial Model for SPI Master
// Source:  CYPRESS Data Sheet : 
// Version:  1.0 Feb 27, 2017
// -------------------------------------------------------------------------------------------------------
// Developed by CYPRESS SEMICONDUCTOR
//
// version |   author     | mod date | changes made
//    1.0  |    MEDU      | 02/27/14 | New Model
//    1.1  |    ZSK       | 10/15/19 | Replaced SERIAL_NO with actual opcode RDSN
//                                   | Updated the opcode inialixation to all HEX format in the Initial block  
//                                   | Updated the copyright year
// -------------------------------------------------------------------------------------------------------
// PART DESCRIPTION :
// Part:        All parts of Excelon SPI F-RAM
//
// Descripton:  Verilog behavourial Model  for Excelon SPI F-RAM
// ----------------------------------------------------------------------------------------------------------  

`timescale 1ns/10ps 
//
//  Master for SPI protocol
//
module SPI_Master(SI,SO,SCK,CSB,WPTST,WP,HOLD,HOLDS,VDD_CTL);
    output  SI,SCK,CSB,WP,HOLDS,VDD_CTL;
    reg     SI,SCK,CSB,WP,HOLDS,VDD_CTL;
    input   SO,HOLD,WPTST;
    tri     SO;

`define B0          1'b0
`define B1          1'b1
//
//  states
//
`define idle                4'b0000
`define sendingInstruction  4'b0001
`define sendingAdd          4'b0010
`define sendingData         4'b0011
`define sendingStopStart    4'b0100
`define receivingData       4'b0111
`define holdS               4'b1111
//
parameter mode = 2'b00;
parameter frequency = 20000000; //(Hz)

//
// Read timing
//
`include "config.v"

parameter delta = 10;

integer lSeq;                       // sequence length 
integer MbitCounter, seqCounter, addrBytesCounter, i, j, recDataCounter, lgDisp;
integer tNORM, semForever, sem, seqLength;
integer TestPhase;

integer tHALF;

reg [7:0] WREN, WRDI, RDSR, WRSR, READ, WRITE, FSTRD, SLEEP, RDID, WRONG_OPCODE, RDSN,WRSN,DPD,SSRD,SSWR;
reg[7:0] Minstruction, prevInstruction, manStReg;   // instruction
reg [3:0] Mstate,MnextState,savState,savStH,prevState;  // State machine controller
reg bitA8;

reg [7:0] bufWriteData[0:4095];     
reg [7:0] bufReadData[0:4095];
reg [7:0] data[0:100];                  // for data to write 
reg [7:0] linestr[0:79];                // for display

reg [`addrBits-1:0] addr,addrMax,crtMemAddr,realCrtMemAddr; 

reg[7:0] pattern;
reg[7:0] genDataCell;
reg [7:0] MtempReg,MdataReg,manRegB; 
integer manRegW;
reg[6:0] manNr;
reg [`addrBits-1:0] manAddr;
integer man0,man;
integer semPrepBegHold,semPrepEndHold;
event reinitClockForStart,go;

reg stop;

//
//#################################### TASKS ###########################################
//

task createIncremFillPattern;
    begin
    pattern = data[0];
    genDataCell = {pattern[7:4],4'b0000};
    for(i=0;i<lSeq;i=i+1)
        begin
           bufWriteData[i] = genDataCell;
            genDataCell = genDataCell+1;
        end
    end
endtask

task bufwrite;
    begin
    for(i=0;i<lSeq;i=i+1)
        begin
           bufWriteData[i] = data[i];
        end
    end
endtask

task displayData;
    begin
    $display;
    $display("            MASTER: %d bytes of sent data: (addr = %h)",lSeq,addr);
    if(seqLength == 1)
        $display("----------");
    else
        $display("---------------------------------------------------------------------");
    
    for(i=0;i<seqLength+1;i=i+1)
        begin
        j=i%16;
        if(j == 0 && i>0)
            begin
            manAddr = addr+i-16;
            $display("%h:  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h",manAddr,linestr[0],linestr[1],linestr[2],linestr[3],linestr[4],linestr[5],linestr[6],linestr[7],linestr[8],linestr[9],linestr[10],linestr[11],linestr[12],linestr[13],linestr[14],linestr[15]);
            linestr[j] = bufWriteData[i];
            end
        else
            linestr[j] = bufWriteData[i];
        end
       
       if(j>0)
        begin
        case(j)
        1:
            begin
            manAddr = addr+i-j-1;
            $display("%h:   %h",manAddr,linestr[0]);
            end
        default:
            i=i;    
        endcase
        end
    if(seqLength == 1)
        $display("----------");
    else
        $display("---------------------------------------------------------------------");
    end
endtask

task initBufReadData;
    begin
    for(i=0;i<4096;i=i+1)
        bufReadData[i] = 8'hff; 
    end
endtask

task displayRecData;
    begin
    if(Minstruction != RDSR)
        begin
        $display;
        $display("            MASTER: %d bytes of rec data: (addr = %h)",lSeq,addr);
        end
    if(recDataCounter == 1)
        begin
        if(Minstruction != RDSR)
            $display("----------");
        lgDisp = 1;
        end
    else
        begin
        $display("---------------------------------------------------------------------");
        lgDisp = recDataCounter;
        end
    for(i=0;i<lgDisp+1;i=i+1)
        begin
        j=i%16;
        if(j == 0 && i>0)
            begin
            manAddr = addr+i-16;
            $display("%h:  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h  %h",manAddr,linestr[0],linestr[1],linestr[2],linestr[3],linestr[4],linestr[5],linestr[6],linestr[7],linestr[8],linestr[9],linestr[10],linestr[11],linestr[12],linestr[13],linestr[14],linestr[15]);
            linestr[j] = bufReadData[i];
            end
        else
            linestr[j] = bufReadData[i];
        end
    if(Minstruction == RDID)
        $display("DEVICE ID:  %h  %h  %h  %h  %h  %h  %h  %h  %h ",linestr[0],linestr[1],linestr[2],linestr[3],linestr[4],linestr[5],linestr[6],linestr[7],linestr[8]);

    if(Minstruction == RDSN)
        $display("SERIAL NO:  %h  %h  %h  %h  %h  %h  %h  %h ",linestr[0],linestr[1],linestr[2],linestr[3],linestr[4],linestr[5],linestr[6],linestr[7]);
        
    if(j>0)
        begin
        case(j)
        1:
            begin
            manAddr = addr+i-j-1;

            if(Minstruction != RDSR)
                $display("%h:   %h",manAddr,linestr[0]);
            end 
        default:
            i=i;
        endcase
        end
    if(recDataCounter == 1)
        begin
        if(Minstruction != RDSR)
            $display("----------");
        else
            begin
            manStReg = linestr[0];
            end
        end
    else
        $display("---------------------------------------------------------------------");
    manRegW =  $time;
    end
endtask


//
//########################################## INITIAL #######################################
//
initial
    begin

    tHALF = 1000000000/(2*frequency) + 1 ;      // Half Clock Period (in ns)

    WRSR =  8'h01;  // Write Status Register
	WRITE = 8'h02;  // Write Data to Memory
    READ =  8'h03;  // Read Data from Memory	
    WRDI =  8'h04;  // Disable Write
    RDSR =  8'h05;  // Read Status Register
	WREN =  8'h06;  // Enable Write    
    FSTRD = 8'h0B;  // Fast Read Command
	SSWR  = 8'h42;	// Special Sector Write
	SSRD  = 8'h4B;	// Special Sector Read	
    SLEEP = 8'hB9;  // Sleep Command    
    RDID  = 8'h9F;  // Read Device ID
    RDSN  = 8'hC3;  // Read Serial No
	WRSN  = 8'hC2;	// Write Serial Number
	DPD	  = 8'hBA;	// Deep Power Down

    WRONG_OPCODE  =  8'h00;  // Wrong Operation Code (for test)
	
	
    addr = 16'h0000;
    crtMemAddr = 16'h0000;
    realCrtMemAddr = 16'h0000;

    addrMax = 16'h0000;
    for(i=0; i<`addrBits; i=i+1)
        addrMax[i]=1;  
        
    VDD_CTL = 0;
    #10;
    VDD_CTL = 1;   
     
    #tPU;
	 
    $display ("* MASTER - Address Max: ", addrMax);
    //
    TestPhase = 1;
    $display;
    $display("*******************************************************");
    $display("*     Master for SPI protocol");
    $display("*     SPI mode: %b",mode);
    $display("*******************************************************");
    Mstate = `idle;
    MnextState = `idle;
    MbitCounter = 0;
    seqCounter = lSeq;
    manStReg = 8'h00;
    
    prevInstruction = READ;
    SI = 1'b0;
    CSB = `B1;
    semForever = 0;
    sem = 0;
    MnextState = `sendingStopStart;
    SCK = 0;

    semPrepBegHold = 0;
    semPrepEndHold = 0;
    HOLDS = 1;

    stop = 0;
    
    man0 = frequency;
    man = 2*tHALF;
    $display("* Tclock  = %f ns (Frequency: %f Hz)",man,man0);
    $display("*");
    end

//
//############################## ALWAYS ####################################
//
//********************//
// Clock Generation   //
//********************//

always @(reinitClockForStart)
    begin
    while(semForever == 0)
            #tHALF  SCK = ~SCK;
    end
//---------------------------------------------------------------------------

always @(posedge HOLD)
begin
    if(SCK == 1'b0 && $time != 0)
    begin
        $display("MASTER: Preparing HOLD state ending...    ",$time);
        Mstate = savStH;
        MnextState = savStH;
        if(MbitCounter == 8)
        begin
            MbitCounter = 0;
            MnextState = MnextState+1;
        end
        semPrepEndHold = 1;
        HOLDS = 1;
        semPrepEndHold = 0;
    end
end

//------------------------------------------------------------------------------
always @(negedge HOLD)  
begin
    if(SCK == 1'b0 && $time != 0)
    begin
        $display("MASTER: Preparing HOLD state beginning ...",$time);
        savStH = Mstate;
        MnextState = `holdS;
        Mstate = `holdS;
        semPrepBegHold = 1;
        HOLDS = 0;
        semPrepBegHold = 0;
    end
end

//----------------------------------------------------------------------
always @(WPTST)
begin
    WP=WPTST;
end

//
//  State machine for READs 
// 
//----------------------------------------------------------------------
always @(posedge SCK)
begin
    Mstate = MnextState;
    if(mode==2'b00 || mode==2'b11)
    begin
      case(Mstate)
        `receivingData:     // 00 & 11
            begin
            #(tHALF/2) case(MbitCounter)
            1:
                begin
                MtempReg[7:0] = 8'b00000000;
                #0 MtempReg[0] = SO;
                #tHALF if(MbitCounter < 8 && MbitCounter != 0) 
                    begin
                    MbitCounter = MbitCounter + 1;
                    end
                end
            8:
                begin
                MtempReg = MtempReg << 1;
                MtempReg[0] = SO;
                seqCounter = seqCounter - 1;

            
                if(seqCounter == 0)        // If read sequence is complete - Burst Read of 1 or more than 1 addresses
                    begin

                    bufReadData[recDataCounter] = MtempReg[7:0];
                    recDataCounter = recDataCounter + 1;

                    crtMemAddr = crtMemAddr + 1;    
                    realCrtMemAddr = crtMemAddr;
                    
                    if(recDataCounter == lSeq)
                        displayRecData;
                        
                    MnextState = `sendingStopStart;
                    semForever = 1;
                    
                    #(tHALF/4) MbitCounter = 0;
                    
                    if (Minstruction == RDSR)
                        begin
                        manStReg[7:0] = MtempReg[7:0];
                        end

                    end
                else
                    begin
                    bufReadData[recDataCounter] = MtempReg[7:0];
                    recDataCounter = recDataCounter + 1;
                    crtMemAddr = crtMemAddr + 1;    //(inc.adr.in pag)
                    realCrtMemAddr = crtMemAddr;
                    if(recDataCounter == lSeq)
                        displayRecData;

                    MnextState = `receivingData;
                    // $display("            MASTER: rec. data %d:      %h",lSeq-seqCounter,MtempReg[7:0]);
                    #(tHALF/2) MbitCounter = 1;
                    end
                end
            // cases 2,3,4,5,6,7
            default:
                begin
                MtempReg = MtempReg << 1;
                #0 MtempReg[0] = SO;
                #(tHALF/2) if(MbitCounter < 8 && MbitCounter != 0) 
                    begin
                       if(MnextState != `holdS)
                           MbitCounter = MbitCounter + 1;
                    end
                end
            endcase
            end
        `sendingStopStart:
            begin
            seqCounter = lSeq;
            end
      endcase
    end
end

//-------------------------------------------------------------------------- 00/11
//  State machine for SEND type MASTER activity (00/11 modes)
//------------------------------------------------------------------------------

always @(negedge SCK ) 
begin
    if( ($time == 0) || ((mode==2'b00 || mode==2'b11) && MnextState != `holdS) )
    begin
        prevState = Mstate;
        Mstate = MnextState;
        case(Mstate)
        `sendingInstruction:        // 00 & 11
        begin
           #(tHALF-tSU)  
           if(MbitCounter < 8) 
           begin
               MbitCounter = MbitCounter + 1;
               SI = MtempReg[7];
               #(tSU+tH) SI = 1'b0;
               #0 MtempReg = MtempReg << 1;
           end
           if(MbitCounter == 8) 
           begin
               case(Minstruction)
                   WREN:
                   begin
                       if(MnextState != `holdS)
                       begin
                           MnextState = `sendingStopStart;
                           semForever = 1;
                       end
                   end
               
                   WRDI:
                   begin
                       if(MnextState != `holdS)
                       begin
                           MnextState = `sendingStopStart;
                           semForever = 1;
                       end
                   end

                   RDSR:
                   begin
                       if(MnextState != `holdS)
                       begin
                           recDataCounter = 0;
                           initBufReadData;
                           lSeq = 1;
                           seqCounter = lSeq;
                           MnextState = `receivingData;
                           SI= 1'b0;
                           #(tHALF-tH) MbitCounter = 1;
                       end
                   end

                   WRSR:
                   begin
                       if(MnextState != `holdS)
                       begin
                           lSeq = 1;
                           seqCounter = lSeq;
                           MnextState = `sendingData;
                           MbitCounter = 1;
                       end
                   end 

					

                   WRSN:
                   begin
                       if(MnextState != `holdS)
                       begin
                           lSeq = 8;
                           seqCounter = lSeq;
						   bufwrite;
                           MnextState = `sendingData;
                           MbitCounter = 1;
                       end
                   end
					
				   SSWR:
                   begin
                       if(MnextState != `holdS)
                       begin
                           lSeq = 8;
                           seqCounter = lSeq;
						   bufwrite;
                           MnextState = `sendingAdd;
                           addrBytesCounter = addrBytes;
                           MbitCounter = 1;
                       end
                   end
				   
                   READ:
                   begin
                       if(MnextState != `holdS)
                       begin
                           seqCounter = lSeq;
                           recDataCounter = 0;
                           initBufReadData;
                           MnextState = `sendingAdd;
                           addrBytesCounter = addrBytes;
                       end
                   end  
				   
                   SSRD:
                   begin
                       if(MnextState != `holdS)
                       begin
                           seqCounter = lSeq;
                           recDataCounter = 0;
                           initBufReadData;
                           MnextState = `sendingAdd;
                           addrBytesCounter = addrBytes;
                       end
                   end                

                   WRITE:
                   begin
                       if(MnextState != `holdS)
                       begin
                           seqCounter = lSeq;
                           MnextState = `sendingAdd;
                           addrBytesCounter = addrBytes;
                           createIncremFillPattern;
                       end
                   end
					
                   FSTRD:
                   begin
                       if(MnextState != `holdS)
                       begin
                           seqCounter = lSeq;
                           recDataCounter = 0;
                           initBufReadData;
                           MnextState = `sendingAdd;
                           addrBytesCounter = addrBytes;
                       end
                   end
                   
                   RDID:
                   begin
                       if(MnextState != `holdS)
                       begin
                           recDataCounter = 0;
                           initBufReadData;
                           lSeq = 9;
                           seqCounter = lSeq;
                           MnextState = `receivingData;
                           SI= 1'b0;
                           #(tHALF-tH) MbitCounter = 1;
                       end                   
                   end
                   
                   RDSN:
                   begin
                       if(MnextState != `holdS)
                       begin
                           recDataCounter = 0;
                           initBufReadData;
                           lSeq = 8;
                           seqCounter = lSeq;
                           MnextState = `receivingData;
                           SI= 1'b0;
                           #(tHALF-tH) MbitCounter = 1;
                       end                   
                   end
                   
                   SLEEP:
                   begin
                       if(MnextState != `holdS)
                       begin
                           MnextState = `sendingStopStart;
                           semForever = 1;
                       end
                   end
                   
                   DPD:
                   begin
                       if(MnextState != `holdS)
                       begin
                           MnextState = `sendingStopStart;
                           semForever = 1;
                       end
                   end
                   
                   default:
                   begin
                       MnextState = `sendingStopStart;
                       semForever = 1;
                   end
               endcase
               
               SI = MtempReg[7];
               #(tSU+tH) SI = 1'b0; 
           end
        end

        `sendingAdd:        // 00 & 11
        begin
            if(MbitCounter==8 && sem == 0)
            begin
                #(tHALF-tSU) MbitCounter=1;
                sem = 1;
            end
            case(MbitCounter)
            1:
            begin
                if(addr > addrMax)
                begin
                    $display;
                    $display("\t *** WARNING: address specified in Input.v (%h) higher than the maximum one (%h) !",addr,addrMax);
                    for(i=15; i >= `addrBits; i=i-1)
                        addr[i]=0;  
                    $display("\t ***          it will be considered as %h !",addr);
                    $display;
                end

                if(addrBytesCounter == 3) 
                begin
                `ifdef THREE_BYTE_ADDR
                   MtempReg = addr[`addrBits-1:16];
                   $display("            MASTER: sent addr[%d:16]:             %h",`addrBits-1, MtempReg);
                `endif
                end
                else if(addrBytesCounter == 2) 
                begin
                    if(`addrBits > 16)
                    begin
                    `ifdef THREE_BYTE_ADDR                    
                       MtempReg = addr[15:8];
                       $display("            MASTER: sent addr[15:8]:             %h",MtempReg);
                    `endif  
                    end
                    else
                    begin
                       MtempReg = addr[`addrBits-1:8];
                       $display("            MASTER: sent addr[%d:8]:             %h",`addrBits-1, MtempReg);
                    end
                end
                else
                begin
                    MtempReg = addr[7:0];
                    $display("            MASTER: sent addr[ 7:0]:             %h",MtempReg);
                end

                if(MnextState != `holdS)
                begin
                    SI = MtempReg[7];
                    #0 MtempReg = MtempReg << 1;
                end
                #(tSU+tH) SI = 0;

                #(tHALF-tSU-tH) if(MnextState != `holdS)
                begin
                    if(prevState != `holdS)
                        begin
                        #tHALF MbitCounter = MbitCounter + 1;
                    end
                    else
                    begin
                        MbitCounter = MbitCounter + 1;
                    end
                    SI = MtempReg[7];
                    MtempReg = MtempReg << 1;
                    #(tSU+tH) SI = 0;
                end
            end
            
            default:
            begin
                #(tHALF-tSU) SI = MtempReg[7];
                if(MbitCounter < 8) 
                begin
                    MbitCounter = MbitCounter + 1;
                end
                #(tSU+tH) SI = 0;
                MtempReg = MtempReg << 1;
                if(MbitCounter==8)
                begin
                    sem = 0;
                   
                    case(addrBytesCounter)
                    1:
                    begin
                        case(Minstruction)
                        READ:
                        begin
                            if(MnextState != `holdS)
                            begin
                                MnextState = `receivingData;
                                SI= 1'b0;
                                #(tHALF-tH) MbitCounter = 1;
                            end
                        end
                        
                        FSTRD:
                        begin
                            seqCounter = 1;
                            if(MnextState != `holdS)
                            begin
                                MnextState = `sendingData;
                                SI= 1'b0;
                                MbitCounter = 1;
                            end
                        end
						
                        SSRD:
                        begin
                            if(MnextState != `holdS)
                            begin
                                MnextState = `receivingData;
                                SI= 1'b0;
                                #(tHALF-tH) MbitCounter = 1;
                            end
                        end
                            
                        RDSR:
                        begin
                            if(MnextState != `holdS)
                            begin
                                MnextState = `receivingData;
                                SI= 1'b0;
                                #(tHALF-tH) MbitCounter = 1;
                            end
                        end
                     
                        WRITE:
                        begin
                            if(MnextState != `holdS)
                            begin
                                MnextState = `sendingData;
                                SI= 1'b0;
                                MbitCounter = 1;
                            end
                        end
                     
                        SSWR:
                        begin
                            if(MnextState != `holdS)
                            begin
                                MnextState = `sendingData;
                                SI= 1'b0;
                                MbitCounter = 1;
                            end
                        end
                        endcase
                     
                        addrBytesCounter = addrBytesCounter-1;
                    end
                    
                    2:
                    begin
                        if(MnextState != `holdS)
                        begin
                            MnextState = `sendingAdd;
                            addrBytesCounter = addrBytesCounter-1;
                            #(2*tHALF-tSU-tH) MbitCounter = 1;
                            MtempReg = addr[7:0];
                            $display("            MASTER: sent addr[ 7:0]:             %h",MtempReg);
                            SI = MtempReg[7];
                            #0 MtempReg = MtempReg << 1;
                            #(tSU+tH) SI = 0;
                            #(2*tHALF-tSU-tH)if(MnextState != `holdS)
                            begin
                                MbitCounter = MbitCounter + 1;
                                SI = MtempReg[7];
                                MtempReg = MtempReg << 1;
                                #(tSU+tH) SI = 0;
                            end
                        end
                    end
                    
                    3:
                    begin
                        if(MnextState != `holdS)
                        begin
                            MnextState = `sendingAdd;
                            addrBytesCounter = addrBytesCounter-1;
                            #(2*tHALF-tSU-tH) MbitCounter = 1;
                            MtempReg = addr[`addrBits-1:8];
                            $display("            MASTER: sent addr[ 15:8]:             %h",MtempReg);
                            SI = MtempReg[7];
                            #0 MtempReg = MtempReg << 1;
                            #(tSU+tH) SI = 0;
                            #(2*tHALF-tSU-tH)if(MnextState != `holdS)
                            begin
                                MbitCounter = MbitCounter + 1;
                                SI = MtempReg[7];
                                MtempReg = MtempReg << 1;
                                #(tSU+tH) SI = 0;
                            end
                        end
                    end
                    endcase
                end
            end
            endcase
        end

        `sendingData:       // 00 & 11
        begin
            if(MbitCounter==8 && sem == 0)
            begin
                #(tHALF-tSU) MbitCounter=1;
                sem = 1;
            end
            case(MbitCounter)
            1:
            begin
                if(lSeq ==1)
                begin
                    MtempReg = data[0];
                    bufWriteData[0] = data[0];
                end
                else
                begin
                    MtempReg = bufWriteData[lSeq-seqCounter];
                end
                $display("            MASTER: sent data %d:         %h",lSeq-seqCounter+1,MtempReg);

                #(tHALF-tSU) SI = MtempReg[7];
                MtempReg = MtempReg << 1;
                #(tSU+tH) SI = 0;
            
                #(tHALF-tH) if(MnextState != `holdS)
                begin
                    if(prevState != `holdS)
                        MbitCounter = MbitCounter + 1;
                    else
                        MbitCounter = MbitCounter + 1;
                end

                #(tHALF-tSU) SI = MtempReg[7];
                MtempReg = MtempReg << 1;
                #(tSU+tH) SI = 0;

            end
            default:
            begin
                #(tHALF-tSU) SI = MtempReg[7];
                MtempReg = MtempReg << 1;           
                #(tSU+tH) SI = 0;

                if(MbitCounter < 8) 
                    MbitCounter = MbitCounter + 1;
        
                if(MbitCounter==8)
                begin
                    sem = 0;
                    seqCounter = seqCounter - 1;
                    if(seqCounter == 0)
                    begin       
                        if(Minstruction == FSTRD)
                        begin
                            seqCounter = lSeq;
                            MnextState = `receivingData;
                            SI= 1'b0;
                            #(tHALF-tH) MbitCounter = 1;
                        end
                        else
                        begin
                            Mstate = `sendingStopStart;
                            MnextState = `sendingStopStart;
                            #(tHALF-tH-delta) semForever = 1;
                            if(Minstruction != WRSR)
                            begin
                                seqLength = lSeq;
                                displayData;
                            end
                        end
                    end
                    else
                    begin
                        sem=0;
                        #(2*tHALF-tSU-tH) MbitCounter = 1;
                        MtempReg = bufWriteData[lSeq-seqCounter];
                        //$display("            MASTER: sent data %d:           %h",lSeq-seqCounter+1,MtempReg);
                        SI = MtempReg[7];
                        #0 MtempReg = MtempReg << 1;
                        #(tSU+tH) SI = 0;
                        #(2*tHALF-tSU-tH) MbitCounter = MbitCounter + 1;
                        SI = MtempReg[7];
                        MtempReg = MtempReg << 1;
                        #(tSU+tH) SI = 0;
                    end
                end
            end
            endcase
        end

        `sendingStopStart:
        begin
            if(mode == 2'b11)
                SCK = 1'b1;
            semForever = 1;
            MbitCounter = 0;
            addr = 16'h0000;
            crtMemAddr = 16'h0000;
            realCrtMemAddr = 16'h0000;
            seqCounter = lSeq;
            //
            //  Test next steps
            //
                begin
                case(TestPhase)
                `include "Input.v"

                default:
                begin
                   if(stop == 1)
                      $stop;
                end
                
                endcase
                TestPhase = TestPhase + 1;
                end

            //
            prevInstruction = Minstruction;
            manNr = TestPhase-1;
            #0 case(Minstruction)
            WREN:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) WREN  (Enable Write)    Time: ",manNr,$time);
                end
            WRDI:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) WRDI  (Disable Write)    Time: ",manNr,$time);
                end
            RDSR:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) RDSR  (Read Status Register)   Time: ",manNr,$time);
                end
            WRSR:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) WRSR  (Write Status Register)   Time: ",manNr,$time);
                $display("    data: %h",data[0]);
                end
            READ:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) READ  (Read Data from Memory)   Time: ",manNr,$time);
                $display("    address:         %h",addr);
                $display("    sequence length: %d",lSeq);
                end
            WRITE:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) WRITE  (Write Data to Memory)  Time: ",manNr,$time);
                $display("    address:         %h",addr);
                $display("    sequence length: %d",lSeq);
                end
                
            FSTRD:
                begin
                $display(" ");
                $display("******************************************************************");
                
                `ifdef ONE_BYTE_ADDR
                    $display("%d) READ  Time: ",manNr,$time);                
                `else
                    $display("%d) FSTRD  (Fast Read)  Time: ",manNr,$time);
                `endif
                $display("    address:         %h",addr);
                $display("    sequence length: %d",lSeq);
                end
                
            SLEEP:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) SLEEP  (Sleep Command)  Time: ",manNr,$time);
                end
                
            RDID:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) RDID  (Read Device ID)  Time: ",manNr,$time);
                end  
                
            RDSN:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) Serial Number Time: ",manNr,$time);
                end     
                
            WRSN:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) Write Serial Number Time: ",manNr,$time);
                end     
                
            SSWR:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) Write Special sector Memory Time: ",manNr,$time);
                end    
                
            SSRD:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) Read Special sector Memory Time: ",manNr,$time);
                end            
            
            default:
                begin
                $display(" ");
                $display("******************************************************************");
                $display("%d) WRONG_OPCODE  Time: ",manNr,$time);
                end
            endcase
            //
            if(mode == 2'b00)
                begin
                seqCounter = lSeq;
                #tCSH CSB = 1;  
                end
            else
                begin
                seqCounter = lSeq;
                //=============
                #tCSH CSB = `B1;    // STOP
                end

            if(mode == 2'b00)
                begin
                //=================
                #tD CSB =`B0;       //START
                //  $display("            MASTER: sending START at time ",$time);
                Mstate = `sendingInstruction;
                MnextState = `sendingInstruction;
                #(tCSU-tSU) MbitCounter = 0;

                if(mode == 2'b0)
                    begin
                    `ifdef ONE_BYTE_ADDR
                    if(Minstruction == READ || Minstruction == WRITE)
                       MtempReg = {Minstruction[7:4],addr[8],Minstruction[2:0]} ;
                    else
                       MtempReg = Minstruction;                                        
                    `else
                    MtempReg = Minstruction;                    
                    `endif
                    
                    $display("            MASTER: sent instruction:         %b",MtempReg);
                    SI = MtempReg[7];
                    #0 MtempReg = MtempReg << 1;
                    //if(MbitCounter == 0)
                    MbitCounter = MbitCounter+1;
                    #tSU SCK = `B1;
                    semForever = 0;
                    ->reinitClockForStart;
                    #tH SI=0;
                    end
                else
                    begin
                    `ifdef ONE_BYTE_ADDR
                    if(Minstruction == READ || Minstruction == WRITE)
                       MtempReg = {Minstruction[7:4],addr[8],Minstruction[2:0]};
                    else
                       MtempReg = Minstruction;
                    `else
                    MtempReg = Minstruction;                    
                    `endif

                    $display("            MASTER: sent instruction:         %b",MtempReg);
                    SI = MtempReg[7];
                    #0 MtempReg = MtempReg << 1;
                    MbitCounter = MbitCounter+1;
                    #tSU SCK = `B1;
                    savState = MnextState;
                    MnextState = `idle;
                    semForever = 0;
                    ->reinitClockForStart;          
                    #(tHALF/2) MnextState = savState;
                    end
                //=================
                end
            else            //mode == 2'b11
                begin
                if(mode == 2'b11)
                    begin
                    //=================
                    #400 SCK = `B1;
                    semForever = 0;
                    ->reinitClockForStart;
                    //--------------
                    #(tHALF/2) CSB =`B0;        //START
                    //  $display("            MASTER: sending START at time ",$time);
                    #(tHALF/2) Mstate = `sendingInstruction;
                    MnextState = `sendingInstruction;
                    MbitCounter = 0;
                    MtempReg = Minstruction;

                    $display("            MASTER: sent instruction:         %b",MtempReg);
                    SI = MtempReg[7];
                    #0 MtempReg = MtempReg << 1;
                    #tHALF MbitCounter = MbitCounter+1;
                    //================
                    end
                end
            end
        endcase 
    end
end 

endmodule

