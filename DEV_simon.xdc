## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
## - CASE SENSITIVE: make sure the port names here exactly match those in your top level!

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
	
 #== DEBUGGING PINS TO ONBOARD LEDS =======================
# #debounced buttons to onboard LEDs
# set_property PACKAGE_PIN U16 [get_ports BTNC_DB_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports BTNC_DB_LA]
#set_property PACKAGE_PIN E19 [get_ports BTNU_DB_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports BTNU_DB_LA]
#set_property PACKAGE_PIN U19 [get_ports BTNL_DB_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports BTNL_DB_LA]
#set_property PACKAGE_PIN V19 [get_ports BTNR_DB_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports BTNR_DB_LA]
#set_property PACKAGE_PIN W18 [get_ports BTND_DB_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports BTND_DB_LA]

##LED outputs to onboard LEDs
#set_property PACKAGE_PIN U15 [get_ports P1_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports P1_LA]
#set_property PACKAGE_PIN U14 [get_ports P2_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports P2_LA]
#set_property PACKAGE_PIN V14 [get_ports P3_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports P3_LA]
#set_property PACKAGE_PIN V13 [get_ports P4_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports P4_LA]

#set_property PACKAGE_PIN V3 [get_ports reset_connector_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports reset_connector_LA]
#set_property PACKAGE_PIN W3 [get_ports gen_connector_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports gen_connector_LA]
#set_property PACKAGE_PIN U3 [get_ports countdown_connector_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports countdown_connector_LA]
#set_property PACKAGE_PIN P3 [get_ports play_connector_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports play_connector_LA]	
#set_property PACKAGE_PIN N3 [get_ports disp_input_connector_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports disp_input_connector_LA]	
#set_property PACKAGE_PIN P1 [get_ports correct_connector_LA]						
#	set_property IOSTANDARD LVCMOS33 [get_ports correct_connector_LA]
#============================================================
## Switches
#set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
#set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
#set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
#set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
#set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
#set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
#set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
#set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]

	
	
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
##Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports {JA[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
##Sch name = JA9
#set_property PACKAGE_PIN H2 [get_ports {JA[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
##Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]
	
##Pmod Header JB
##Sch name = JB1
#set_property PACKAGE_PIN A14 [get_ports {P1}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {P1}]
###Sch name = JB2
#set_property PACKAGE_PIN A16 [get_ports {P2}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {P2}]
###Sch name = JB3
#set_property PACKAGE_PIN B15 [get_ports {P3}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {P3}]
###Sch name = JB4
#set_property PACKAGE_PIN B16 [get_ports {P4}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {P4}]
###Sch name = JB7
#set_property PACKAGE_PIN A15 [get_ports {audio_out}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {audio_out}]


## These additional constraints are recommended by Digilent, do not remove!
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]