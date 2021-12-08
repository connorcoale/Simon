----------------------------------------------------------------------------------
-- Engineer: Connor Coale, Noah Daniel
-- 
-- Create Date: 08/25/2020 08:20:52 PM
-- Design Name: 
-- Module Name: simon_shell_tb - Behavioral
-- Project Name: Simon Memory Game
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for runthrough. All cycle times are cut in order to 
-- meet simulation timing.
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

entity simon_shell_tb is
--  Port ( );
end simon_shell_tb;

architecture Behavioral of simon_shell_tb is
    -- Clock signals and constants
    signal mclk: std_logic := '0';
    constant mclk_period: time := 10 ns;
    
    -- Port map signals

    
    -- Simon Shell
    --clk

    signal BTNC: std_logic;
    signal BTNU: std_logic;
    signal BTNL: std_logic;
    signal BTND: std_logic;
    signal BTNR: std_logic;
    signal audio_out: std_logic;
    signal P1: std_logic;
    signal P2: std_logic;
    signal P3: std_logic;
    signal P4: std_logic;
    signal seg7_cat :  STD_LOGIC_VECTOR (0 to 6);
    signal seg7_an :  STD_LOGIC_VECTOR (3 downto 0);
    signal seg7_dp :  STD_LOGIC;
    
    component simon_shell is 
    Port ( mclk : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           audio_out : out STD_LOGIC;
           P1 : out STD_LOGIC;
           P2 : out STD_LOGIC;
           P3 : out STD_LOGIC;
           P4 : out STD_LOGIC;
           seg7_cat : out STD_LOGIC_VECTOR (0 to 6);
           seg7_an : out STD_LOGIC_VECTOR (3 downto 0);
           seg7_dp : out STD_LOGIC);
    end component;
    
 

begin

    
    uut: simon_shell port map(
            mclk => mclk,
            BTNC => BTNC,
            BTNU => BTNU,
            BTNL => BTNL,
            BTND => BTND,
            BTNR => BTNR,
            audio_out => audio_out,
            P1 => P1,
            P2 => P2,
            P3 => P3,
            P4 => P4,
            seg7_cat => seg7_cat,
            seg7_an => seg7_an,
            seg7_dp => seg7_dp);


    clkgen: process
        begin
            mclk <= not(mclk);
            wait for mclk_period/2;
    end process clkgen;
    
    stim_proc: process
        begin

        wait for 8*mclk_period;
        BTNC <= '1'; --PRESS START RESET
        wait for 6000*mclk_period;
        BTNC <= '0';
        --wait for 150*mclk_period; --WAIT FOR SEQ GENERATION AND PLAY TONES --shortened countdown and tone time
        wait for 70 ms;
        
          BTNL <= '1';
          wait for 6000*mclk_period;
          BTNL <= '0';
          
          wait for 33533us; -- length of button press tone, plus some leeway
          
          wait for 3*33333us; -- length of play_seq at level 01 (= lvl2)
          
          wait for 500us; -- little bit of leeway again
          
          -- CORRECT BUTTON PRESS
          BTNL <= '1';
          wait for 6000*mclk_period;
          BTNL <= '0';
          wait for 33533us; -- length of button press tone, plus some leeway
          
          -- WRONG BUTTON PRESS, SHOULD MOVE INTO SHOW_SCORE
          BTNL <= '1';
          wait for 6000*mclk_period;
          BTNL <= '0';
          
          
          
--        BTNR <= '1';
--        wait for 1*mclk_period;
--        BTNR <= '0';
--        wait for 20*mclk_period;
        
--        wait for 100*mclk_period;
        
--        BTNR <= '1';
--        wait for 1*mclk_period;
--        BTNR <= '0';
--        wait for 20*mclk_period;
--        BTND <= '1';
--        wait for 1*mclk_period;
--        BTND <= '0';
--        wait for 20*mclk_period;
        
        
 
        
        wait;
    end process stim_proc;
end Behavioral;