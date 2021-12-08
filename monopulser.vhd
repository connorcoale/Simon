----------------------------------------------------------------------------------
-- Company: ENGS 31	
-- Engineer: Eric Hansen, Connor Coale
-- 
-- Create Date: 07/29/2020 12:03:46 AM
-- Design Name: 
-- Module Name: monopulser - behavior
-- Project Name: 
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Monopulser modified from design originally taught during lecture. 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


-- Monopulser design example
-- E.W. Hansen, Engs 31 20X
library IEEE;
use IEEE.std_logic_1164.all;

entity monopulser is
	port(clk: in  std_logic;
    	 x:	  in  std_logic;
         y:	  out std_logic );
end monopulser;

architecture behavior of monopulser is
-- Declare state_type, curr_state, and next_state here

-- curr_state and next_state will initialize to the first state in the list
	type state_type is (waitpress, pulse, waitrelease);
    signal curr_state, next_state: state_type; 
    
-- Also declare any other signals that you need

begin

-- Next state and output logic
fsm_logic:	process(x, curr_state)
begin
	-- Default values for output and next state
	y <= '0';				
    next_state <= curr_state;
    
	-- Use case construction for logic
    case curr_state is
    	when waitpress => 
            if x='1' then
            	next_state <= pulse;
            end if;
            
        when pulse =>
        	y <= '1';
           	next_state <= waitrelease;       
 
        when waitrelease =>
            if x='0' then
            	next_state <= waitpress;
            end if;
    end case;
end process fsm_logic;

-- State register update
fsm_update: process(clk)
begin
	if rising_edge(clk) then
    	curr_state <= next_state;
    end if;
end process fsm_update;

end behavior;

