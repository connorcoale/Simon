----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/20/2020 11:00:38 PM
-- Design Name: Random Number Bit Generator
-- Module Name: rng - Behavioral
-- Project Name: Final Project
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 1 bit random number generation
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
use ieee.numeric_std.all;





entity rng is
  PORT (clk: in std_logic;
         rst_rng: in std_logic;
        output: out std_logic );
end rng;

architecture Behavioral of rng is

  signal  Nextstate: std_logic_vector (7 DOWNTO 0);
  signal feedback: std_logic;
  signal Currstate: std_logic_vector (7 downto 0);
  signal counterone : unsigned(7 downto 0) := (others => '0');


begin

  counter: process(clk)
  begin
  
  if rising_edge(clk) then
    counterone <= counterone + 1;
  end if;
  
  end process;

StateReg: process (clk, rst_rng, counterone)
  begin
    if rising_edge(clk) then
      if rst_rng = '1' then
           Currstate <= std_logic_vector(counterone);
      else Currstate <= Nextstate;
      end if;
    end if;
  end process;
    

  
  
  feedback <=  Currstate(4) XOR Currstate(3) XOR Currstate(2) XOR Currstate(0);
  Nextstate <= feedback & Currstate(7 DOWNTO 1);
  output <= Currstate(0);

end Behavioral;
