vcs -sverilog tb_spi_feram_sram.sv -F ../gls_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
