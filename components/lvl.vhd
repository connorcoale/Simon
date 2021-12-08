----------------------------------------------------------------------------------
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/23/2020 01:23:02 AM
-- Design Name: level_incrementer
-- Module Name: lvl - Behavioral
-- Project Name: Simon Game
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: Keeps track of the level that the Simon game is currently at.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------





library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity level is
  PORT (clk: in std_logic;
        inc_lvl: in std_logic;
        reset: in std_logic;
        lvl: out unsigned(4 downto 0));
end level;

architecture Behavioral of level is


    signal counter: unsigned(4 downto 0) := "00000";

begin



  level_counter: process(clk,inc_lvl,reset)
  begin
   
   if rising_edge(clk) then
        if inc_lvl = '1' then
            if counter < "11111" then
              counter <= counter + 1;
            end if;
        end if;
        -- reset to zero while in Idle, and when a game restart occurs.
        if reset = '1' then
            counter <= "00000";
        end if;
           
   end if;

  end process;
  
 lvl <= counter; 


end Behavioral;
