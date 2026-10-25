###################################################################

# Created by write_sdc on Thu Aug 20 14:16:44 2026

###################################################################
set sdc_version 2.2

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_operating_conditions ss0p95v125c -library saed32hvt_ss0p95v125c
set_max_area 0
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports HRESETn]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[31]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[30]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[29]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[28]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[27]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[26]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[25]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[24]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[23]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[22]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[21]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[20]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[19]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[18]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[17]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[16]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[15]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[14]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[13]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[12]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[11]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[10]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[9]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[8]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[7]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[6]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[5]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[4]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[3]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[2]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[1]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HADDR[0]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[31]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[30]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[29]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[28]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[27]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[26]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[25]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[24]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[23]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[22]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[21]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[20]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[19]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[18]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[17]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[16]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[15]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[14]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[13]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[12]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[11]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[10]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[9]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[8]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[7]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[6]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[5]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[4]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[3]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[2]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[1]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWDATA[0]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWSTRB[3]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWSTRB[2]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWSTRB[1]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HWSTRB[0]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports HWRITE]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HTRANS[1]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports {HTRANS[0]}]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports UART_Rx]
set_driving_cell -max -lib_cell NAND2X1_RVT -library saed32rvt_ss0p95v125c     \
-pin Y -no_design_rule [get_ports SPI_MISO]
set_load -pin_load 1.43429 [get_ports {HRDATA[31]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[30]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[29]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[28]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[27]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[26]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[25]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[24]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[23]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[22]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[21]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[20]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[19]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[18]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[17]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[16]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[15]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[14]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[13]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[12]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[11]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[10]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[9]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[8]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[7]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[6]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[5]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[4]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[3]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[2]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[1]}]
set_load -pin_load 1.43429 [get_ports {HRDATA[0]}]
set_load -pin_load 1.43429 [get_ports HREADY]
set_load -pin_load 1.43429 [get_ports UART_Tx]
set_load -pin_load 1.43429 [get_ports SPI_MOSI]
set_load -pin_load 1.43429 [get_ports SPI_SCK]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[3]}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[2]}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[1]}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[0]}]
set_load -pin_load 1.43429 [get_ports I2C_SDA]
set_load -pin_load 1.43429 [get_ports I2C_SCL]
set_max_capacitance 1.43429 [get_ports HRESETn]
set_max_capacitance 1.43429 [get_ports {HADDR[31]}]
set_max_capacitance 1.43429 [get_ports {HADDR[30]}]
set_max_capacitance 1.43429 [get_ports {HADDR[29]}]
set_max_capacitance 1.43429 [get_ports {HADDR[28]}]
set_max_capacitance 1.43429 [get_ports {HADDR[27]}]
set_max_capacitance 1.43429 [get_ports {HADDR[26]}]
set_max_capacitance 1.43429 [get_ports {HADDR[25]}]
set_max_capacitance 1.43429 [get_ports {HADDR[24]}]
set_max_capacitance 1.43429 [get_ports {HADDR[23]}]
set_max_capacitance 1.43429 [get_ports {HADDR[22]}]
set_max_capacitance 1.43429 [get_ports {HADDR[21]}]
set_max_capacitance 1.43429 [get_ports {HADDR[20]}]
set_max_capacitance 1.43429 [get_ports {HADDR[19]}]
set_max_capacitance 1.43429 [get_ports {HADDR[18]}]
set_max_capacitance 1.43429 [get_ports {HADDR[17]}]
set_max_capacitance 1.43429 [get_ports {HADDR[16]}]
set_max_capacitance 1.43429 [get_ports {HADDR[15]}]
set_max_capacitance 1.43429 [get_ports {HADDR[14]}]
set_max_capacitance 1.43429 [get_ports {HADDR[13]}]
set_max_capacitance 1.43429 [get_ports {HADDR[12]}]
set_max_capacitance 1.43429 [get_ports {HADDR[11]}]
set_max_capacitance 1.43429 [get_ports {HADDR[10]}]
set_max_capacitance 1.43429 [get_ports {HADDR[9]}]
set_max_capacitance 1.43429 [get_ports {HADDR[8]}]
set_max_capacitance 1.43429 [get_ports {HADDR[7]}]
set_max_capacitance 1.43429 [get_ports {HADDR[6]}]
set_max_capacitance 1.43429 [get_ports {HADDR[5]}]
set_max_capacitance 1.43429 [get_ports {HADDR[4]}]
set_max_capacitance 1.43429 [get_ports {HADDR[3]}]
set_max_capacitance 1.43429 [get_ports {HADDR[2]}]
set_max_capacitance 1.43429 [get_ports {HADDR[1]}]
set_max_capacitance 1.43429 [get_ports {HADDR[0]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[31]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[30]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[29]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[28]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[27]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[26]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[25]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[24]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[23]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[22]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[21]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[20]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[19]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[18]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[17]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[16]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[15]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[14]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[13]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[12]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[11]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[10]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[9]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[8]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[7]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[6]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[5]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[4]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[3]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[2]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[1]}]
set_max_capacitance 1.43429 [get_ports {HWDATA[0]}]
set_max_capacitance 1.43429 [get_ports {HWSTRB[3]}]
set_max_capacitance 1.43429 [get_ports {HWSTRB[2]}]
set_max_capacitance 1.43429 [get_ports {HWSTRB[1]}]
set_max_capacitance 1.43429 [get_ports {HWSTRB[0]}]
set_max_capacitance 1.43429 [get_ports HWRITE]
set_max_capacitance 1.43429 [get_ports {HTRANS[1]}]
set_max_capacitance 1.43429 [get_ports {HTRANS[0]}]
set_max_capacitance 1.43429 [get_ports UART_Rx]
set_max_capacitance 1.43429 [get_ports SPI_MISO]
create_clock [get_ports HCLK]  -period 10  -waveform {0 5}
set_clock_uncertainty -setup 1  [get_clocks HCLK]
set_input_delay -clock HCLK  6  [get_ports {HADDR[31]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[30]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[29]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[28]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[27]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[26]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[25]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[24]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[23]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[22]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[21]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[20]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[19]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[18]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[17]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[16]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[15]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[14]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[13]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[12]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[11]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[10]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[9]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[8]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[7]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[6]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[5]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[4]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[3]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[2]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[1]}]
set_input_delay -clock HCLK  6  [get_ports {HADDR[0]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[31]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[30]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[29]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[28]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[27]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[26]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[25]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[24]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[23]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[22]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[21]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[20]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[19]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[18]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[17]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[16]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[15]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[14]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[13]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[12]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[11]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[10]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[9]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[8]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[7]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[6]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[5]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[4]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[3]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[2]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[1]}]
set_input_delay -clock HCLK  6  [get_ports {HWDATA[0]}]
set_input_delay -clock HCLK  6  [get_ports {HWSTRB[3]}]
set_input_delay -clock HCLK  6  [get_ports {HWSTRB[2]}]
set_input_delay -clock HCLK  6  [get_ports {HWSTRB[1]}]
set_input_delay -clock HCLK  6  [get_ports {HWSTRB[0]}]
set_input_delay -clock HCLK  6  [get_ports HWRITE]
set_input_delay -clock HCLK  6  [get_ports {HTRANS[1]}]
set_input_delay -clock HCLK  6  [get_ports {HTRANS[0]}]
set_input_delay -clock HCLK  6  [get_ports UART_Rx]
set_input_delay -clock HCLK  6  [get_ports SPI_MISO]
set_input_delay -clock HCLK  6  [get_ports I2C_SDA]
set_input_delay -clock HCLK  6  [get_ports I2C_SCL]
set_output_delay -clock HCLK  6  [get_ports I2C_SDA]
set_output_delay -clock HCLK  6  [get_ports I2C_SCL]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[31]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[30]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[29]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[28]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[27]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[26]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[25]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[24]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[23]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[22]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[21]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[20]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[19]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[18]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[17]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[16]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[15]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[14]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[13]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[12]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[11]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[10]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[9]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[8]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[7]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[6]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[5]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[4]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[3]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[2]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[1]}]
set_output_delay -clock HCLK  6  [get_ports {HRDATA[0]}]
set_output_delay -clock HCLK  6  [get_ports HREADY]
set_output_delay -clock HCLK  6  [get_ports UART_Tx]
set_output_delay -clock HCLK  6  [get_ports SPI_MOSI]
set_output_delay -clock HCLK  6  [get_ports SPI_SCK]
set_output_delay -clock HCLK  6  [get_ports {SPI_CS_n[3]}]
set_output_delay -clock HCLK  6  [get_ports {SPI_CS_n[2]}]
set_output_delay -clock HCLK  6  [get_ports {SPI_CS_n[1]}]
set_output_delay -clock HCLK  6  [get_ports {SPI_CS_n[0]}]
