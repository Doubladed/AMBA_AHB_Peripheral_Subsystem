# AMBA_AHB_Peripheral_Subsystem

This is my 32-bit AMBA AHB peripheral subsystem project, covering RTL design, simulation, synthesis, physical design and static timing analysis. It includes SRAM, UART, SPI and I2C, implemented using SAED 32 nm libraries.

## Architecture

![Subsystem block diagram](Screenshot/AMBA_AHB_Block_Diagram.png)

The subsystem has four AHB peripheral wrappers connected through an address decoder and response multiplexer. Each wrapper handles the AHB interface and connects it to the respective controller. UART, SPI and I2C also have their own register blocks.

The top-level connections are in [`ahb_peripheral_top.v`](RTL/ahb_peripheral_top.v), and the address decoding is in [`ahb_decmux.v`](RTL/ahb_decmux.v).

| Peripheral | Address range | Blocks |
| --- | --- | --- |
| SRAM | `0x0000_0000 - 0x0000_FFFF` | AHB interface, SRAM controller and memory instances |
| UART | `0x2000_0000 - 0x2000_00FF` | AHB interface, registers, baud-rate generator, transmitter and receiver |
| SPI | `0x3000_0000 - 0x3000_00FF` | AHB interface, registers and SPI controller with four chip-select outputs |
| I2C | `0x4000_0000 - 0x4000_00FF` | AHB interface, registers and I2C controller |

### Testbench

![Overall design and testbench architecture](Screenshot/Overall%20Architecture%20v3.jpg)

An AHB bus functional model drives the subsystem. The testbenches use UART loopback, SPI EEPROM and FeRAM models, and I2C EEPROM and real-time clock/calendar (RTCC) models. SRAM is included in each test case.

### AHB basic transfers

![AHB basic transfers](Screenshot/AMBA_AHB_Basic_Transfers.png)

## Simulation

Waveforms from the six test cases are shown below.

### SRAM

![SRAM-to-SRAM testbench waveform](Screenshot/screenshot_tb_sram_sram.png)

### UART loopback and SRAM

![UART and SRAM testbench waveform](Screenshot/screenshot_tb_uart_sram.png)

### SPI EEPROM and SRAM

![SPI EEPROM and SRAM testbench waveform](Screenshot/screenshot_tb_spi_eeprom_sram.png)

### SPI FeRAM and SRAM

![SPI FeRAM and SRAM testbench waveform](Screenshot/screenshot_tb_spi_feram_sram.png)

### I2C EEPROM and SRAM

![I2C EEPROM and SRAM testbench waveform](Screenshot/screenshot_tb_i2c_eeprom_sram.png)

### I2C RTCC and SRAM

![I2C RTCC and SRAM testbench waveform](Screenshot/screenshot_tb_i2c_rtcc_sram.png)

## Synthesis and physical design

The flow uses Synopsys Design Compiler for synthesis, IC Compiler II for physical design and PrimeTime for timing analysis. The clock target is **100 MHz (10 ns)**, as defined in [`cons.tcl`](DC/scripts/cons.tcl).

![AMBA AHB peripheral subsystem layout](Screenshot/AMBA_AHB_Peripheral_Subsystem_Layout.png)

The [copy from the ICC2 outputs](Screenshot/ICC2_AMBA_AHB_Peripheral_Subsystem_Layout.png) is kept in the same folder.

Reports are included for synthesis, floorplanning, placement, clock-tree synthesis, routing and timing ECO iterations.

| Check | Result | Report |
| --- | --- | --- |
| PrimeTime setup and hold, slow corner | No violations in ECO iteration 9, post-DRC fix | [Slow timing](PT/reports/eco_iter_9/post_drc_fix/slow/global_timing.rpt) |
| PrimeTime setup and hold, fast corner | No violations in ECO iteration 9, post-DRC fix | [Fast timing](PT/reports/eco_iter_9/post_drc_fix/fast/global_timing.rpt) |
| ICC2 routing | 0 open nets, 0 DRCs, 0 antenna violations | [Routing check](ICC2/reports/Routing/check_routes.rpt) |
| ICC2 connectivity | 0 shorts, 0 opens, 0 floating routes | [Connectivity check](ICC2/reports/Routing/check_lvs.rpt) |

There are still two maximum-capacitance violations on SRAM output pins in the slow-corner ECO iteration 9 report, with slack of -0.06 and -0.02. The setup and hold checks pass, but these capacitance violations remain. They are listed in the [constraint report](PT/reports/eco_iter_9/post_drc_fix/slow/cons_all_violators.rpt).

## Files

| Folder | Contents |
| --- | --- |
| [`Screenshot/`](Screenshot/) | Architecture diagrams, simulation waveforms and layout screenshots |
| [`RTL/`](RTL/) | Top-level module, AHB decoder/multiplexer, peripheral wrappers, registers and controllers |
| [`AMBA_AHB_Peripheral_Subsystem/`](AMBA_AHB_Peripheral_Subsystem/) | Simulation RTL, behavioural models and testbenches, including the AHB BFM |
| [`Behavioural_Models/`](Behavioural_Models/) | Memory and peripheral device models |
| [`DC/`](DC/) | Synthesis scripts, constraints, reports and gate-level simulation testbenches |
| [`ICC2/`](ICC2/) | Physical design scripts, floorplan files and reports |
| [`PT/`](PT/) | Timing analysis scripts, ECO scripts and fast/slow corner reports |
| [`libs_saed32nm_with_sram_20July2026/`](libs_saed32nm_with_sram_20July2026/) | Technology libraries |
| [`SAED_RTL/`](SAED_RTL/) | Standard-cell simulation models |

The scripts and file lists still use the original project paths. To run the project in another environment, those paths will need to be updated. Generated simulator builds, waveform databases and tool working databases are ignored; the source, libraries, reports and screenshots are included.
