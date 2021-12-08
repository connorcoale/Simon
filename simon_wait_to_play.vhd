----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/26/2020 09:00:53 PM
-- Design Name: 
-- Module Name: simon_wait_to_play - Behavioral
-- Project Name: 
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Simple countdown for in between when a user enters a sequence correctly and the start
-- of the next sequence being played.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 


----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/22/2020 01:24:32 AM
-- Design Name: delay counter between incrementing level and playing sequence
-- Module Name: simon_wait_to_play counter - Behavioral
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
-- This counter is for the wait_to_play sequence, to provide a delay between evaluation
--and playing the next sequence, for a smoother game play
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity wait_to_play is
        port( clk : in std_logic;
         waitcount : in std_logic;--high when controller is in wait counts state
         waitcount_tc : out std_logic );--high when counter reaches limit
end wait_to_play;

architecture behavior of wait_to_play is

    
    signal counter: integer := 0;
    signal counter_lim: integer :=1000000; --based on 1 MHz masterc clock, countdown in 1 second

    
    begin
    
    
 counting: process(clk,waitcount) 
 begin
    if rising_edge(clk) then
        if counter = counter_lim then --standard processw where counter resets when it reaches it's limit
            waitcount_tc <= '1';--and waitcount_tc goes high once limit is reached
            counter <= 0;
        elsif waitcount = '1' then--then counter only increments when control signal is high 
            counter <= counter+1; 
            waitcount_tc <= '0';   
        end if;
    end if;
 end process counting;



end behavior;
