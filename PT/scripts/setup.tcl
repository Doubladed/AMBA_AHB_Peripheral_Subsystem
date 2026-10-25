# Root Dir

set pt_dir "/home/user/Documents/Project/PT"

set icc2_dir "/home/user/Documents/Project/ICC2"

# Set for both PT and ECO Fixing
set iter_num "9"

# ICC2 Write Out Dir
set icc2_write_dir "$icc2_dir/outputs/write_out_$iter_num"

# PT Iteration Dir
set pt_out_dir "$pt_dir/outputs/eco_iter_$iter_num"
set pt_rpt_dir "$pt_dir/reports/eco_iter_$iter_num"

file mkdir "$pt_out_dir/slow"
file mkdir "$pt_out_dir/fast"

file mkdir "$pt_rpt_dir/slow"
file mkdir "$pt_rpt_dir/fast"
file mkdir "$pt_rpt_dir/post_drc_fix/slow"
file mkdir "$pt_rpt_dir/post_drc_fix/fast"

# Logical Dir

set lib_dir "/home/user/Documents/Project/libs_saed32nm_with_sram_20July2026/libs"

# Physical Dir

set design_lib "$icc2_dir/MYLIB"

# Load Design and Check

read_verilog $icc2_write_dir/pd_ahb_peripheral_top.v

get_designs *
list_designs

# Load Libraries and Check

set search_path "$search_path \
    $pt_dir/scripts \
    $lib_dir/stdcell_hvt/db_nldm \
    $lib_dir/stdcell_rvt/db_nldm \
    $lib_dir/stdcell_lvt/db_nldm \
    $lib_dir/sram/db_nldm"

set slow_lib \
    "saed32hvt_ss0p95v125c.db \
    saed32rvt_ss0p95v125c.db \
    saed32lvt_ss0p95v125c.db \
    saed32sram_ss0p95v125c.db"

set fast_lib \
    "saed32hvt_ff1p16v25c.db \
    saed32rvt_ff1p16v25c.db \
    saed32lvt_ff1p16v25c.db \
    saed32sram_ff1p16v25c.db"
