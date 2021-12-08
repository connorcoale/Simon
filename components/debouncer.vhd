----------------------------------------------------------------------------------
-- Engineer: Connor Coale
-- 
-- Create Date: 07/20/2020 05:18:49 PM
-- Design Name: Debouncer
-- Module Name: debouncer - behavior
-- Project Name: HW4 problem 1
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 
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


entity debouncer is
    port( clk: in std_logic;
          button: in std_logic;
          button_db: out std_logic);
end debouncer;

architecture behavior of debouncer is
    constant MAXCOUNT: integer := 50; --CYCLES TO HIT A TIMEOUT
    signal reset: std_logic := '1';
    signal timeout: std_logic := '0';
    signal indicator: std_logic_vector(1 downto 0) := "00";
    signal counter: unsigned(5 downto 0) := "000100";
    type statetype is (waitpress, db_press, waitrelease, db_release);
    signal curr_state, next_state: statetype;
    
begin
   
    

timer: process(clk)
    begin
    if rising_edge(clk) then
         -- defaults
        timeout <= '0';
        
        if reset = '1' then -- Reset to 0 when reset is enabled.
            counter <= "000000";    
            
        else
            counter <= counter + 1;
            if counter = MAXCOUNT-1 then
                timeout <= '1';
            end if;
        end if;
        
    end if;
    
end process timer;


FSM_comb: process(button, curr_state, timeout)
begin
    next_state <= curr_state; -- defaults
    button_db <= '0';
    
    case curr_state is -- state transitions, outputs
      --  begin
            when waitpress =>
                indicator <= "00";
                reset <= '1';
                
                if button = '0' then
                    next_state <= db_press;
                end if;
            
            
            when db_press => 
                reset <= '0';
                indicator <= "01";
                if timeout = '1' then
                    next_state <= waitrelease;
                    reset <= '1';
                end if;
                if button = '1' then
                    next_state <= waitpress;
                    reset <= '1';
                end if;
                
                
              
            when waitrelease =>
            	indicator <= "10";
                reset <= '1';
                button_db <= '1';
                if button = '1' then
                    next_state <= db_release;
                end if;   
            
            
            when db_release =>
            	indicator <= "11";
                
                reset <= '0';
                button_db <= '1';
                
                if button = '0' then
                    next_state <= waitrelease;
                end if;
                if timeout = '1' then
                    next_state <= waitpress;
                    reset <= '1';
                end if;
            
            
    end case;
    
    
    
end process FSM_comb;


FSM_update: process(clk)
begin
    if rising_edge(clk) then
        curr_state <= next_state;
    end if;
end process FSM_update;



end behavior;

