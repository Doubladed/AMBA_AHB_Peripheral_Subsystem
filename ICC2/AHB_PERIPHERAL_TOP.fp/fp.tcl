################################################################################
#
# Created by icc2 write_floorplan on Thu Aug 20 19:31:26 2026
#
################################################################################


set _dirName__0 [file dirname [file normalize [info script]]]

################################################################################
# Rows
################################################################################

remove_site_arrays -all

remove_site_rows -all

################################################################################
# Pins
################################################################################

set __pins [get_terminals -quiet]
if {[sizeof_collection $__pins] > 0} {
set __termShapes [get_shapes -of_objects [get_terminals * -quiet] -quiet]
if {[sizeof_collection $__termShapes] > 0} {
remove_shapes $__termShapes -force
}
set __termVias [get_vias -of_objects [get_terminals * -quiet] -quiet]
if {[sizeof_collection $__termVias] > 0} {
remove_vias $__termVias -force
}
set __termShapePatterns [get_shape_patterns -of_objects [get_terminals * -quiet] -quiet]
if {[sizeof_collection $__termShapePatterns] > 0} {
remove_shape_patterns $__termShapePatterns
}
}

################################################################################
# Net shapes and vias
################################################################################

set __netshapes [get_shapes -quiet]
if {[sizeof_collection $__netshapes] > 0} {
remove_shapes $__netshapes -force
}

set __netShapePatterns [get_shape_patterns -quiet]
if {[sizeof_collection $__netShapePatterns] > 0} {
remove_shape_patterns $__netShapePatterns
}

set __vias [get_vias -quiet]
if {[sizeof_collection $__vias] > 0} {
remove_vias $__vias -force
}

################################################################################
# Read DEF
################################################################################

read_def  ${_dirName__0}/floorplan.def

################################################################################
# Voltage areas
################################################################################

remove_voltage_areas -all

remove_voltage_area_shapes [get_voltage_area_shapes -of_objects DEFAULT_VA]




################################################################################
# User attributes of voltage areas
################################################################################

################################################################################
# Site arrays
################################################################################

create_site_array -name unit_row -site unit -default -boundary { {8.0000 \
    8.0000} {1132.9520 517.9600} } -flip_first_row true -flip_alternate_row \
    true -transparent false -direction horizontal -x_margin 0.0000 -y_margin \
    0.0000 -core_offset { 8.0000 8.0000 } -aligned true

################################################################################
# User attributes of site arrays
################################################################################


################################################################################
# Site rows cycle and offset attributes
################################################################################

################################################################################
# User attributes of site rows
################################################################################


################################################################################
# Keepouts
################################################################################

create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM15 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM14 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM13 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM12 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM11 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM10 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM9 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM8 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM7 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM6 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM5 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM4 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM3 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM2 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM1 }
create_keepout_margin -type hard -outer { 5.0000 5.0000 5.0000 5.0000 } { \
    AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM0 }

################################################################################
# User attributes of cells
################################################################################


################################################################################
# Bounds and user attributes of bound shapes
################################################################################

remove_bounds -all


################################################################################
# User attributes of bounds
################################################################################


################################################################################
# Pin guides
################################################################################

remove_pin_guides -all


################################################################################
# Route guides and their user attributes
################################################################################

remove_routing_guides -all



################################################################################
# Blockages
################################################################################

remove_routing_blockages -all -force

set routing_blockage [create_routing_blockage -name_prefix RB_0 -layers { M6 } \
    -boundary { {880.4400 13.0000} {880.4400 123.5090} {1127.9520 123.5090} \
    {1127.9520 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_1 -layers { M7 } \
    -boundary { {880.4400 13.0000} {880.4400 123.5090} {1127.9520 123.5090} \
    {1127.9520 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_2 -layers { M8 } \
    -boundary { {880.4400 13.0000} {880.4400 123.5090} {1127.9520 123.5090} \
    {1127.9520 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_3 -layers { M9 } \
    -boundary { {880.4400 13.0000} {880.4400 123.5090} {1127.9520 123.5090} \
    {1127.9520 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_4 -layers { M6 } \
    -boundary { {622.9280 13.0000} {622.9280 123.5090} {870.4400 123.5090} \
    {870.4400 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_5 -layers { M7 } \
    -boundary { {622.9280 13.0000} {622.9280 123.5090} {870.4400 123.5090} \
    {870.4400 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_6 -layers { M8 } \
    -boundary { {622.9280 13.0000} {622.9280 123.5090} {870.4400 123.5090} \
    {870.4400 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_7 -layers { M9 } \
    -boundary { {622.9280 13.0000} {622.9280 123.5090} {870.4400 123.5090} \
    {870.4400 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_8 -layers { M6 } \
    -boundary { {880.4400 147.4710} {880.4400 257.9800} {1127.9520 257.9800} \
    {1127.9520 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_9 -layers { M7 } \
    -boundary { {880.4400 147.4710} {880.4400 257.9800} {1127.9520 257.9800} \
    {1127.9520 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_10 -layers { M8 } \
    -boundary { {880.4400 147.4710} {880.4400 257.9800} {1127.9520 257.9800} \
    {1127.9520 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_11 -layers { M9 } \
    -boundary { {880.4400 147.4710} {880.4400 257.9800} {1127.9520 257.9800} \
    {1127.9520 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_12 -layers { M6 } \
    -boundary { {622.9280 147.4710} {622.9280 257.9800} {870.4400 257.9800} \
    {870.4400 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_13 -layers { M7 } \
    -boundary { {622.9280 147.4710} {622.9280 257.9800} {870.4400 257.9800} \
    {870.4400 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_14 -layers { M8 } \
    -boundary { {622.9280 147.4710} {622.9280 257.9800} {870.4400 257.9800} \
    {870.4400 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_15 -layers { M9 } \
    -boundary { {622.9280 147.4710} {622.9280 257.9800} {870.4400 257.9800} \
    {870.4400 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_16 -layers { M6 } \
    -boundary { {270.5120 13.0000} {270.5120 123.5090} {518.0240 123.5090} \
    {518.0240 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_17 -layers { M7 } \
    -boundary { {270.5120 13.0000} {270.5120 123.5090} {518.0240 123.5090} \
    {518.0240 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_18 -layers { M8 } \
    -boundary { {270.5120 13.0000} {270.5120 123.5090} {518.0240 123.5090} \
    {518.0240 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_19 -layers { M9 } \
    -boundary { {270.5120 13.0000} {270.5120 123.5090} {518.0240 123.5090} \
    {518.0240 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_20 -layers { M6 } \
    -boundary { {13.0000 13.0000} {13.0000 123.5090} {260.5120 123.5090} \
    {260.5120 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_21 -layers { M7 } \
    -boundary { {13.0000 13.0000} {13.0000 123.5090} {260.5120 123.5090} \
    {260.5120 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_22 -layers { M8 } \
    -boundary { {13.0000 13.0000} {13.0000 123.5090} {260.5120 123.5090} \
    {260.5120 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_23 -layers { M9 } \
    -boundary { {13.0000 13.0000} {13.0000 123.5090} {260.5120 123.5090} \
    {260.5120 13.0000} }]
set routing_blockage [create_routing_blockage -name_prefix RB_24 -layers { M6 } \
    -boundary { {270.5120 147.4710} {270.5120 257.9800} {518.0240 257.9800} \
    {518.0240 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_25 -layers { M7 } \
    -boundary { {270.5120 147.4710} {270.5120 257.9800} {518.0240 257.9800} \
    {518.0240 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_26 -layers { M8 } \
    -boundary { {270.5120 147.4710} {270.5120 257.9800} {518.0240 257.9800} \
    {518.0240 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_27 -layers { M9 } \
    -boundary { {270.5120 147.4710} {270.5120 257.9800} {518.0240 257.9800} \
    {518.0240 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_28 -layers { M6 } \
    -boundary { {13.0000 147.4710} {13.0000 257.9800} {260.5120 257.9800} \
    {260.5120 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_29 -layers { M7 } \
    -boundary { {13.0000 147.4710} {13.0000 257.9800} {260.5120 257.9800} \
    {260.5120 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_30 -layers { M8 } \
    -boundary { {13.0000 147.4710} {13.0000 257.9800} {260.5120 257.9800} \
    {260.5120 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_31 -layers { M9 } \
    -boundary { {13.0000 147.4710} {13.0000 257.9800} {260.5120 257.9800} \
    {260.5120 147.4710} }]
set routing_blockage [create_routing_blockage -name_prefix RB_32 -layers { M6 } \
    -boundary { {880.4400 267.9800} {880.4400 378.4890} {1127.9520 378.4890} \
    {1127.9520 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_33 -layers { M7 } \
    -boundary { {880.4400 267.9800} {880.4400 378.4890} {1127.9520 378.4890} \
    {1127.9520 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_34 -layers { M8 } \
    -boundary { {880.4400 267.9800} {880.4400 378.4890} {1127.9520 378.4890} \
    {1127.9520 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_35 -layers { M9 } \
    -boundary { {880.4400 267.9800} {880.4400 378.4890} {1127.9520 378.4890} \
    {1127.9520 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_36 -layers { M6 } \
    -boundary { {622.9280 267.9800} {622.9280 378.4890} {870.4400 378.4890} \
    {870.4400 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_37 -layers { M7 } \
    -boundary { {622.9280 267.9800} {622.9280 378.4890} {870.4400 378.4890} \
    {870.4400 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_38 -layers { M8 } \
    -boundary { {622.9280 267.9800} {622.9280 378.4890} {870.4400 378.4890} \
    {870.4400 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_39 -layers { M9 } \
    -boundary { {622.9280 267.9800} {622.9280 378.4890} {870.4400 378.4890} \
    {870.4400 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_40 -layers { M6 } \
    -boundary { {880.4400 402.4510} {880.4400 512.9600} {1127.9520 512.9600} \
    {1127.9520 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_41 -layers { M7 } \
    -boundary { {880.4400 402.4510} {880.4400 512.9600} {1127.9520 512.9600} \
    {1127.9520 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_42 -layers { M8 } \
    -boundary { {880.4400 402.4510} {880.4400 512.9600} {1127.9520 512.9600} \
    {1127.9520 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_43 -layers { M9 } \
    -boundary { {880.4400 402.4510} {880.4400 512.9600} {1127.9520 512.9600} \
    {1127.9520 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_44 -layers { M6 } \
    -boundary { {622.9280 402.4510} {622.9280 512.9600} {870.4400 512.9600} \
    {870.4400 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_45 -layers { M7 } \
    -boundary { {622.9280 402.4510} {622.9280 512.9600} {870.4400 512.9600} \
    {870.4400 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_46 -layers { M8 } \
    -boundary { {622.9280 402.4510} {622.9280 512.9600} {870.4400 512.9600} \
    {870.4400 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_47 -layers { M9 } \
    -boundary { {622.9280 402.4510} {622.9280 512.9600} {870.4400 512.9600} \
    {870.4400 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_48 -layers { M6 } \
    -boundary { {270.5120 267.9800} {270.5120 378.4890} {518.0240 378.4890} \
    {518.0240 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_49 -layers { M7 } \
    -boundary { {270.5120 267.9800} {270.5120 378.4890} {518.0240 378.4890} \
    {518.0240 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_50 -layers { M8 } \
    -boundary { {270.5120 267.9800} {270.5120 378.4890} {518.0240 378.4890} \
    {518.0240 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_51 -layers { M9 } \
    -boundary { {270.5120 267.9800} {270.5120 378.4890} {518.0240 378.4890} \
    {518.0240 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_52 -layers { M6 } \
    -boundary { {13.0000 267.9800} {13.0000 378.4890} {260.5120 378.4890} \
    {260.5120 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_53 -layers { M7 } \
    -boundary { {13.0000 267.9800} {13.0000 378.4890} {260.5120 378.4890} \
    {260.5120 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_54 -layers { M8 } \
    -boundary { {13.0000 267.9800} {13.0000 378.4890} {260.5120 378.4890} \
    {260.5120 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_55 -layers { M9 } \
    -boundary { {13.0000 267.9800} {13.0000 378.4890} {260.5120 378.4890} \
    {260.5120 267.9800} }]
set routing_blockage [create_routing_blockage -name_prefix RB_56 -layers { M6 } \
    -boundary { {270.5120 402.4510} {270.5120 512.9600} {518.0240 512.9600} \
    {518.0240 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_57 -layers { M7 } \
    -boundary { {270.5120 402.4510} {270.5120 512.9600} {518.0240 512.9600} \
    {518.0240 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_58 -layers { M8 } \
    -boundary { {270.5120 402.4510} {270.5120 512.9600} {518.0240 512.9600} \
    {518.0240 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_59 -layers { M9 } \
    -boundary { {270.5120 402.4510} {270.5120 512.9600} {518.0240 512.9600} \
    {518.0240 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_60 -layers { M6 } \
    -boundary { {13.0000 402.4510} {13.0000 512.9600} {260.5120 512.9600} \
    {260.5120 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_61 -layers { M7 } \
    -boundary { {13.0000 402.4510} {13.0000 512.9600} {260.5120 512.9600} \
    {260.5120 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_62 -layers { M8 } \
    -boundary { {13.0000 402.4510} {13.0000 512.9600} {260.5120 512.9600} \
    {260.5120 402.4510} }]
set routing_blockage [create_routing_blockage -name_prefix RB_63 -layers { M9 } \
    -boundary { {13.0000 402.4510} {13.0000 512.9600} {260.5120 512.9600} \
    {260.5120 402.4510} }]


remove_placement_blockages -all -force

set placement_blockage [create_placement_blockage -name pb_0 -type soft \
    -boundary { {523.0240 397.5760} {531.9440 517.9600} }]
set placement_blockage [create_placement_blockage -name pb_1 -type soft \
    -boundary { {609.3120 397.5760} {617.8780 517.9600} }]
set placement_blockage [create_placement_blockage -name pb_4 -type soft \
    -boundary { {523.0740 8.0000} {531.9440 397.5760} }]
set placement_blockage [create_placement_blockage -name pb_2 -type soft \
    -boundary { {609.3120 8.0000} {617.9280 397.5760} }]


remove_pin_blockages -all

remove_shaping_blockages -all

################################################################################
# User attributes of blockages
################################################################################



################################################################################
# Module Boundaries
################################################################################

set hbCells [get_cells -quiet -filter hierarchy_type==boundary -hierarchical]
if [sizeof_collection $hbCells] {
   set_cell_hierarchy_type -type normal $hbCells
}


################################################################################
# User_shapes not written out by the def part
################################################################################

################################################################################
# Placment_Attractions
################################################################################

set _placementAttractions [get_placement_attractions * -quiet]
if [sizeof_collection $_placementAttractions] {
remove_placement_attractions $_placementAttractions -force
}

################################################################################
# User attributes of placement attractions
################################################################################


################################################################################
# Bump regions
################################################################################

remove_bump_regions -all

remove_pseudo_tsv_defs -all

remove_bump_regions -all

remove_bump_region_patterns -all

################################################################################
# set attributes of pseudo bumps
################################################################################

################################################################################
# set attributes of pseudo tsvs
################################################################################

################################################################################
# User attributes of bump region
################################################################################

################################################################################
# Bundles
################################################################################

set _bundles [get_bundles * -quiet]
if [sizeof_collection $_bundles] {
remove_bundles $_bundles
}


################################################################################
# User attributes of bundles
################################################################################


################################################################################
# I/O guides
################################################################################

remove_io_guides -all


################################################################################
# User attributes of I/O guides
################################################################################


################################################################################
# Edit groups
################################################################################

remove_edit_groups -all -force


################################################################################
# User attributes of edit groups
################################################################################


################################################################################
# PG regions
################################################################################

remove_pg_regions -all


################################################################################
# User attributes of pg regions
################################################################################


################################################################################
# Routing corridors
################################################################################

remove_routing_corridors -all


################################################################################
# Routing directions
################################################################################

set_attribute -objects [get_layers M1] -name routing_direction -value horizontal
set_attribute -objects [get_layers M2] -name routing_direction -value vertical
set_attribute -objects [get_layers M3] -name routing_direction -value horizontal
set_attribute -objects [get_layers M4] -name routing_direction -value vertical
set_attribute -objects [get_layers M5] -name routing_direction -value horizontal
set_attribute -objects [get_layers M6] -name routing_direction -value vertical
set_attribute -objects [get_layers M7] -name routing_direction -value horizontal
set_attribute -objects [get_layers M8] -name routing_direction -value vertical
set_attribute -objects [get_layers M9] -name routing_direction -value horizontal

################################################################################
# Tracks and their user attributes
################################################################################

remove_tracks -all

set track [create_track -layer M1 -count 3460 -dir Y -space 0.1520 -coord \
    0.0960 -bbox {{0.0000 0.0960 } {1140.9520 525.8640 }}]
set track [create_track -layer M1 -count 7506 -dir X -space 0.1520 -coord \
    0.0960 -bbox {{0.0960 0.0000 } {1140.8560 525.9600 }}]
set track [create_track -layer M2 -count 3460 -dir Y -space 0.1520 -coord \
    0.0960 -bbox {{0.0000 0.0960 } {1140.9520 525.8640 }}]
set track [create_track -layer M2 -count 7506 -dir X -space 0.1520 -coord \
    0.0960 -bbox {{0.0960 0.0000 } {1140.8560 525.9600 }}]
set track [create_track -layer M3 -count 1730 -dir Y -space 0.3040 -coord \
    0.0960 -bbox {{0.0000 0.0960 } {1140.9520 525.7120 }}]
set track [create_track -layer M3 -count 3753 -dir X -space 0.3040 -coord \
    0.0960 -bbox {{0.0960 0.0000 } {1140.7040 525.9600 }}]
set track [create_track -layer M4 -count 1730 -dir Y -space 0.3040 -coord \
    0.0960 -bbox {{0.0000 0.0960 } {1140.9520 525.7120 }}]
set track [create_track -layer M4 -count 3753 -dir X -space 0.3040 -coord \
    0.0960 -bbox {{0.0960 0.0000 } {1140.7040 525.9600 }}]
set track [create_track -layer M5 -count 865 -dir Y -space 0.6080 -coord 0.0960 \
    -bbox {{0.0000 0.0960 } {1140.9520 525.4080 }}]
set track [create_track -layer M5 -count 1877 -dir X -space 0.6080 -coord \
    0.0960 -bbox {{0.0960 0.0000 } {1140.7040 525.9600 }}]
set track [create_track -layer M6 -count 865 -dir Y -space 0.6080 -coord 0.0960 \
    -bbox {{0.0000 0.0960 } {1140.9520 525.4080 }}]
set track [create_track -layer M6 -count 1877 -dir X -space 0.6080 -coord \
    0.0960 -bbox {{0.0960 0.0000 } {1140.7040 525.9600 }}]
set track [create_track -layer M7 -count 432 -dir Y -space 1.2160 -coord 0.7040 \
    -bbox {{0.0000 0.7040 } {1140.9520 524.8000 }}]
set track [create_track -layer M7 -count 938 -dir X -space 1.2160 -coord 0.7040 \
    -bbox {{0.7040 0.0000 } {1140.0960 525.9600 }}]
set track [create_track -layer M8 -count 432 -dir Y -space 1.2160 -coord 0.7040 \
    -bbox {{0.0000 0.7040 } {1140.9520 524.8000 }}]
set track [create_track -layer M8 -count 938 -dir X -space 1.2160 -coord 0.7040 \
    -bbox {{0.7040 0.0000 } {1140.0960 525.9600 }}]
set track [create_track -layer M9 -count 216 -dir Y -space 2.4320 -coord 0.7040 \
    -bbox {{0.0000 0.7040 } {1140.9520 523.5840 }}]
set track [create_track -layer M9 -count 469 -dir X -space 2.4320 -coord 0.7040 \
    -bbox {{0.7040 0.0000 } {1138.8800 525.9600 }}]
set track [create_track -layer MRDL -count 108 -dir Y -space 4.8640 -coord \
    3.1360 -bbox {{0.0000 3.1360 } {1140.9520 523.5840 }}]
set track [create_track -layer MRDL -count 234 -dir X -space 4.8640 -coord \
    3.1360 -bbox {{3.1360 0.0000 } {1136.4480 525.9600 }}]

################################################################################
# Terminals/shapes/vias of ports with user attributes
################################################################################

################################################################################
# User attributes of ports
################################################################################


################################################################################
# Shapes and vias of net and their user attributes
################################################################################


################################################################################
# User attributes of routing rules
################################################################################


################################################################################
# User attributes of pins
################################################################################


################################################################################
# User attributes of nets
################################################################################


################################################################################
# Anchors
################################################################################

################################################################################
# User attributes of current block
################################################################################


