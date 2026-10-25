vcs -sverilog tb_i2c_rtcc_sram.sv -F ../tb_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
