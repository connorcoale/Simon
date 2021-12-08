----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Noah Daniel and Connor Coale
-- 
-- Create Date: 08/22/2020 01:24:32 AM
-- Design Name: 
-- Module Name: controller - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity controller is
        port( clk : in std_logic;
         start_reset, gen_done,countdown_tc,play_done,button_pressed,correct,seq_tc,win, eval_done,waitcount_tc : in std_logic;
         reset,gen,countdown,play, allow_input, disp_input,eval,inc_lvl, waitcount : out std_logic );
end controller;

architecture behavior of controller is
    type state_type is (idle,gen_seq,counting,play_seq,wait_press,play_input,evaluate,increase_lvl,show_score,won, wait_to_play);
    signal curr_state, next_state : state_type;
    
    
    signal disp_counter: integer := 0;
    --for testing purposes, divide this by 10.
    --signal disp_counter_lim: integer := 33333;
    signal disp_counter_lim: integer := 333333; --based on 1 MHz masterc clock, so it is displayedfor 1 /3 second
    signal disp_counter_tc: std_logic := '0';
    signal disp_counter_EN: std_logic := '0';
    
    begin
    
    
 displayCounter: process(clk,disp_counter_EN) --counter so users input is displayed
 begin
    if rising_edge(clk) then
        if disp_counter = disp_counter_lim then
            disp_counter_tc <= '1';
            disp_counter <= 0;
        elsif disp_counter_EN = '1' then
            disp_counter <= disp_counter+1; 
            disp_counter_tc <= '0';   
        end if;
    end if;
 end process displayCounter;


-- State update logic
StateUpdateLogic: process(clk)
begin
    if rising_edge(clk) then
        curr_state <= next_state;
    end if;
end process StateUpdateLogic;
-- Next state and output logic. The meat behind the FSM
CombinationalLogic: process( curr_state, start_reset, gen_done,countdown_tc,play_done,button_pressed,correct,seq_tc,win,disp_counter_tc,eval_done, waitcount_tc )
begin
    next_state <= curr_state; -- defaults

    reset <= '0';
    gen <= '0';
    countdown <= '0';
    play <= '0';
    allow_input <= '0';
    disp_input <= '0';
    eval <= '0';
    inc_lvl <= '0';
    disp_counter_EN <= '0';
    waitcount <= '0';


    case curr_state is
    when idle => reset <= '1';
        if start_reset = '1' then
        next_state <= gen_seq;
        end if;
    when gen_seq => gen <= '1';
        if gen_done='1' then
            next_state <= counting;
        end if;
    when counting => countdown <= '1';
        if countdown_tc='1' then
            next_state <= play_seq;
        end if;
    when play_seq => play <= '1';
        if play_done='1' then
            next_state <= wait_press;
        end if;
    when wait_press => allow_input <= '1';
        if button_pressed='1' then
            next_state <= play_input;
        end if;
    when play_input => 
            disp_input <= '1';
            disp_counter_EN <= '1';
            if disp_counter_tc = '1' then
                next_state <= evaluate;
            end if;
    when evaluate => eval <= '1';
        if eval_done = '1' then
            if win='1' then
                next_state <= won; 
            elsif correct ='1' and seq_tc='0' then
                next_state <= wait_press;
            elsif correct ='1' and seq_tc='1' then
                next_state <= increase_lvl;
            elsif correct = '0' then 
                next_state <= show_score;
            end if;
        end if;
    when increase_lvl => inc_lvl <= '1';
            next_state <= wait_to_play;
    when wait_to_play => waitcount <= '1';
        if waitcount_tc = '1' then
            next_state <= play_seq;
        end if;
    when won =>
        if start_reset='1' then
            next_state <= idle;
        end if;
    when show_score =>
        if start_reset='1' then
            next_state <= idle;
        end if;
    end case;
end process CombinationalLogic;

end behavior;
