----------------------------------------------------------------------------------
-- Engineer: Connor Coale
-- 
-- Create Date: 08/24/2020 12:51:24 AM
-- Design Name: 
-- Module Name: play_sequence - behavior
-- Project Name: Simon Memory game
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: During the play control state, it sends the correct R_addr signals to 
-- the sequence memory
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

entity play_sequence is
    Port ( clk : in STD_LOGIC;
           level : in unsigned (4 downto 0);
           play : in STD_LOGIC;
           tone_EN : out STD_LOGIC;
           play_done : out STD_LOGIC;
           tone_id_index : out unsigned (4 downto 0));
end play_sequence;

architecture behavior of play_sequence is
    
    --USE A SMALLER DIV VAL IN ORDER TO TRY TO MAKE IT EASIER TO DEBUG
    --constant CLK_DIV_VAL: integer := 33333;
    constant CLK_DIV_VAL: integer := 333333;
    signal clkdiv: unsigned(19 downto 0) := (others => '0');
    signal tclk: std_logic := '0';
    signal tclk_mp: std_logic := '0';
    signal tclk_inv: std_logic;
    signal tclk_en: std_logic := '0';
    
    signal play_mp: std_logic := '0';
    
    component monopulser is
        port(clk: in std_logic;
             x: in std_logic;
             y: out std_logic);
    end component;
    
    signal R_addr: unsigned(4 downto 0) := (others => '0');

begin
    tclk_inv <= not(tclk);
    tone_id_index <= R_addr;
    
    
    R_addr_counter: process(clk, tclk_mp, play, R_addr, level)
    begin
        
        if rising_edge(clk) then
            
            if play = '1' then 
                if tclk_mp = '1' then
                    R_addr <= R_addr + 1;
                end if;
            end if;
        end if;
        
        play_done <= '0';
        if R_addr = level + 1 then
            play_done <= '1';
           
        end if;
        
        if play = '0' then
             R_addr <= "00000";
        end if;
        
    end process R_addr_counter;
    
    -- Creates a 2/3 Hz clock cycle in order to have a 50% duty cycle with it on for 1/3 second.
    tone_EN_proc: process(tclk, play)
    begin
        tone_EN <= '0';
        
        if play = '1' then
            tone_EN <= tclk;
        end if;
    end process tone_EN_proc;
    
   

    clock_divider: process(clk)
    begin
        if rising_edge(clk) then
            if play = '1' then
                if clkdiv = CLK_DIV_VAL-1 then
                    tclk <= not(tclk);
                    clkdiv <= (others => '0');
                else clkdiv <= clkdiv + 1;
                end if;
            end if;
            if play_mp = '1' then
            tclk <= '1';
                clkdiv <= (others => '0');
            end if;
        end if;
    end process clock_divider;
    
    mp_play: monopulser port map(
        clk => clk,
        x => play,
        y => play_mp);
        
    mp_tclk: monopulser port map(
        clk => clk,
        x => tclk_inv,
        y => tclk_mp);
    
end behavior;
