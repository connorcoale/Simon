
----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel and Connor Coale
-- 
-- Create Date: 08/22/2020 01:24:32 AM
-- Design Name: Countdown
-- Module Name: countdown - Behavioral
-- Project Name: Simon Game
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: Small component to handle the countdown period before the game starts.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- --this code is for the countdown delay for between the time the user presses start and the sequence starts playing.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;




entity countdown is
        port( clk : in std_logic;
         countdown : in std_logic;--controller signal that starts coundown
         countdown_tc : out std_logic);--output goes high when counter is finished
end countdown;

architecture behavior of countdown is

    
    signal counter: integer := 0;
    signal counter_lim: integer := 2000000; --based on 1 MHz masterc clock, countdown in 2 seconds

    
    begin
    
    
 counting: process(clk,countdown) 
 begin                         
    if rising_edge(clk) then
        if counter = counter_lim then--pretty standard process in which the counter resets when it reaches limit
             countdown_tc <= '1';
            counter <= 0;
        elsif countdown = '1' then --and the counter only increments when the control signal (countdown) is high)
            counter <= counter+1;    
             countdown_tc <= '0';
        end if;
    end if;
 end process counting;



end behavior;
