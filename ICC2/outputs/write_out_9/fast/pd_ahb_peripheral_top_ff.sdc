################################################################################
#
# Design name:  filler_precheck_1
#
# Created by icc2 write_sdc on Fri Aug 21 14:04:53 2026
#
################################################################################

set sdc_version 2.2
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: fast_mode
# Corner: ff1p16v25
# Scenario: ff_scenario

# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 275
create_clock -name HCLK -period 10 -waveform {0 5} [get_ports {HCLK}]
set_propagated_clock [get_clocks {HCLK}]
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
set_load -pin_load 1.43429 [get_ports {HREADY}]
set_load -pin_load 1.43429 [get_ports {UART_Tx}]
set_load -pin_load 1.43429 [get_ports {SPI_MOSI}]
set_load -pin_load 1.43429 [get_ports {SPI_SCK}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[3]}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[2]}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[1]}]
set_load -pin_load 1.43429 [get_ports {SPI_CS_n[0]}]
set_load -pin_load 1.43429 [get_ports {I2C_SDA}]
set_load -pin_load 1.43429 [get_ports {I2C_SCL}]
# /tmp/icc2_shell-2.UBkNbx, line 45
set_operating_conditions -library saed32hvt_ff1p16v25c.db:saed32hvt_ff1p16v25c \
    -analysis_type on_chip_variation ff1p16v25c
# Warning: Libcell power domain derates are skipped!

# Set latency for io paths.
# -origin useful_skew
set_clock_latency -min 0.0610132 [get_clocks {HCLK}]
# -origin useful_skew
set_clock_latency -max 0.0648711 [get_clocks {HCLK}]
# Set propagated on clock sources to avoid removing latency for IO paths.
set_propagated_clock  [get_ports {HCLK}]
# /tmp/icc2_shell-2.Eyjpft, line 68
set_driving_cell -lib_cell NBUFFX16_RVT [get_ports {HCLK}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 12
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HRESETn}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 14
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[31]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 16
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[30]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 18
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[29]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 20
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[28]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 22
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[27]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 24
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[26]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 26
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[25]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 28
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[24]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 30
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[23]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 32
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[22]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 34
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[21]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 36
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[20]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 38
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[19]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 40
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[18]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 42
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[17]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 44
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[16]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 46
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[15]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 48
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[14]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 50
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[13]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 52
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[12]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 54
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[11]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 56
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[10]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 58
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[9]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 60
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[8]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 62
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[7]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 64
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[6]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 66
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[5]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 68
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[4]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 70
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 72
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 74
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 76
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HADDR[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 78
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[31]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 80
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[30]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 82
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[29]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 84
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[28]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 86
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[27]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 88
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[26]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 90
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[25]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 92
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[24]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 94
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[23]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 96
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[22]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 98
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[21]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 100
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[20]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 102
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[19]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 104
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[18]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 106
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[17]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 108
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[16]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 110
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[15]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 112
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[14]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 114
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[13]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 116
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[12]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 118
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[11]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 120
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[10]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 122
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[9]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 124
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[8]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 126
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[7]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 128
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[6]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 130
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[5]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 132
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[4]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 134
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 136
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 138
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 140
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWDATA[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 142
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWSTRB[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 144
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWSTRB[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 146
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWSTRB[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 148
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWSTRB[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 150
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HWRITE}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 152
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HTRANS[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 154
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {HTRANS[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 156
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {UART_Rx}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 158
set_driving_cell -lib_cell NAND2X1_RVT -pin Y -no_design_rule -max -library \
    saed32rvt_ss0p95v125c [get_ports {SPI_MISO}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 277
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[31]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 278
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[30]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 279
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[29]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 280
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[28]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 281
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[27]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 282
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[26]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 283
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[25]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 284
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[24]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 285
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[23]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 286
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[22]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 287
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[21]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 288
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[20]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 289
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[19]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 290
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[18]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 291
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[17]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 292
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[16]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 293
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[15]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 294
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[14]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 295
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[13]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 296
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[12]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 297
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[11]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 298
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[10]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 299
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[9]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 300
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[8]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 301
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[7]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 302
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[6]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 303
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[5]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 304
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[4]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 305
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 306
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 307
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 308
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HADDR[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 309
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[31]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 310
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[30]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 311
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[29]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 312
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[28]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 313
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[27]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 314
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[26]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 315
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[25]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 316
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[24]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 317
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[23]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 318
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[22]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 319
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[21]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 320
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[20]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 321
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[19]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 322
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[18]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 323
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[17]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 324
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[16]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 325
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[15]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 326
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[14]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 327
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[13]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 328
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[12]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 329
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[11]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 330
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[10]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 331
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[9]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 332
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[8]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 333
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[7]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 334
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[6]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 335
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[5]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 336
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[4]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 337
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 338
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 339
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 340
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWDATA[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 341
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWSTRB[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 342
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWSTRB[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 343
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWSTRB[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 344
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWSTRB[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 345
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HWRITE}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 346
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HTRANS[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 347
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {HTRANS[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 354
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[31]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 355
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[30]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 356
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[29]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 357
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[28]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 358
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[27]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 359
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[26]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 360
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[25]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 361
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[24]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 362
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[23]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 363
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[22]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 364
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[21]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 365
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[20]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 366
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[19]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 367
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[18]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 368
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[17]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 369
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[16]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 370
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[15]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 371
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[14]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 372
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[13]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 373
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[12]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 374
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[11]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 375
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[10]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 376
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[9]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 377
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[8]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 378
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[7]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 379
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[6]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 380
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[5]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 381
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[4]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 382
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 383
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 384
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 385
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HRDATA[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 386
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {HREADY}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 348
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {UART_Rx}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 387
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {UART_Tx}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 388
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_MOSI}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 349
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_MISO}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 389
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_SCK}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 390
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_CS_n[3]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 391
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_CS_n[2]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 392
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_CS_n[1]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 393
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {SPI_CS_n[0]}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 350
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {I2C_SDA}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 352
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {I2C_SDA}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 351
set_input_delay -clock [get_clocks {HCLK}] 6 [get_ports {I2C_SCL}]
# /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc, \
#   line 353
set_output_delay -clock [get_clocks {HCLK}] 6 [get_ports {I2C_SCL}]
set_max_capacitance 1.43429 [get_ports {HRESETn}]
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
set_max_capacitance 1.43429 [get_ports {HWRITE}]
set_max_capacitance 1.43429 [get_ports {HTRANS[1]}]
set_max_capacitance 1.43429 [get_ports {HTRANS[0]}]
set_max_capacitance 1.43429 [get_ports {UART_Rx}]
set_max_capacitance 1.43429 [get_ports {SPI_MISO}]
