###################################
# Slow Scenario -> Setup Analysis #
###################################

source setup.tcl

set link_path "* $slow_lib"

set slow_icc2_dir "$icc2_write_dir/slow"

set slow_pt_out "$pt_out_dir/slow"

set slow_pt_rpt "$pt_rpt_dir/slow"

# Load Design
current_design ahb_peripheral_top
current_design
link_design

# Load Parasitics and Check Parasitics Annotation

# Slow Corner -> MaxTLU
read_parasitics "$slow_icc2_dir/pd_ahb_peripheral_top_ss0p95v125.spef.maxTLU_125.spef"

report_annotated_parasitics > "$slow_pt_rpt/max_spef.rpt"
report_annotated_parasitics -list_not_annotated >> "$slow_pt_rpt/max_spef.rpt"

# Source Constraints and Check for Correctness
read_sdc "$slow_icc2_dir/pd_ahb_peripheral_top_ss.sdc"

# Are constraints complete?
check_timing -verbose > "$slow_pt_rpt/ss_sdc.rpt"
# Examine clock and port constraints
report_clock -skew -attribute >> "$slow_pt_rpt/ss_sdc.rpt"
report_port -verbose >> "$slow_pt_rpt/ss_sdc.rpt"
# Examine design constraints & exceptions
report_design >> "$slow_pt_rpt/ss_sdc.rpt"
report_exceptions -ignored >> "$slow_pt_rpt/ss_sdc.rpt"
report_case_analysis >> "$slow_pt_rpt/ss_sdc.rpt"

# Spef with location information
set read_parasitics_load_locations true

# Update timing with pin and slack arrival info
set timing_save_pin_arrival_and_slack true
update_timing -full

###########
# Reports #
###########

report_global_timing -pba_mode exhaustive > "$slow_pt_rpt/global_timing.rpt"
report_qor -pba_mode exhaustive > "$slow_pt_rpt/qor.rpt"
report_constraints -all_violators -pba_mode exhaustive > "$slow_pt_rpt/cons_all_violators.rpt"
report_analysis_coverage > "$slow_pt_rpt/analysis_coverage.rpt"
report_analysis_coverage -untested_summary > "$slow_pt_rpt/untested_summary.rpt"
report_global_slack > "$slow_pt_rpt/global_slack.rpt"
