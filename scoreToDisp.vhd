----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/23/2020 08:16:03 PM
-- Design Name: Score to Mux7 Display
-- Module Name: scoreToDisp - Behavioral
-- Project Name: Simon Game
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This code converts the 5 bit unsigned level value, into two 4 bit unsigned
--decimal digits that can be displayed by the mux-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity scoreToDisp is
  Port (clk: in std_logic;
        lvl: in unsigned(4 downto 0);--level value
        y0: out unsigned(3 downto 0);--far right digit (LSB) on MUX-7 display
        y1: out unsigned(3 downto 0));--second from right digit on MUX-7 diplay
end scoreToDisp;

architecture Behavioral of scoreToDisp is

signal ilvl_int: integer;
signal ilvl_int_lsb: integer;
signal ilvl_int_msb: integer;
begin

  ilvl_int <= to_integer(lvl + 1);--adds one to level (as it is represented by 0-31, but we want to display 1-32) and converts unsigned to an integer 
  ilvl_int_lsb <= ilvl_int mod 10;--use modulus 10 math to find lsb and msb in decimal
  ilvl_int_msb <= (ilvl_int - ilvl_int_lsb)/10;

  
  
  display: process(clk,lvl)
  begin
      if rising_edge(clk) then
              y0 <= to_unsigned(ilvl_int_lsb,4);
              y1 <= to_unsigned(ilvl_int_msb,4);
      end if;
  
  end process;
  


end Behavioral;
