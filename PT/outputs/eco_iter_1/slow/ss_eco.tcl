###############################################################################
# Change list, formatted for IC Compiler
#
# 
#
###############################################################################
current_instance
size_cell {ropt_mc_inst_3014} {NBUFFX8_HVT}
insert_buffer [get_pins {AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM0/O[28]}] NBUFFX4_LVT -new_net_names {net_PTECO_DRC_NET1} -new_cell_names {U_PTECO_DRC_BUF1}
insert_buffer [get_ports {HADDR[9]}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET2} -new_cell_names {U_PTECO_DRC_BUF2}
insert_buffer [get_ports {HADDR[28]}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET3} -new_cell_names {U_PTECO_DRC_BUF3}
insert_buffer [get_ports {HADDR[7]}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET4} -new_cell_names {U_PTECO_DRC_BUF4}
insert_buffer [get_ports {HADDR[10]}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET5} -new_cell_names {U_PTECO_DRC_BUF5}
insert_buffer [get_pins {ropt_mc_inst_3017/Y}] NBUFFX8_HVT -new_net_names {net_PTECO_DRC_NET6} -new_cell_names {U_PTECO_DRC_BUF6}
insert_buffer [get_ports {HADDR[19]}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET7} -new_cell_names {U_PTECO_DRC_BUF7}
insert_buffer [get_pins {AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM0/O[26]}] NBUFFX4_LVT -new_net_names {net_PTECO_DRC_NET8} -new_cell_names {U_PTECO_DRC_BUF8}
size_cell {U4788} {INVX2_LVT}
insert_buffer [get_pins {AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_5_/Q}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET9} -new_cell_names {U_PTECO_DRC_BUF9}
insert_buffer [get_pins {AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE_reg_1_/Q}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET10} -new_cell_names {U_PTECO_DRC_BUF10}
insert_buffer [get_ports {HWDATA[26]}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET11} -new_cell_names {U_PTECO_DRC_BUF11}
insert_buffer [get_pins {AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_2_/Q}] NBUFFX2_HVT -new_net_names {net_PTECO_DRC_NET12} -new_cell_names {U_PTECO_DRC_BUF12}
insert_buffer [get_pins {ZBUF_2_inst_2850/Y}] NBUFFX8_HVT -new_net_names {net_PTECO_DRC_NET13} -new_cell_names {U_PTECO_DRC_BUF13}
