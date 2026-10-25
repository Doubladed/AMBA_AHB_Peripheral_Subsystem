remove_design -all

source setup.tcl

# Remove SRAM1RW256x32.v from RTL folder since it is a macro and we do not want to accidentally synthesize it
analyze -format verilog [glob $rtl_dir/*.v]

elaborate ahb_peripheral_top

current_design ahb_peripheral_top
link
check_design > $dc_dir/reports/check_design.rpt

source cons.tcl

set_fix_multiple_port_nets -all -buffer_constants

set_cost_priority max_capacitance

compile_ultra

set verilogout_no_tri true
change_names -rules verilog -hierarchy

# Report
set rpt_dir "$dc_dir/reports"

report_constraint -all > $rpt_dir/report_constraint.rpt

report_timing > $rpt_dir/report_timing.rpt

report_qor > $rpt_dir/report_qor.rpt

report_area > $rpt_dir/report_area.rpt

report_clock > $rpt_dir/report_clock.rpt

# Output
set out_dir "$dc_dir/outputs"

set write_sdc_output_lumped_net_capacitance false
set write_sdc_output_net_resistance false

write -f ddc -hierarchy -output $out_dir/syn_ahb_peripheral_top.ddc

write -f verilog -hierarchy -output $out_dir/syn_ahb_peripheral_top.v

write_sdc $out_dir/syn_ahb_peripheral_top.sdc

# Incremental
set compile_final_drc_fix capacitance

compile_ultra -incremental -only_design_rule

# Incremental Report
set rpt_dir "$dc_dir/reports"

report_constraint -all > $rpt_dir/incremental_rpt/report_constraint.rpt

report_timing > $rpt_dir/incremental_rpt/report_timing.rpt

report_qor > $rpt_dir/incremental_rpt/report_qor.rpt

report_area > $rpt_dir/incremental_rpt/report_area.rpt

report_clock > $rpt_dir/incremental_rpt/report_clock.rpt

# Incremental Output
set out_dir "$dc_dir/outputs"

set write_sdc_output_lumped_net_capacitance false
set write_sdc_output_net_resistance false

write -f ddc -hierarchy -output $out_dir/incremental_out/syn_ahb_peripheral_top.ddc

write -f verilog -hierarchy -output $out_dir/incremental_out/syn_ahb_peripheral_top.v

write_sdc $out_dir/incremental_out/syn_ahb_peripheral_top.sdc


