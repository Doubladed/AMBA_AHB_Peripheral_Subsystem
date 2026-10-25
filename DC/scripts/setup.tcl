
# 1. ROOT DIRECTORIES

set dc_dir  "/home/user/Documents/Project/DC"
set rtl_dir "/home/user/Documents/Project/RTL"
set lib_dir "/home/user/Documents/Project/libs_saed32nm_with_sram_20July2026/libs"

define_design_lib WORK -path "$dc_dir/analyze"

# 2. DC LIBRARIES

set search_path "$search_path \
    $rtl_dir \
    $dc_dir/scripts \
    $lib_dir/stdcell_hvt/db_nldm \
    $lib_dir/stdcell_rvt/db_nldm \
    $lib_dir/stdcell_lvt/db_nldm \
    $lib_dir/sram/db_nldm"

set target_library \
    "saed32hvt_ss0p95v125c.db \
    saed32rvt_ss0p95v125c.db \
    saed32lvt_ss0p95v125c.db"

set link_library "* $target_library saed32sram_ss0p95v125c.db"

# 3. DC TOPOGRAPHICAL LIBRARIES

set mw_reference_library \
    "$lib_dir/stdcell_hvt/milkyway/saed32nm_hvt_1p9m \
    $lib_dir/stdcell_rvt/milkyway/saed32nm_rvt_1p9m \
    $lib_dir/stdcell_lvt/milkyway/saed32nm_lvt_1p9m \
    $lib_dir/sram/milkyway/SRAM32NM" 

# 4. TECHNOLOGY AND RC FILES

set TECH_FILE "$lib_dir/tech/saed32nm_1p9m.tf"

set MAP_FILE "$lib_dir/tech/saed32nm_tf_itf_tluplus.map"

set TLUPLUS_MAX_FILE "$lib_dir/tech/saed32nm_1p9m_Cmax.tluplus"

set TLUPLUS_MIN_FILE "$lib_dir/tech/saed32nm_1p9m_Cmin.tluplus"

# 5. MILKYWAY DESIGN LIBRARY

set mw_design_library "$dc_dir/MYLIB"

if {![file isdirectory $mw_design_library]} {

    create_mw_lib \
        -technology $TECH_FILE \
        -mw_reference_library $mw_reference_library \
        $mw_design_library

} else {

    set_mw_lib_reference \
        $mw_design_library \
        -mw_reference_library $mw_reference_library
}

open_mw_lib $mw_design_library

# 6. TLU+ RC SETUP

set_tlu_plus_files \
    -max_tluplus $TLUPLUS_MAX_FILE \
    -min_tluplus $TLUPLUS_MIN_FILE \
    -tech2itf_map $MAP_FILE

# REPORTS

check_library > $dc_dir/reports/check_lib.rpt
check_tlu_plus_files > $dc_dir/reports/check_tlu.rpt
