----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel
-- 
-- Create Date: 08/23/2020 06:01:46 PM
-- Design Name: Evaluation of Sequence Block
-- Module Name: eval_seq - Behavioral
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
-- --this component works by evaluating the user input (btn_id) and comparing it to the corresponding value stored in sequence memory (R_data) 
--if btn_id equals R_data, then the user must have pressed the correct button, so eval_indx increments, so the next time this component runs, R_data 
--(indexxed by eval_index) will correspond to the next button press in the sequence. If eval_indx equals the current level of the game,  
--then sequence_tc goes high, indicating that the user has completed a level - eval_indx then resets. If btn_id does not match R_data, then correct
--goes low. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity eval_seq is
  PORT (clk: IN std_logic;
        lvl: in unsigned(4 downto 0);
        eval: in std_logic;--control signal 
        btn_id: in unsigned(1 downto 0);--the value (0-3) that corresponds to which button the user pressed
        R_data: in unsigned(1 downto 0);--the value from sequence memory that corresponds to the correct button value from the sequence
        correct: out std_logic;--this is high if the the button pressed (btn_id) matches the correct button press stored in the generated sequence (indicated by R_data)
        seq_tc: out std_logic; --seq_tc goes high when the user completes the entire level's sequence
        win: out std_logic; --win goes high if the user completes the entire sequence of level 32
        eval_indx: out unsigned(4 downto 0);--this index goes to sequence memory and controls what the next R_data will be, so one can cycle through each levels sequence
        eval_done: out std_logic);--when evaluation is complete, this signal goes high, so the control can change states
end eval_seq;

architecture Behavioral of eval_seq is

    signal indx: integer := 0; --internal signal, so eval_indx can increment
    signal stop : std_logic; --internal signal so evaluation sequence only runs once
 

begin



  evaluation: process(clk,eval,btn_id,lvl,R_data)
  begin
   
   if rising_edge(clk) then
   
 
 
        if eval = '1' then --evaluation only happens when the controller is in evaluate state
                
            if stop = '0' then   
			--This was a fix to a problem that came up when connecting evaluate to the controller. The problem was initialy 
			--we needed to add an eval_done signal, or the controller would change states based on past/default seq_tc,win, correct
			--values. However, when we added eval_done, eval would stay high for two clock cyles, so evaluation process would run twice
			--consecetively, which is bad because the btn_id input is the same. So this internal stop signal ensure the evaluation process
			--only runs once, effectively acting like a toggler.
			
				win <= '0';
				seq_tc <= '0';
				indx <= 0;
				correct <= '0';
			
                if btn_id = R_data then --if user input is correct
                    if indx <  (to_integer(lvl))  then
                        indx <= indx + 1; --index only increments if the button press is correct and level is not fisnished
                    elsif lvl = "11111" then--level equals 32 (represented by 31 as levels 1-32 are represented by 0-31)
                        win <= '1';
                    else
                        seq_tc <= '1'; -- in this case the user has reached the last button in the sequence
                    end if;
                    correct <= '1';
                end if;
            
             eval_done <= '1';--evaluation finishes so eval_done goes high, so the controller switches states based on win,seq_tc, and correct values
             stop <= '1';
           end if;
       else
             eval_done <= '0';
             stop <= '0';
       end if;
  
  
     eval_indx <= to_unsigned(indx,5);
    
   
   end if;


  end process;
 

end Behavioral;