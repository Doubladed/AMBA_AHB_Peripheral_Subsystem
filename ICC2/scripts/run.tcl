# === FINAL VERSION === #

# Set Max Cores

set np [exec grep processor /proc/cpuinfo | wc -l]
if {$np > 4} { set np 4 }
set_host_options -max_cores $np
echo $np

############
# 1. SETUP #
############

# Root Dir

set icc2_dir "/home/user/Documents/Project/ICC2"

set lib_dir "/home/user/Documents/Project/libs_saed32nm_with_sram_20July2026/libs"

set tech_dir "$lib_dir/tech"

set ndm_dir "$lib_dir/ndm"

set design_lib "$icc2_dir/MYLIB"

# Search Path

set search_path ". $icc2_dir $icc2_dir/scripts $tech_dir $ndm_dir"

echo "\n--- Search Path Verification ---"
printvar search_path

# Technology File

set TECH_FILE "$tech_dir/saed32nm_1p9m.tf"

# NDM Design Libraries

set REFERENCE_LIBRARY [join "
	$ndm_dir/saed32hvt_base_frame_timing.ndm
	$ndm_dir/saed32lvt_base_frame_timing.ndm
	$ndm_dir/saed32rvt_base_frame_timing.ndm
	$ndm_dir/SRAM1RW256x32.ndm
	$ndm_dir/SRAM1RW1024x8.ndm
	"]

# Create Design Library

create_lib \
	-technology $TECH_FILE \
	-ref_libs $REFERENCE_LIBRARY \
	$design_lib

echo "\n--- Design Library Verification ---"
current_lib

echo "\n--- Tech File Verification ---"
get_layers

echo "\n--- Reference Library Verification ---"
report_ref_libs

# Parasitic Technology Files

set MAP_FILE "$tech_dir/saed32nm_1p9m_layer.map"

set TLUPLUS_MAX_FILE "$tech_dir/saed32nm_1p9m_Cmax.tluplus"

set TLUPLUS_MIN_FILE "$tech_dir/saed32nm_1p9m_Cmin.tluplus"

read_parasitic_tech \
	-layermap $MAP_FILE \
	-tlup $TLUPLUS_MAX_FILE \
	-name maxTLU

read_parasitic_tech \
	-layermap $MAP_FILE \
	-tlup $TLUPLUS_MIN_FILE \
	-name minTLU

echo "\n--- Parasitic Technology Files Verification ---"
report_lib -parasitic_tech [current_lib]

# Save Design Library

echo "\n--- Saving Design Library ---"
save_lib
echo "\n--- ICC2 Library Setup Completed Successfully ---"

####################
# 2. PRE-FLOORPLAN #
####################

# Read synthesized gate-level netlist
read_verilog /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.v

# MCMM Configuration

create_mode slow_mode
create_mode fast_mode

create_corner ss0p95v125
create_corner ff1p16v25

# Configure Slow Scenario

create_scenario \
	-name ss_scenario \
	-mode slow_mode \
	-corner ss0p95v125

current_mode slow_mode
read_sdc /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc

current_corner ss0p95v125
set_operating_conditions -max ss0p95v125c -min ss0p95v125c

set_parasitic_parameters \
	-corner ss0p95v125 \
	-early_spec maxTLU \
	-late_spec maxTLU

# Configure Fast Scenario

create_scenario \
	-name ff_scenario \
	-mode fast_mode \
	-corner ff1p16v25

current_mode fast_mode
read_sdc /home/user/Documents/Project/DC/outputs/incremental_out/syn_ahb_peripheral_top.sdc

current_corner ff1p16v25
set_operating_conditions -max ff1p16v25c -min ff1p16v25c

set_parasitic_parameters \
	-corner ff1p16v25 \
	-early_spec minTLU \
	-late_spec minTLU

set_scenario_status ss_scenario \
	-active true \
	-setup true \
	-hold false

set_scenario_status ff_scenario \
	-active true \
	-setup false \
	-hold true

# MCMM Report
report_scenarios > $icc2_dir/reports/Pre_Floorplan/mcmm_scenarios.rpt

# ZIC Analysis
set_app_options -name time.delay_calculation_style -value zero_interconnect
report_qor -summary > $icc2_dir/reports/Pre_Floorplan/zic_delay.rpt

set_app_options -name time.delay_calculation_style -value auto
report_qor -summary > $icc2_dir/reports/Pre_Floorplan/auto_delay.rpt

# Site Definitions

get_site_defs

set_attribute [get_site_defs unit] symmetry Y
set_attribute [get_site_defs unit] is_default true

set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}] routing_direction vertical

report_ignored_layers
set_ignored_layers -max_routing_layer M9
report_ignored_layers > $icc2_dir/reports/Pre_Floorplan/ignored_layers.rpt

# Don't Use (Broken/Problematic Cells)

set_attribute [get_lib_cells {*/OR2X*_HVT */OR2X*_RVT */NOR2X*_HVT */NOR2X*_RVT}] dont_use true

set_attribute [get_lib_cells */ISO*] dont_use true
set_attribute [get_lib_cells */RSDFFARX*] dont_use true
set_attribute [get_lib_cells */*LS*] dont_use true
set_attribute [get_lib_cells */*AO*] dont_use true
set_attribute [get_lib_cells */*ADD*] dont_use true

set_attribute [get_lib_cells {*/NOR2X*_HVT */OR2X4_HVT */OR2X1_HVT}] dont_use true
set_attribute [get_lib_cells {*/NOR2X*_RVT */OR2X4_RVT */OR2X1_RVT}] dont_use true
set_attribute [get_lib_cells {*/NOR2X*_LVT */OR2X4_LVT */OR2X1_LVT}] dont_use true

# Connect Power-Ground Nets
connect_pg_net -automatic

# Save block as pre_FP
save_block -as pre_FP

################
# 3. FLOORPLAN #
################

initialize_floorplan -side_length {1125 510} -core_offset {8}

create_keepout_margin \
    -type hard \
    -outer {5 5 5 5} \
    [get_cells -hierarchical -filter "is_hard_macro==true"]

# Arrange, Rotate, Flip, and Fix Macros
set_attribute [get_cells -hierarchical -filter "is_hard_macro==true"] orientation R90

set_fixed_objects [get_flat_cells -filter "is_hard_macro==true"]

set_app_options -name place.coarse.fix_hard_macros -value false
# set_app_options -name plan.place.auto_create_blockages -value auto

set_app_options -name plan.place.auto_create_blockages -value none
report_app_options plan.place.auto_create_blockages

create_placement -floorplan -timing_driven

set_app_options -list {place.coarse.pin_density_aware {true}}

set_block_pin_constraints \
	-self -pin_spacing_distance 3 \
	-allowed_layers {M2 M3 M4 M5 M6} \
	-sides {2 4}

place_pins -self

# Check Ports
# get_object_name [get_terminals *]

# To remove all Ports
# remove_terminals [get_terminals -filter "name !~ VDD_* && name !~ VSS_*"]

connect_pg_net
legalize_placement

# Save block as post_FP
save_block -as post_FP

#####################
# 4. POWER PLANNING #
#####################

# PG Core Ring

create_pg_ring_pattern ring_pattern \
	-nets {VDD VSS} \
	-horizontal_layer M7 \
	-vertical_layer M8 \
	-horizontal_width {2.5} \
	-vertical_width {2.5} \
	-horizontal_spacing {1} \
	-vertical_spacing {1}

set_pg_strategy ring_core -core \
	-pattern {{name: ring_pattern} {nets: {VDD VSS }}{offset : {1 1}}} \
	-extension {{{stop : design_boundary_and_generate_pin}}}

compile_pg -strategies ring_core

# Remove all rings if required
remove_routes -net_types {power ground} -ring
remove_pg_strategies ring_core
remove_pg_patterns ring_pattern

# PG Vertical Stripe Mesh

# Add two stripes at offset 517 and 605

create_pg_mesh_pattern pg_vertical_mesh \
	-layers {
		{{vertical_layer : M8} {width : 2.5} {spacing : minimum} {offset : 517} {trim : true}}
	}

set_pg_strategy mesh_vertical -core \
	-pattern {{name : pg_vertical_mesh}{nets : {VDD VSS}}} \
	-blockage {{{macros_with_keepout : [get_cells -hierarchical -filter "is_hard_macro==true"]}}} \
	-extension {{{stop : outermost_ring}}}

compile_pg -strategies mesh_vertical

# Remove all stripes if required
remove_routes -net_types {power ground} -stripe
remove_pg_strategies mesh_vertical
remove_pg_patterns pg_vertical_mesh

# PG Macro Rings

create_pg_ring_pattern macro_ring \
	-nets {VDD VSS} \
	-horizontal_layer M7 \
	-vertical_layer M6 \
	-horizontal_width {1} \
	-vertical_width {1} \
	-horizontal_spacing {1} \
	-vertical_spacing {1}

# Left Macros: 0 1 2 3 8 9 10 11
# Horizontal extensions use M7 toward the left core-ring side

set_pg_strategy macro_l -macros {
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM0
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM1
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM2
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM3
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM8
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM9
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM10
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM11
	} \
	-pattern {{name : macro_ring}{nets : {VDD VSS}}{offset : {1 1}}} \
	-extension {{{direction : L}{stop : outermost_ring}}}

compile_pg -strategies macro_l

# Right Macros: 4 5 6 7 12 13 14 15
# Horizontal extensions use M7 toward the right core-ring side

set_pg_strategy macro_r -macros {
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM4
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM5
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM6
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM7
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM12
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM13
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM14
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM15
	} \
	-pattern {{name : macro_ring}{nets : {VDD VSS}}{offset : {1 1}}} \
	-extension {{{direction : R}{stop : outermost_ring}}}

compile_pg -strategies macro_r

# Connect SRAM VDD/VSS pins physically to their macro rings

create_pg_macro_conn_pattern HM_pin_pattern \
	-pin_conn_type scattered_pin \
	-layers {M5 M6}

set_pg_strategy macro -macros {
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM0
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM1
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM2
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM3
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM4
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM5
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM6
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM7
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM8
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM9
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM10
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM11
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM12
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM13
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM14
	AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM15
	} \
	-pattern {{name : HM_pin_pattern}{nets : {VDD VSS}}}

compile_pg -strategies macro

# Add Routing Blockages on Macros at M1 layer

# Standard Cells Rails

create_pg_std_cell_conn_pattern std_pattern \
	-check_std_cell_drc false \
	-mark_as_follow_pin false

set_pg_strategy std_cell -core \
	-pattern {{name : std_pattern}{nets : {VDD VSS}}} \
	-blockage {{{nets : {VDD VSS}}{macros_with_keepout : [get_cells -hierarchical -filter "is_hard_macro==true"]}}} \
	-extension {{{nets : {VDD VSS}}{stop : outermost_ring}}}

compile_pg -strategies std_cell

# PG Vias
create_pg_vias -nets {VDD VSS} -from_layers M1 -to_layers M8 -drc no_check

# Remove Routing Blockages on Macros at M1 layer
remove_routing_blockages [get_routing_blockages]

# Add Routing Blockages on Macros and Placement Blockages on Mesh

# Create routing blockages over all hard macros on M6-M9

foreach_in_collection macro \
	[get_cells -hierarchical -filter "is_hard_macro==true"] {

	set macro_boundary [get_attribute $macro boundary]

	create_routing_blockage \
		-layers {M6 M7 M8 M9} \
		-boundary $macro_boundary
}

# Create soft placement blockages for right and left mesh

# Create Pin Blockages for the Ports at the Top and Bottom sides
# Delete and Replace Ports so that it is concentrated in the middle

# Remove Pin Blockages when done for ease of viewing
# remove_pin_blockages [get_pin_blockages]

# Rerun Placements

create_placement -floorplan -timing_driven
legalize_placement

# Check PG
check_pg_connectivity > $icc2_dir/reports/Floorplan/check_pg_connectivity.rpt
check_pg_drc > $icc2_dir/reports/Floorplan/check_pg_drc.rpt
check_pg_missing_vias > $icc2_dir/reports/Floorplan/check_pg_missing_vias.rpt

# Power Network Analysis

# Acceptable IR Drop threshold is 10% of Supplied Voltage

# Slow Scenario (ss0p95v125)
# Supply with 0.95v = 950mv

current_scenario ss_scenario
analyze_power_plan -nets [get_nets -design [current_block] {VSS VDD}] -analyze_power -voltage 0.95 -use_terminals_as_pads

# Fast Scenario (ff1p16v25)
# Supply with 1.16v = 1160mv

# Enable Setup for PNA on Fast Scenario

set_scenario_status ff_scenario \
	-active true \
	-setup true \
	-hold true

current_scenario ff_scenario
analyze_power_plan -nets [get_nets -design [current_block] {VSS VDD}] -analyze_power -voltage 1.16 -use_terminals_as_pads

# Disable Setup once PNA is over

set_scenario_status ff_scenario \
	-active true \
	-setup false \
	-hold true

# Check if Scenario is correctly reconfigured
report_scenario

# Write floorplan
write_floorplan -force -output AHB_PERIPHERAL_TOP.fp

# Save block as post_PNS
save_block -as post_PNS

################
# 5. PLACEMENT #
################

check_design -checks pre_placement_stage > $icc2_dir/reports/Placement/pre_placement_stage.rpt
check_design -checks physical_constraints > $icc2_dir/reports/Placement/physical_constraints.rpt

report_net_fanout -high_fanout > $icc2_dir/reports/Placement/net_fanout.rpt
report_qor -summary > $icc2_dir/reports/Placement/qor_pre_place_opt.rpt
report_threshold_voltage_groups > $icc2_dir/reports/Placement/threshold_voltage_pre_place_opt.rpt

set_app_options -name place.coarse.continue_on_missing_scandef -value true
set_app_options -name place.coarse.enhanced_auto_density_control -value true
set_app_options -name place.legalize.enable_advanced_legalizer -value true

place_opt

report_qor -summary > $icc2_dir/reports/Placement/qor_post_place_opt.rpt
report_timing > $icc2_dir/reports/Placement/report_timing.rpt
report_congestion > $icc2_dir/reports/Placement/report_congestion.rpt
report_threshold_voltage_groups > $icc2_dir/reports/Placement/threshold_voltage_post_place_opt.rpt

# Open Global Route Congestion via GUI

# Save block as place_complete
save_block -as place_complete

#########################
# 6. CLOCK TREE SETTING #
#########################

# Investigate IMPLICIT IGNORE Pins
report_clock_qor -type structure > $icc2_dir/reports/Clock_Tree_Synthesis/investigate_pins.rpt

# From the report, there are no IMPLICIT IGNORE Pins

# Logical Equivalent Cells (LEQ) {I don't know why we even do this...}
derive_clock_cell_references -output cts_leq_set.tcl

# Set Buffer and Inverter for Clock Tree

# There are no Clock-Gating Cells in our Gate-Level Netlist 
set CTS_CELLS [get_lib_cells "*/NBUFF*VT */INVX*"]

set_dont_touch $CTS_CELLS false
set_lib_cell_purpose -exclude cts [get_lib_cells]
set_lib_cell_purpose -include cts $CTS_CELLS

report_lib_cells -objects [get_lib_cells] \
-columns {name:20 valid_purposes dont_touch} \
> report_lib_cells.tcl

# Non-Default Rule (NDR)

report_routing_rules -verbose > $icc2_dir/reports/Clock_Tree_Synthesis/pre_ndr_routing_rules.rpt
report_clock_routing_rules > $icc2_dir/reports/Clock_Tree_Synthesis/pre_ndr_clock_routing_rules.rpt

source scripts/ndr.tcl

report_routing_rules -verbose > $icc2_dir/reports/Clock_Tree_Synthesis/post_ndr_routing_rules.rpt
report_clock_routing_rules > $icc2_dir/reports/Clock_Tree_Synthesis/post_ndr_clock_routing_rules.rpt

#  Timing and DRC Constraints

# Set Clock Driving Cells
report_ports -verbose [get_ports HCLK] > $icc2_dir/reports/Clock_Tree_Synthesis/pre_cons_ports.rpt

set_driving_cell -scenarios [all_scenarios] -lib_cell NBUFFX16_RVT [get_ports HCLK]

report_ports -verbose [get_ports HCLK] > $icc2_dir/reports/Clock_Tree_Synthesis/post_cons_ports.rpt

# Remove Clock Uncertainty
report_clocks -skew -modes [all_modes] > $icc2_dir/reports/Clock_Tree_Synthesis/pre_remove_uncertainty_skew.rpt

remove_clock_uncertainty [all_clocks] -scenarios [all_scenarios]

report_clocks -skew -modes [all_modes] > $icc2_dir/reports/Clock_Tree_Synthesis/post_remove_uncertainty_skew.rpt

# Remove Clock Reconvergence Pessimism
set_app_options -name time.remove_clock_reconvergence_pessimism -value true

report_clock_settings > $icc2_dir/reports/Clock_Tree_Synthesis/clock_settings.rpt

# Save block as cts_setting
save_block -as cts_setting
 
###########################
# 7. CLOCK TREE SYNTHESIS #
###########################

report_qor -summary > $icc2_dir/reports/Clock_Tree_Synthesis/report_qor.rpt

check_design -checks pre_clock_tree_stage > $icc2_dir/reports/Clock_Tree_Synthesis/pre_clock_tree_stage.rpt

check_clock_trees -clocks [get_clocks HCLK] > $icc2_dir/reports/Clock_Tree_Synthesis/check_clock_trees.rpt

# Run CCD Clock_Opt
set_app_options -name clock_opt.flow.enable_ccd -value true
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.optimize.enable_local_skew -value true

set_clock_tree_options -target_skew 0.02 -corners [get_corners [all_corners]]

clock_opt

report_clock_qor > $icc2_dir/reports/Clock_Tree_Synthesis/Clock_Opt/report_clock_qor.rpt
report_qor -summary > $icc2_dir/reports/Clock_Tree_Synthesis/Clock_Opt/report_qor.rpt

# Save block as clock_optimization
save_block -as clock_optimization

##############
# 8. ROUTING #
##############

# Make sure to remove Routing Blockages on M1 layer before Routing 

report_qor -summary > $icc2_dir/reports/Routing/report_qor.rpt

#checking design for routing
set_app_options -name route.common.verbose_level -value 1
check_design -check pre_route_stage > $icc2_dir/reports/Routing/pre_route_stage.rpt
set_app_options -name route.common.verbose_level -value 0

# Antenna Rules
source -echo $tech_dir/saed32nm_ant_1p9m.tcl
report_app_options route.detail.*antenna*

#set applications: timing_driven
set_app_options -name route.global.timing_driven -value true
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.detail.timing_driven -value true

#set applications: crosstalk prevention
set_app_options -name time.si_enable_analysis -value true
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.crosstalk_driven -value true

route_auto
route_opt 

# Physical DRCs

check_lvs > $icc2_dir/reports/Routing/check_lvs.rpt
check_routes > $icc2_dir/reports/Routing/check_routes.rpt

# Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > $icc2_dir/reports/Routing/ff_constraints.rpt

current_scenario ss_scenario
report_constraints -all_violators > $icc2_dir/reports/Routing/ss_constraints.rpt

report_qor -summary > $icc2_dir/reports/Routing/post_route_report_qor_summary.rpt
report_qor > $icc2_dir/reports/Routing/post_route_report_qor.rpt

# Save block as route_complete
save_block -as route_complete

#######################
# 9. Export to PT (1) #
#######################

# Set for both PT and ECO Fixing
set iter_num "1"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (1) #
########################

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Apply PT Physical ECO Guidance - ss_eco.tcl
source "$pt_eco_dir/slow/ss_eco.tcl"

# Legalize ECO Cells
place_eco_cells -legalize_only -eco_changed_cells \
    -legalize_mode minimum_physical_impact \
    -displacement_threshold 10

# Set Up Non-Timing-Driven ECO Routing
set_app_options -list {
    route.global.crosstalk_driven false
    route.track.crosstalk_driven false
    route.global.timing_driven false
    route.track.timing_driven false
    route.detail.timing_driven false
}

# Perform ECO Routing
route_eco -reroute modified_nets_first_then_others

# Post-ECO optimization
route_opt

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (2) #
#######################

# Set for both PT and ECO Fixing
set iter_num "2"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (2) #
########################

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Apply PT Physical ECO Guidance - ss_eco.tcl
source "$pt_eco_dir/slow/ss_eco.tcl"

# Legalize ECO Cells
place_eco_cells -legalize_only -eco_changed_cells \
    -legalize_mode minimum_physical_impact \
    -displacement_threshold 10

# Set Up Non-Timing-Driven ECO Routing
set_app_options -list {
    route.global.crosstalk_driven false
    route.track.crosstalk_driven false
    route.global.timing_driven false
    route.track.timing_driven false
    route.detail.timing_driven false
}

# Perform ECO Routing
route_eco -reroute modified_nets_first_then_others

# Post-ECO optimization
route_opt

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (3) #
#######################

# Set for both PT and ECO Fixing
set iter_num "3"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (3) #
########################

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Apply PT Physical ECO Guidance - ff_eco.tcl
source "$pt_eco_dir/fast/ff_eco.tcl"

# Legalize ECO Cells
place_eco_cells -legalize_only -eco_changed_cells \
    -legalize_mode minimum_physical_impact \
    -displacement_threshold 10

# Set Up Non-Timing-Driven ECO Routing
set_app_options -list {
    route.global.crosstalk_driven false
    route.track.crosstalk_driven false
    route.global.timing_driven false
    route.track.timing_driven false
    route.detail.timing_driven false
}

# Perform ECO Routing
route_eco -reroute modified_nets_first_then_others

# Post-ECO optimization
route_opt

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (4) #
#######################

# Set for both PT and ECO Fixing
set iter_num "4"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (4) #
########################

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Apply PT Physical ECO Guidance - ss_eco.tcl
source "$pt_eco_dir/slow/ss_eco.tcl"

# Legalize ECO Cells
place_eco_cells -legalize_only -eco_changed_cells \
    -legalize_mode minimum_physical_impact \
    -displacement_threshold 10

# Set Up Non-Timing-Driven ECO Routing
set_app_options -list {
    route.global.crosstalk_driven false
    route.track.crosstalk_driven false
    route.global.timing_driven false
    route.track.timing_driven false
    route.detail.timing_driven false
}

# Perform ECO Routing
route_eco -reroute modified_nets_first_then_others

# Post-ECO optimization
route_opt

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (5) #
#######################

# Set for both PT and ECO Fixing
set iter_num "5"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (5) #
########################

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Apply PT Physical ECO Guidance - ss_eco.tcl
source "$pt_eco_dir/slow/ss_eco.tcl"

# Legalize ECO Cells
place_eco_cells -legalize_only -eco_changed_cells \
    -legalize_mode minimum_physical_impact \
    -displacement_threshold 10

# Set Up Non-Timing-Driven ECO Routing
set_app_options -list {
    route.global.crosstalk_driven false
    route.track.crosstalk_driven false
    route.global.timing_driven false
    route.track.timing_driven false
    route.detail.timing_driven false
}

# Perform ECO Routing
route_eco -reroute modified_nets_first_then_others

# Post-ECO optimization
route_opt

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (6) #
#######################

# Set for both PT and ECO Fixing
set iter_num "6"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (6) #
########################

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Unfixable violations:
#  C - The violation is in clock network
#  ZCTSBUF_7909_1999/Y

# Post Route Optimizations - CTO
# Since CCD is enabled, this will only fix logical DRCs

synthesize_clock_trees -postroute -routed_clock_stage detail_with_signal_routes

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (7) #
#######################

# Set for both PT and ECO Fixing
set iter_num "7"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

########################
# 10. Fix ECO DRCs (7) #
########################

# Fixing clock_network DRC via -cell_type clock_network on PT

set pt_dir "/home/user/Documents/Project/PT"

set pt_eco_dir "$pt_dir/outputs/eco_iter_$iter_num"

set eco_fix_dir "$icc2_dir/reports/ECO_Fix"

set eco_iter "$eco_fix_dir/eco_iter_$iter_num"

file mkdir "$eco_iter"

# Apply PT Physical ECO Guidance - ss_eco.tcl
source "$pt_eco_dir/slow/ss_eco.tcl"

# Legalize ECO Cells
place_eco_cells -legalize_only -eco_changed_cells \
    -legalize_mode minimum_physical_impact \
    -displacement_threshold 10

# Set Up Non-Timing-Driven ECO Routing
set_app_options -list {
    route.global.crosstalk_driven false
    route.track.crosstalk_driven false
    route.global.timing_driven false
    route.track.timing_driven false
    route.detail.timing_driven false
}

# Perform ECO Routing
route_eco -reroute modified_nets_first_then_others

# Post-ECO optimization
route_opt

# Post DRCs Fix - Physical DRCs

check_lvs > "$eco_iter/check_lvs.rpt"
check_routes > "$eco_iter/check_routes.rpt"

# Post DRCs Fix - Logical DRCs

current_scenario ff_scenario
report_constraints -all_violators > "$eco_iter/ff_constraints.rpt"

current_scenario ss_scenario
report_constraints -all_violators > "$eco_iter/ss_constraints.rpt"

report_qor -summary > "$eco_iter/post_route_report_qor_summary.rpt"
report_qor > "$eco_iter/post_route_report_qor.rpt"

# Save block as drc_fixed
save_block -as drc_fix_$iter_num

#######################
# 9. Export to PT (8) #
#######################

# Set for both PT and ECO Fixing
set iter_num "8"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num 

######################################
# 11. Standard Cell Filler Insertion #
######################################

# Set Filler Iteration
set filler_iter_num "1"

set filler_rpt "$icc2_dir/reports/Filler/filler_iter_$filler_iter_num"
set icv_drc_run "$filler_rpt/icv_drc_run"

file mkdir "$filler_rpt"
file mkdir "$icv_drc_run"

# Design For Manufacturing (DFM) ###########################################

# Cell Name
set STD_METAL_FILLER "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT"
set STD_CELL_FILLER "SHFILL1_RVT"
set ANTENNA_CELL "ANTENNA"

# From the lab, I am not sure why we include "ANTENNA" when we are not inserting Antenna Cells

# Std Cell Filler
create_stdcell_fillers -lib_cells $STD_METAL_FILLER
remove_stdcell_fillers_with_violation
connect_pg_net

create_stdcell_fillers -lib_cells $STD_CELL_FILLER

# Save Block Before ICV
save_block -as filler_precheck_$filler_iter_num

########################
# 12. Signoff Fix DRCs #
########################

# IC Validator is not installed on this VM, so we cannot fix Signoff DRCs.....

# Close the Current Block and open the latest filler_precheck_$filler_iter_num Block

# Signoff DRC Setup
set_app_options -name signoff.check_drc.runset \
    -value "$lib_dir/tech/runset/icv_drc/saed32nm_1p9m_drc_rules.rs"

set_app_options -name signoff.check_drc.run_dir \
    -value "$icv_drc_run"

# Signoff DRC Check - All Rules
signoff_check_drc

# Signoff DRC Fix Setup
set_app_options -name signoff.fix_drc.init_drc_error_db \
    -value "$icv_drc_run"

# Signoff DRC Fix - All Rules
signoff_fix_drc

# Eventhough we do not have ICV installed, just run check_routes anyways, but most likely there will be physical DRCs violations

# Post Filler Physical Check
check_routes > "$filler_rpt/check_routes.rpt"

# Save Block
save_block -as filler_$filler_iter_num

######################
# 13. ICV Metal Fill #
######################

# Cannot run this either.....

# ICV In-Design Metal Fill

set_app_options -name signoff.create_metal_fill.runset \
    -value "$lib_dir/tech/runset/icv_drc/saed32nm_1p9m_mfill_rules.rs"

signoff_create_metal_fill

# Save Block
save_block -as filler_complete_$filler_iter_num

########################
# 14. Export to PT (9) #
########################

# Final write_out for this Project

# Set for both PT and ECO Fixing
set iter_num "9"

set write_dir "$icc2_dir/outputs/write_out_$iter_num"

file mkdir "$write_dir"
file mkdir "$write_dir/slow"
file mkdir "$write_dir/fast"

# Verilog
write_verilog \
    -hierarchy all \
    $write_dir/pd_ahb_peripheral_top.v

# Slow SPEF
current_corner ss0p95v125
write_parasitics \
    -format spef \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss0p95v125.spef

# Fast SPEF
current_corner ff1p16v25
write_parasitics \
    -format spef \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff1p16v25.spef

# Slow SDC
current_scenario ss_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/slow/pd_ahb_peripheral_top_ss.sdc

# Fast SDC
current_scenario ff_scenario
write_sdc \
    -exclude net_resistance \
    -output $write_dir/fast/pd_ahb_peripheral_top_ff.sdc

# Save block as write_out
save_block -as write_out_$iter_num

#########################
# 15. Take a Screenshot #
#########################

gui_write_window_image \
    -file "$icc2_dir/outputs/AMBA_AHB_Peripheral_Subsystem_Layout.png"