----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/23/2020 01:37:54 AM
-- Design Name: LED_output
-- Module Name: LED_output - Behavioral
-- Project Name: Simon Game
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This module controls which LEDs are turned on
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity LED_output is
  PORT (clk: in std_logic;
        btn_id: in unsigned(1 downto 0);
        Rdata: in unsigned(1 downto 0);
        play: in std_logic;
        disp_input: in std_logic;
        play_led_EN: in std_logic; 
        P1: out std_logic;--output LED 1
        P2: out std_logic;--output LED 2
        P3: out std_logic;--output LED 3
        P4: out std_logic);--output LED 4
end LED_output;

architecture Behavioral of LED_output is

begin


  LED: process(clk, play, disp_input, btn_id, Rdata)
  begin
   
   
   
   if rising_edge(clk) then
       P1 <= '0';--default LED state is '0' or off
       P2 <= '0';
       P3 <= '0';
       P4 <= '0'; 
   
       if play = '1' then--controller is in play_sequence state, so the LEDS lit are based on R_dataf rom sequence memory
           if play_led_EN = '1' then--this ensures LEDs are on in sync with the audio output
                case Rdata is
                   when "00" => P1 <= '1';	--each sequence value corresponds to a different id
                   when "01" => P2 <= '1';
                   when "10" => P3 <= '1';	
                   when "11" => P4 <= '1';
                   when others => P1 <= '0'; --prevents vhdl error, so there is default state
                end case;
           end if;
       elsif disp_input = '1' then--if the controller is in the state of displaying user input
       
        case btn_id is--then LEDS are on, if they correspond to the button pressed (btn_id_
           when "00" => P1 <= '1';	
           when "01" => P2 <= '1';
           when "10" => P3 <= '1';	
           when "11" => P4 <= '1';
           when others => P1 <= '0'; 
        end case;
        
       end if;
   end if;
    
   

  end process;
  

end Behavioral;

