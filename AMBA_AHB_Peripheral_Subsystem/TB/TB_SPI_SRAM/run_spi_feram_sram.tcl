vcs -sverilog tb_spi_feram_sram.sv -F ../tb_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
