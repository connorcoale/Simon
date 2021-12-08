----------------------------------------------------------------------------------
-- Engineer: Connor Coale
-- 
-- Create Date: 08/24/2020 05:23:15 AM
-- Design Name: tone_player
-- Module Name: tone_player - behavior
-- Project Name: Final Project: Simon Memory game
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Tone generator using inputs from either play_sequence or btn presses.
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tone_player is
    Port ( clk : in STD_LOGIC;
           play_ctrl_signal : in STD_LOGIC;
           play_seq_EN : in STD_LOGIC;
           play_btn_EN : in STD_LOGIC;
           play_seq_tone : in unsigned (1 downto 0);
           play_btn_tone : in unsigned (1 downto 0);
           audio_out : out std_logic);
end tone_player;

architecture behavior of tone_player is
    signal tone_EN: std_logic;
    signal tone_id: unsigned(1 downto 0);
    signal tone: std_logic;
   
-------------------------------------------------------------------- 
    constant UP_DIV_VAL: integer := 1136;
    signal up_clk: std_logic := '0';
    signal up_clkdiv: unsigned(11 downto 0) := (others => '0');
    
    constant LEFT_DIV_VAL: integer := 3030;
    signal left_clk: std_logic := '0';
    signal left_clkdiv: unsigned(11 downto 0) := (others => '0');
    
    constant DOWN_DIV_VAL: integer := 1805;
    signal down_clk: std_logic := '0';
    signal down_clkdiv: unsigned(11 downto 0) := (others => '0');
    
    constant RIGHT_DIV_VAL: integer := 1515;
    signal right_clk: std_logic := '0';
    signal right_clkdiv: unsigned(11 downto 0) := (others => '0');
--------------------------------------------------------------------
begin

    audio_gen: process(clk, tone, tone_EN)
        begin
        if rising_edge(clk) then
            audio_out <= '0';
            if tone_EN = '1' then
                audio_out <= tone;
            end if;
        end if;
        
    end process audio_gen;
    
    -- mux for which tone gets streamed to to the output.
    tones_mux: process(clk, tone_ID, up_clk, left_clk, down_clk, right_clk)
        begin
        if rising_edge(clk) then
            case tone_ID is 
                when "00" => tone <= up_clk;
                when "01" => tone <= left_clk;
                when "10" => tone <= down_clk;
                when "11" => tone <= right_clk;
                when others => tone <= '0';
            end case;
        end if;
    end process tones_MUX;

    inputs_MUX: process(clk, play_ctrl_signal, play_seq_EN, play_btn_EN, play_seq_tone, play_btn_tone)
        begin
        if rising_edge(clk) then
            if play_ctrl_signal = '1' then
                tone_EN <= play_seq_EN;
                tone_ID <= play_seq_tone;
            else 
                tone_EN <= play_btn_EN;
                tone_ID <= play_btn_tone;
            end if;
        end if;
        
    end process inputs_MUX;
    
    -- All the individual clock dividers for each possible tone.
    clock_divider: process(clk)
        begin
        if rising_edge(clk) then
            if up_clkdiv = UP_DIV_VAL-1 then
                up_clk <= not(up_clk);
                up_clkdiv <= (others => '0');
            else up_clkdiv <= up_clkdiv + 1;
            end if;
            
            if left_clkdiv = LEFT_DIV_VAL-1 then
                left_clk <= not(left_clk);
                left_clkdiv <= (others => '0');
            else left_clkdiv <= left_clkdiv + 1;
            end if;
            
            if down_clkdiv = DOWN_DIV_VAL-1 then
                down_clk <= not(down_clk);
                down_clkdiv <= (others => '0');
            else down_clkdiv <= down_clkdiv + 1;
            end if;
            
            if right_clkdiv = RIGHT_DIV_VAL-1 then
                right_clk <= not(right_clk);
                right_clkdiv <= (others => '0');
            else right_clkdiv <= right_clkdiv + 1;
            end if;
        end if;
    end process clock_divider;


    

end behavior;




