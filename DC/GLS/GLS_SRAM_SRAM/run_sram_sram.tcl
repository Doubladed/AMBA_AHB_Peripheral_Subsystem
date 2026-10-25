vcs -sverilog tb_sram_sram.sv -F ../gls_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
