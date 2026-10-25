# 1. Clock

# Clock = 100 MHz = 10 ns
create_clock -period 10 [get_ports HCLK]

# Assume clock uncertainty 10% of clock period: 10ns x 10% = 1ns
set_clock_uncertainty -setup 1 [get_clocks HCLK]

# 2. Time Budgeting

# Create a 60% time budget for input and output delay
# Don't add input delay to HCLK and HRESETn since the delay is referenced from the clock and the reset is asynchronous
# Budgetting allowed: 50 - 60% of clock period
set_input_delay 6 -clock HCLK [get_ports { \
					HADDR[*] \
					HWDATA[*] \
					HWSTRB[*] \
					HWRITE \
					HTRANS[*] \
					UART_Rx \
					SPI_MISO \
					I2C_SDA \
					I2C_SCL \
					}]

set_output_delay 6 -clock HCLK [get_ports { \
					HRDATA[*] \
					HREADY \
					UART_Tx \
					SPI_MOSI \
					SPI_SCK \
					SPI_CS_n[*] \
					I2C_SDA \
					I2C_SCL \
					}]

# Do not include -max or else it will affect ICC2 and PrimeTime for -min checks  

# 3. Load Budgeting

# Assume weak cell driving the inputs
# Remove I2C_SDA and I2C_SCL since it is INOUT
set_driving_cell -max -no_design_rule -library saed32rvt_ss0p95v125c -lib_cell NAND2X1_RVT -pin Y [get_ports { \
													HRESETn \
													HADDR[*] \
													HWDATA[*] \
													HWSTRB[*] \
													HWRITE \
													HTRANS[*] \
													UART_Rx \
													SPI_MISO \
													}]

# Limit input capacitance
# Remove I2C_SDA and I2C_SCL since it is INOUT
set MAX_INPUT_LOAD [expr [load_of saed32rvt_ss0p95v125c/NAND2X1_RVT/A1] * 3]

set_max_capacitance $MAX_INPUT_LOAD [get_ports { \
					HRESETn \
					HADDR[*] \
					HWDATA[*] \
					HWSTRB[*] \
					HWRITE \
					HTRANS[*] \
					UART_Rx \
					SPI_MISO \
					}]

# Estimate the number of major blocks driven at the output
# Include I2C_SDA and I2C_SCL since both need to have some load constrained at the output
set OUTPUT_LOAD [expr $MAX_INPUT_LOAD * 1]

set_load $OUTPUT_LOAD [get_ports { \
				HRDATA[*] \
				HREADY \
				UART_Tx \
				SPI_MOSI \
				SPI_SCK \
				SPI_CS_n[*] \
				I2C_SDA \
				I2C_SCL \
				}]

# 4. Don't Use and Disable

set_dont_use [get_lib_cells {*/OR2X*_HVT */OR2X*_RVT */NOR2X*_HVT */NOR2X*_RVT}]

set_dont_use [get_lib_cells */ISO*]
set_dont_use [get_lib_cells */RSDFFARX*]
set_dont_use [get_lib_cells */*LS*]
set_dont_use [get_lib_cells */*AO*]
set_dont_use [get_lib_cells */*ADD*]

# set_dont_use  {saed32hvt_ss0p75v125c/NOR2X*_HVT saed32hvt_ss0p75v125c/OR2X4_HVT saed32hvt_ss0p75v125c/OR2X1_HVT}
# set_dont_use  {saed32rvt_ss0p75v125c/NOR2X*_RVT saed32rvt_ss0p75v125c/OR2X4_RVT saed32rvt_ss0p75v125c/OR2X1_RVT}
# set_dont_use  {saed32lvt_ss0p75v125c/NOR2X*_LVT saed32lvt_ss0p75v125c/OR2X4_LVT saed32lvt_ss0p75v125c/OR2X1_LVT}

set_dont_use [get_lib_cells {*/NOR2X*_HVT */OR2X4_HVT */OR2X1_HVT}]
set_dont_use [get_lib_cells {*/NOR2X*_RVT */OR2X4_RVT */OR2X1_RVT}]
set_dont_use [get_lib_cells {*/NOR2X*_LVT */OR2X4_LVT */OR2X1_LVT}]

set_register_merging [current_design] false
set_app_var compile_seqmap_propagate_constants false

# 5. Operating Conditions

set_operating_conditions -max ss0p95v125c

# 6. Max Area

set_max_area 0
