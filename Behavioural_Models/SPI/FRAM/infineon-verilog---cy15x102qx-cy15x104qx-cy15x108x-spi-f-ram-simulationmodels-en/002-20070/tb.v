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
// File name : tb.v
// -------------------------------------------------------------------------------------------------------
// Functionality : Verilog test bench for Excelon SPI F-RAM
// Source:  CYPRESS Data Sheet : 
// Version:  1.0 Feb 27, 2017
// -------------------------------------------------------------------------------------------------------
// Developed by CYPRESS SEMICONDUCTOR
//
// version |   author     | mod date | changes made
//    1.0  |    MEDU      | 14/03/14 | New Model
//    1.1  |    MEDU      | 02/27/17 | Added VDD to F-RAM
//    1.2  |    ZSK       | 10/15/19 | Updated the copyright year
// -------------------------------------------------------------------------------------------------------
// PART DESCRIPTION :
// Part:        All parts of Excelon SPI F-RAM
//
// Descripton:  Verilog behavourial Model for Excelon SPI F-RAM SPI
// ----------------------------------------------------------------------------------------------------------  

`timescale 1ns/10ps   

module tb();

reg WPTST,HOLDTST;

wire VDD_CTL;

wire VDD = VDD_CTL;

//===================== MASTER PARAMETERS DEFINING ===============
//
//   SPI mode
//
defparam m.mode = 2'b00;
////  defparam m.mode = 2'b11;
//
//  Clock frequency
//
defparam m.frequency = 20000000;    // clock frequency (in Hz) 
//
//  Timing (uncomment and specify the desired times used by master
//  when they differ from the default ones (which are that of datasheets))
//  
//====================  PROTOCOL MODULES INSTANTIATION =============
//
FRAM_SPI s(CSB,SCK,SI,SO,WP,VDD);
SPI_Master m(SI,SO,SCK,CSB,WPTST,WP,HOLDTST,HOLDS, VDD_CTL);
initial
begin
    HOLDTST = 1;
    WPTST = 1;
end
endmodule 
