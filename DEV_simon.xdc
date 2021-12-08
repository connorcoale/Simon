
## Clock signal
## PIPES 100 MHZ CLOCK INTO THE SHELL THROUGH INPUT PORT mclk
set_property PACKAGE_PIN W5 [get_ports mclk]							
	set_property IOSTANDARD LVCMOS33 [get_ports mclk]
	create_clock -add -name mclk -period 10.00 -waveform {0 5} [get_ports mclk]
 
 ##Buttons
set_property PACKAGE_PIN U18 [get_ports BTNC]						
	set_property IOSTANDARD LVCMOS33 [get_ports BTNC]
set_property PACKAGE_PIN T18 [get_ports BTNU]						
	set_property IOSTANDARD LVCMOS33 [get_ports BTNU]
set_property PACKAGE_PIN W19 [get_ports BTNL]						
	set_property IOSTANDARD LVCMOS33 [get_ports BTNL]
set_property PACKAGE_PIN U17 [get_ports BTNR]						
	set_property IOSTANDARD LVCMOS33 [get_ports BTNR]
set_property PACKAGE_PIN T17 [get_ports BTND]						
	set_property IOSTANDARD LVCMOS33 [get_ports BTND]
	
	
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {seg7_cat[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg7_cat[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg7_cat[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg7_cat[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg7_cat[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg7_cat[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg7_cat[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_cat[6]}]

set_property PACKAGE_PIN V7 [get_ports seg7_dp]							
	set_property IOSTANDARD LVCMOS33 [get_ports seg7_dp]

set_property PACKAGE_PIN U2 [get_ports {seg7_an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_an[0]}]
set_property PACKAGE_PIN U4 [get_ports {seg7_an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_an[1]}]
set_property PACKAGE_PIN V4 [get_ports {seg7_an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_an[2]}]
set_property PACKAGE_PIN W4 [get_ports {seg7_an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg7_an[3]}]



##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {P1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {P1}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {P2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {P2}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {P3}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {P3}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {P4}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {P4}]
##Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {audio_out}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {audio_out}]

## These additional constraints are recommended by Digilent, do not remove!
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]