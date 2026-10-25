##################################
# Fast Scenario -> Hold Analysis #
##################################

source setup.tcl

set link_path "* $fast_lib"

set fast_icc2_dir "$icc2_write_dir/fast"

set fast_pt_out "$pt_out_dir/fast"

set fast_pt_rpt "$pt_rpt_dir/fast"

# Load Design
current_design ahb_peripheral_top
current_design
link_design

# Load Parasitics and Check Parasitics Annotation

# Fast Corner -> MinTLU
read_parasitics "$fast_icc2_dir/pd_ahb_peripheral_top_ff1p16v25.spef.minTLU_25.spef"
report_annotated_parasitics > "$fast_pt_rpt/min_spef.rpt"
report_annotated_parasitics -list_not_annotated >> "$fast_pt_rpt/min_spef.rpt"

# sed MUMBO JUMBO magic trick because SDC for ff_scenario uses ss0p95v125c
# This is because we use the same SDC file from DC for both ss_scenario and ff_scenario
exec sed "s/saed32rvt_ss0p95v125c/saed32rvt_ff1p16v25c/g" \
    "$fast_icc2_dir/pd_ahb_peripheral_top_ff.sdc" \
    > "$fast_pt_out/pd_ahb_peripheral_top_ff_pt.sdc"

# Read the new modified SDC file
# Source Constraints and Check for Correctness
read_sdc "$fast_pt_out/pd_ahb_peripheral_top_ff_pt.sdc"
# Are constraints complete?
check_timing -verbose > "$fast_pt_rpt/ff_sdc.rpt"
# Examine clock and port constraints
report_clock -skew -attribute >> "$fast_pt_rpt/ff_sdc.rpt"
report_port -verbose >> "$fast_pt_rpt/ff_sdc.rpt"
# Examine design constraints & exceptions
report_design >> "$fast_pt_rpt/ff_sdc.rpt"
report_exceptions -ignored >> "$fast_pt_rpt/ff_sdc.rpt"
report_case_analysis >> "$fast_pt_rpt/ff_sdc.rpt"

# Spef with location information
set read_parasitics_load_locations true

# Update timing with pin and slack arrival info
set timing_save_pin_arrival_and_slack true
update_timing -full

###########
# Reports #
###########

report_global_timing -pba_mode exhaustive > "$fast_pt_rpt/global_timing.rpt"
report_qor -pba_mode exhaustive > "$fast_pt_rpt/qor.rpt"
report_constraints -all_violators -pba_mode exhaustive > "$fast_pt_rpt/cons_all_violators.rpt"
report_analysis_coverage > "$fast_pt_rpt/analysis_coverage.rpt"
report_analysis_coverage -untested_summary > "$fast_pt_rpt/untested_summary.rpt"
report_global_slack > "$fast_pt_rpt/global_slack.rpt"
