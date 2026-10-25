vcs -sverilog tb_spi_eeprom_sram.sv -F ../gls_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
