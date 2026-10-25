//*******************************************************************************************************
// Copyright(c) Cypress Semiconductor, 2019. All rights reserved.
// This model is the property of Cypress Semiconductor Corp.
// and is protected by the US copyright laws, any unauthorized
// copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional 
// specifications without any prior notice.
// Cypress is not liable for any damages which may result from
// the use of this functional model
// -------------------------------------------------------------------------------------------------------
// File name : Input.v
// -------------------------------------------------------------------------------------------------------
// Functionality : Input File of Verilog behavourial Model for Excelon SPI F-RAM
// Source:  CYPRESS Data Sheet : 
// Version:  2.0 Feb 27, 2017
// -------------------------------------------------------------------------------------------------------
// Developed by CYPRESS SEMICONDUCTOR
//
// version |   author     | mod date | changes made
//    1.0  |    MEDU      | 02/27/17 | New Model
//    1.1  |    ZSK       | 10/15/19 | Replaced SERIAL_NO with actual opcode RDSN
//                                   | Updated the copyright year
// -------------------------------------------------------------------------------------------------------
// PART DESCRIPTION :
// Part:        All parts of Secelon SPI F-RAM
//
// Descripton:  Verilog behavourial Model  for Excelon SPI F-RAM
// ----------------------------------------------------------------------------------------------------------  
//
//	Test Menu (patterns to be copied and modified by user)
//
// Input Data Sequence 
//
1:
    begin
	$display;
	$display("############# TEST MEM WRITE ##############");
	$display;
	Minstruction = WREN;
	end
2:
	begin
	Minstruction = WRITE;
	addr = 18'h00000;
	lSeq = 1;	
	data[0] = 8'h00;
	end
3:
	begin
	$display;
	$display("############# TEST WRSR ##############");
	$display;
	WP = 1;
	Minstruction = WREN;
	end
4:
	begin
	Minstruction = WRSR;
	data[0] = 8'h00;
	end
5:
	begin
	Minstruction = RDSR;
	end
6:
	begin
	$display;
	$display("############# TEST WRITE BYTE ##############");
	$display;
	Minstruction = WREN;
	end
7:
	begin
	Minstruction = WRITE;
	addr = 18'h3fff5;
	lSeq = 32;	
	data[0] = 8'hFF;
	end
8:
	begin
	Minstruction = READ;
	addr = 18'h3fff5;
	lSeq = 32;	
	end
	
9:
	begin
	$display;
	$display("############# TEST WRONG OPERATION CODE DETECTION ##############");
	$display;
	Minstruction = WRONG_OPCODE;
	MbitCounter = 0;
	end

10:
	begin
	$display;
	$display("############# TEST WRITE WITHOUT PREVIOUS WREN ##############");
	$display;
	Minstruction = WRITE;
	addr = 18'h3fff5;
	lSeq = 1;	
	data[0] = 8'h11;
	end
11:
	begin
	Minstruction = READ;
	addr = 18'h3fff5;
	lSeq = 1;	
	end
12:
	begin
	$display;
	$display("############# TEST BURST WRITE ##############");
	$display;
	Minstruction = WREN;
	end
13:
	begin
	Minstruction = WRITE;
	addr = 8'h10;
	lSeq = 16;
	pattern = 8'h01;
	end
14:
	begin
	Minstruction = READ;
	addr = 8'h10;
	lSeq = 16;	
	end
15:
	begin
	$display;
	$display("############# TEST SOFT PROTECTION - QUARTER ##############");
	$display;
	Minstruction = WREN;
	end
16:
	begin
	Minstruction = WRSR;
	data[0] = 8'h04;	// quarter prot.
	end
17:
	begin
	Minstruction = RDSR;
	end
18:
	begin
	Minstruction = WREN;
	end
19:
	begin
	Minstruction = WRITE;
	addr = 19'h7fff0;
	lSeq = 32;	
	data[0] = 8'h55;
	end
20:
	begin
	Minstruction = WREN;
	end
21:
	begin
	Minstruction = WRITE;
	addr = 8'h60;
	lSeq = 16;	
	data[0] = 8'h66;
	end

22:
	begin
	Minstruction = READ;
	addr = 19'h7fff0;
	lSeq = 32;	
	end


23:
	begin
	$display;
	$display("############# TEST SOFT PROTECTION - HALF ##############");
	$display;
	Minstruction = WREN;
	end

24:
	begin
	Minstruction = WRSR;
	data[0] = 8'h08;	// half prot.
	end
25:
	begin
	Minstruction = WREN;
	end
26:
	begin
	Minstruction = WRITE;
	if(`addrBits == 19)
	   addr = 19'h3fff0;	
	else if(`addrBits == 18)
	   addr = 18'h1fff0;
	else if(`addrBits == 17)
	   addr = 18'h0fff0;
	else if(`addrBits == 16)
	   addr = 18'h07ff0;
	else if(`addrBits == 15)
	   addr = 18'h03ff0;	   
	else if(`addrBits == 14)
	   addr = 18'h01ff0;	   
	else if(`addrBits == 13)
	   addr = 18'h00ff0;	
	else if(`addrBits == 11)
	   addr = 18'h003f0;		   
	else if(`addrBits == 9)
	   addr = 18'h000f0;		   	   
	   
	lSeq = 32;	
	data[0] = 8'h33;
	end
27:
	begin
	Minstruction = WREN;
	end
28:
	begin
	Minstruction = WRITE;
	addr = 19'h7fff0;
	lSeq = 32;	
	data[0] = 8'h44;
	end

29:
	begin
	Minstruction = READ;
	if(`addrBits == 19)
	   addr = 19'h3fff0;
	else if(`addrBits == 18)
	   addr = 18'h1fff0;
	else if(`addrBits == 17)
	   addr = 18'h0fff0;
	else if(`addrBits == 16)
	   addr = 18'h07ff0;
	else if(`addrBits == 15)
	   addr = 18'h03ff0;	   
	else if(`addrBits == 14)
	   addr = 18'h01ff0;	   
	else if(`addrBits == 13)
	   addr = 18'h00ff0;	
	else if(`addrBits == 11)
	   addr = 18'h003f0;		   
	else if(`addrBits == 9)
	   addr = 18'h000f0;
	
	lSeq = 32;	
	
	end

30:
	begin
	$display;
	$display("############# TEST SOFT PROTECTION - FULL ##############");
	$display;
	Minstruction = WREN;
	end
31:
	begin
	Minstruction = WRSR;
	data[0] = 8'h0C;	// full prot.
	end
32:
	begin
	Minstruction = RDSR;
	end
33:
	begin
	Minstruction = WREN;
	end
34:
	begin
	Minstruction = WRITE;
	addr = 19'h7fff0;
	lSeq = 32;	
	data[0] = 8'h77;
	end
35:
	begin
	Minstruction = WREN;
	end
36:
	begin
	Minstruction = WRITE;
	addr = 8'h60;
	lSeq = 16;	
	data[0] = 8'h66;
	end

37:
	begin
	Minstruction = READ;
	addr = 19'h7fff0;
	lSeq = 32;	
	end

38:
	begin
	$display;
	$display("############# TEST SOFT PROTECTION - UNPROTECT ##############");
	$display;
	Minstruction = WREN;
	end
	
39:
	begin
	Minstruction = WRSR;
	data[0] = 8'h00;	// No prot.
	end
	
40:
	begin
	Minstruction = RDSR;
	end
	
41:
	begin
	Minstruction = WREN;
	end
	
42:
	begin
	Minstruction = WRITE;
	addr = 19'h7fff0;
	lSeq = 32;	
	data[0] = 8'h77;
	end
43:
	begin
	Minstruction = WREN;
	end
44:
	begin
	Minstruction = READ;
	addr = 19'h7fff0;
	lSeq = 32;	
	end

45:
	begin
	$display;
	$display("############# TEST HARDWARE PROTECTION ##############");
	$display;
	WP = 0;
	Minstruction = WREN;

	end

46:
	begin
	Minstruction = WRSR;
	data[0] = 8'h88;
	end

47:
	begin
	Minstruction = RDSR;
	end

48:
	begin
	WP = 1;
	Minstruction = WRSR;
	data[0] = 8'h00;
	end

49:
	begin
	Minstruction = RDSR;
	end
		
50:
	begin
	Minstruction = WREN;
	end

51:
	begin
	Minstruction = WRITE;
	addr = 19'h7fff0;
	lSeq = 32;	
	data[0] = 8'h99;
	end
	
52:
	begin
	Minstruction = READ;
	addr = 19'h7fff0;
	lSeq = 32;	
	end

53:
	begin
	Minstruction = RDSR;
	end

54:
	begin
	$display;
	$display;
	Minstruction = FSTRD;
	addr = 19'h7fff5;
	lSeq = 32;	
	end	
	
55:
	begin
	Minstruction = RDID;
	end	

56:
	begin
	Minstruction = SLEEP;
	end

57:
	begin
	$display;
	$display;
	Minstruction = FSTRD;
	addr = 19'h7fff5;
	lSeq = 32;	
	end	
	
58:
	begin
	Minstruction = RDID;
	end	

59:
	begin
        #tREC;
	$display;
	$display;
	Minstruction = FSTRD;
	addr = 19'h7fff5;
	lSeq = 32;	
	end	
	
60:
	begin
	Minstruction = RDID;
	end
	
61:
	begin
	Minstruction = RDSN;
	end
	
62:
	begin
	Minstruction = WREN;
	end


// Power Cycle Tests
63:
	begin
	Minstruction = WREN;	
	end
	
64:
	begin	
	Minstruction = WRITE;
	addr = 19'h00000;
	lSeq = 32;
	data[0] = 8'h11;	
	end
	
65:
	begin	
	Minstruction = READ;
	addr = 19'h00000;
	lSeq = 32;			
	end

66:
	begin
	VDD_CTL = 0;
	Minstruction = READ;
	addr = 19'h00000;
	lSeq = 32;	
	end
	
67:
	begin	
	VDD_CTL = 1;
	Minstruction = READ;
	addr = 19'h00000;
	lSeq = 32;		
	end

68:
	begin
	#tPU;
	Minstruction = READ;
	addr = 19'h00000;
	lSeq = 32;		
	end

69: 
    begin
    Minstruction = SLEEP;
    end

70:
	begin	
	VDD_CTL = 0;
	#10_0000;
	VDD_CTL = 1;
 	#tPU;	
	Minstruction = READ;
	addr = 19'h00000;
	lSeq = 32;			
	end

71:
	begin
	Minstruction = WREN;	
	end
	
72:
	begin	
	VDD_CTL = 0;
	#100;
	VDD_CTL = 1;
	#tPU;	
	Minstruction = WRITE;
	addr = 19'h00000;
	lSeq = 32;
	data[0] = 8'h56;
	end	

73:
	begin	
	Minstruction = READ;
	addr = 19'h00000;
	lSeq = 32;			
	end	
	
74:
	begin
	Minstruction = RDSN;
	end

75:
	begin
	Minstruction = WREN;	
	end

76: 
	begin
	$display;
	$display("############# Testing WRSN OPCODE ##############");
	$display;
	Minstruction = WRSN;
	data[0] = 8'h01;
	data[1] = 8'h02;
	data[2] = 8'h03;
	data[3] = 8'h04;
	data[4] = 8'h05;
	data[5] = 8'h06;
	data[6] = 8'h07;
	data[7] = 8'h08;
	end
	
77:
	begin
	Minstruction = RDSN;
	end

78:
	begin
	Minstruction = WREN;	
	end

79: 
	begin
	$display;
	$display("############# Testing SSWR OPCODE ##############");
	$display;
	Minstruction = SSWR;
	addr = 24'h000F;
	data[0] = 8'h01;
	data[1] = 8'h02;
	data[2] = 8'h03;
	data[3] = 8'h04;
	data[4] = 8'h05;
	data[5] = 8'h06;
	data[6] = 8'h07;
	data[7] = 8'h08;
	end

80:
	begin
	Minstruction = SSRD;
	addr = 24'h000F;	
	end
	
81:
	begin	
        stop = 1;
	end	
	