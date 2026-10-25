vcs -sverilog tb_uart_sram.sv -F ../gls_filelist -debug_access+all
./simv
dve -vpd vcdplus.vpd
