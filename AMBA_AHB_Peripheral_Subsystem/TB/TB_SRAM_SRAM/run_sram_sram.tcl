vcs -sverilog tb_sram_sram.sv -F ../tb_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
