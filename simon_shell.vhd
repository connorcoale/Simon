----------------------------------------------------------------------------------
-- Engineer: Connor Coale, Noah Daniel
-- 
-- Create Date: 08/24/2020 10:33:37 PM
-- Design Name: Simon Shell
-- Module Name: simon_shell - behavior
-- Project Name: Simon Memory Game
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Top level shell for Simon Memory Game
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
use ieee.math_real.all; -- needed for automatic register sizing
library UNISIM; -- needed for the BUFG component
use UNISIM.Vcomponents.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simon_shell is
    Port ( mclk : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNR : in STD_LOGIC;
--           --LA outputs
--           BTNC_DB_LA: OUT STD_LOGIC;
--           BTNU_DB_LA: OUT STD_LOGIC;
--           BTNL_DB_LA: OUT STD_LOGIC;
--           BTND_DB_LA: OUT STD_LOGIC;
--           BTNR_DB_LA: OUT STD_LOGIC;
           
--           gen_connector_LA: out std_logic;
--           reset_connector_LA: out std_logic;
--           countdown_connector_LA: out std_logic;
--           play_connector_LA: out std_logic;
--           disp_input_connector_LA: out std_logic;
--           correct_connector_LA: out std_logic;
           
--           P1_LA: out std_logic;
--           P2_LA: out std_logic;
--           P3_LA: out std_logic;
--           P4_LA: out std_logic;
--           ------------
           audio_out : out STD_LOGIC;
           P1 : out STD_LOGIC;
           P2 : out STD_LOGIC;
           P3 : out STD_LOGIC;
           P4 : out STD_LOGIC;
           seg7_cat : out STD_LOGIC_VECTOR (0 to 6);
           seg7_an : out STD_LOGIC_VECTOR (3 downto 0);
           seg7_dp : out STD_LOGIC);
end simon_shell;

architecture behavior of simon_shell is

SIGNAL BTNC_INV: STD_LOGIC;
SIGNAL BTNU_INV: STD_LOGIC;
SIGNAL BTNL_INV: STD_LOGIC;
SIGNAL BTND_INV: STD_LOGIC;
SIGNAL BTNR_INV: STD_LOGIC;

signal P1_connector: std_logic := '0';
signal P2_connector: std_logic := '0';
signal P3_connector: std_logic := '0';
signal P4_connector: std_logic := '0';

----LA SIGNALS--
--SIGNAL P1_LA: STD_LOGIC;
--SIGNAL P2_LA: STD_LOGIC;
--SIGNAL P3_LA: STD_LOGIC;
--SIGNAL P4_LA: STD_LOGIC;
--SIGNAL AUDIO_OUT_LA: STD_LOGIC;

----------------

-- DEBOUNCERS ------------------------------------------
-- DEBOUNCED BUTTONS: ----------------------------------
signal BTNC_DB: std_logic;
signal BTNU_DB: std_logic;
signal BTNL_DB: std_logic;
signal BTND_DB: std_logic;
signal BTNR_DB: std_logic;

component debouncer is
    port( clk: in std_logic;
          button: in std_logic;
          button_db: out std_logic);
end component;
--------------------------------------------------------

-- MONOPULSERS -----------------------------------------
-- MONOPULSED BUTTONS: ---------------------------------
signal BTNC_DB_MP: std_logic;
signal BTNU_DB_MP: std_logic;
signal BTNL_DB_MP: std_logic;
signal BTND_DB_MP: std_logic;
signal BTNR_DB_MP: std_logic;

component monopulser is 
    port( clk: in std_logic;
          x: in std_logic;
          y: out std_logic);
end component;
--------------------------------------------------------

-- CONTROLLER ------------------------------------------
-- CONTROLLER SIGNALS: ---------------------------------
-- clk => gclk
-- start_reset => BTNC_DB_MP
signal gen_done_connector: std_logic; -- gen_done => gen_done_connector
signal countdown_tc_connector: std_logic; -- countdown_tc => countdown_tc_connector
signal play_done_connector: std_logic; -- play_done => play_done_connector
signal button_pressed: std_logic; -- button_pressed => button_pressed. Need to have a glue OR for this!
signal correct_connector: std_logic; -- correct => correct_connector
signal seq_tc_connector: std_logic; -- seq_tc => seq_tc_connector
signal win_connector: std_logic; -- win => win_connector
-- eval_done => eval_done_connector
signal waitcount_tc_connector: std_logic; -- waitcount_tc => waitcount_tc_connector
signal reset_connector: std_logic; -- reset => reset_connector
signal gen_connector: std_logic; -- gen => gen_connector
signal countdown_connector: std_logic; -- countdown => countdown_connector
signal play_connector: std_logic; -- play => play_connector
signal allow_input_connector: std_logic;
signal disp_input_connector: std_logic; -- disp_input => disp_input_connector
signal eval_connector: std_logic; -- eval => eval_connector
signal inc_lvl_connector: std_logic; -- inc_lvl => inc_lvl_connector
signal waitcount_connector: std_logic;

component controller is
    port(clk : in std_logic;
         start_reset, gen_done,countdown_tc,play_done,button_pressed,correct,seq_tc,win,eval_done, waitcount_tc : in std_logic;
         reset,gen,countdown,play,allow_input,disp_input,eval,inc_lvl, waitcount : out std_logic );
end component;
---------------------------------------------------------

-- BTN_ID -----------------------------------------------
-- BTN_ID SIGNALS ---------------------------------------
-- CLK => GCLK
-- BTNU => BTNU_DB_MP
-- BTNL => BTNL_DB_MP
-- BTND => BTND_DB_MP
-- BTNR => BTNR_DB_MP
-- allow_input => allow_input_connector
signal btn_id_connector: unsigned(1 downto 0);

component btn_id is 
    port( clk : in std_logic;
          BTNU : in STD_LOGIC;
          BTNL : in STD_LOGIC;
          BTND : in STD_LOGIC;
          BTNR : in STD_LOGIC;
          allow_input : in std_logic;
          btn_id : out unsigned(1 downto 0));
end component;
---------------------------------------------------------

-- LEVEL ------------------------------------------------
-- LEVEL SIGNALS ----------------------------------------
-- clk => gclk
-- inc_level => inc_level_connector
-- reset => reset_connector
signal lvl_connector: unsigned(4 downto 0);

component level is
    port( clk: in std_logic;
        inc_lvl: in std_logic;
        reset: in std_logic;
        lvl: out unsigned(4 downto 0));
end component;
---------------------------------------------------------

-- COUNTDOWN --------------------------------------------
-- COUNTDOWN SIGNALS ------------------------------------
-- clk => gclk
-- countdown => countdown_connector
-- countdown_tc => countdown_tc_connector

component countdown is 
    port(clk : in std_logic;
         countdown : in std_logic;
         countdown_tc : out std_logic);
end component;
---------------------------------------------------------

-- SEQUENCE GENERATOR -----------------------------------
-- SEQUENCE GENERATOR SIGNALS ---------------------------
-- gen => gen_connector
-- clk => gclk
signal rng_out_connector: std_logic; -- rng_out => rng_out_connector
signal write_index_addr_connector: std_logic_vector(4 downto 0); -- [] => []_connector
signal write_bit_addr_connector: std_logic; -- [] => []_connector
-- gen_sequence_tc => gen_done_connector

component sequence_generator is 
    port( gen : in STD_LOGIC;
          clk : in STD_LOGIC;
          rng_out : out STD_LOGIC;
          write_index_addr : out STD_LOGIC_VECTOR (4 downto 0);
          write_bit_addr : out STD_LOGIC;
          gen_sequence_tc : out STD_LOGIC);
end component;
----------------------------------------------------------

-- SEQUENCE MEMORY ---------------------------------------
-- SEQUENCE MEMORY SIGNALS -------------------------------
-- clk => gclk
-- play_ctrl_signal => play_connector
signal eval_index_connector: unsigned(4 downto 0); -- [] => []_connector
signal play_index_connector: unsigned(4 downto 0); -- [] => []_connector
-- W_data => rng_out_connector
-- W_EN => gen_connector
-- W_i_addr => write_index_addr_connector
-- W_b_addr => write_bit_addr_connector
signal R_data_connector: unsigned(1 downto 0); -- [] => []_connector

component sequence_memory is
    port( clk : in STD_LOGIC;
          play_ctrl_signal : in STD_LOGIC;
          eval_index : in unsigned (4 downto 0);
          play_index : in unsigned (4 downto 0);
          W_data : in STD_LOGIC;
          W_EN : in STD_LOGIC;
          W_i_addr : in std_logic_vector (4 downto 0);
          W_b_addr : in STD_LOGIC;
          R_data : out unsigned (1 downto 0));
end component;
-----------------------------------------------------------

-- PLAY SEQUENCE ------------------------------------------
-- PLAY SEQUENCE SIGNALS ----------------------------------
-- clk => gclk
-- level => lvl_connector
-- play => play_connector
signal play_seq_EN_connector: std_logic; -- tone_EN => play_seq_EN_connector
-- play_done => play_done_connector
signal play_seq_id_connector: unsigned(4 downto 0); -- tone_id_index => play_seq_id_connector

component play_sequence is
    port( clk : in STD_LOGIC;
          level : in unsigned (4 downto 0);
          play : in STD_LOGIC;
          tone_EN : out STD_LOGIC;
          play_done : out STD_LOGIC;
          tone_id_index : out unsigned (4 downto 0));
end component;
------------------------------------------------------------

-- WAIT TO PLAY --------------------------------------------
-- SIGNALS -------------------------------------------------
-- clk => gclk
-- waitcount => waitcount_connector
-- waitcount_tc => waitcount_tc_connector
component wait_to_play is
    port( clk : in std_logic;
          waitcount : in std_logic;
          waitcount_tc : out std_logic );
end component;
------------------------------------------------------------

-- TONE PLAYER ---------------------------------------------
-- TONE PLAYER SIGNALS -------------------------------------
-- clk => gclk
-- play_ctrl_signal => play_connector
-- play_seq_EN => play_seq_EN_connector
-- play_btn_EN => disp_input_connector
-- play_seq_tone => R_data_connector
-- play_btn_tone => btn_id_connector
-- audio_out => audio_out

component tone_player is 
    port( clk : in STD_LOGIC;
          play_ctrl_signal : in STD_LOGIC;
          play_seq_EN : in STD_LOGIC;
          play_btn_EN : in STD_LOGIC;
          play_seq_tone : in unsigned (1 downto 0);
          play_btn_tone : in unsigned (1 downto 0);
          audio_out : out std_logic);
end component;
-------------------------------------------------------------

-- LED OUTPUT -----------------------------------------------
-- LED OUTPUT SIGNALS ---------------------------------------
-- clk => gclk
-- btn_id => btn_id_connector
-- Rdata => R_data_connector
-- play => play_connector
-- disp_input => disp_input_connector
-- P1 => P1, P2 => P2, etc

component LED_output is 
    port( clk: in std_logic;
          btn_id: in unsigned(1 downto 0);
          Rdata: in unsigned(1 downto 0);
          play: in std_logic;
          disp_input: in std_logic;
          play_led_EN: in std_logic;
          P1: out std_logic;
          P2: out std_logic;
          P3: out std_logic;
          P4: out std_logic);
end component;
--------------------------------------------------------------

-- EVAL SEQUENCE ---------------------------------------------
-- clk => gclk
-- lvl => lvl_connector
-- eval => eval_connector
-- btn_id => btn_id_connector
-- R_data => R_data_connector
-- correct => correct_connector
-- seq_tc => seq_tc_connector
-- win => win_connector
-- eval_indx => eval_index_connector
signal eval_done_connector: std_logic;

component eval_seq is 
    port( clk: IN std_logic;
        lvl: in unsigned(4 downto 0);
        eval: in std_logic;
        btn_id: in unsigned(1 downto 0);
        R_data: in unsigned(1 downto 0);
        correct: out std_logic;
        seq_tc: out std_logic;
        win: out std_logic;
        eval_indx: out unsigned(4 downto 0);
        eval_done: out std_logic);
end component;
------------------------------------------------------------

-- SCORETODISP ---------------------------------------------
-- SIGNALS -------------------------------------------------
-- clk => gclk
-- lvl => lvl_connector
-- countdown => countdown_connector
signal y0_connector: unsigned(3 downto 0); -- [] => []_connector
signal y1_connector: unsigned(3 downto 0); -- [] => []_connector

component scoreToDisp is 
    port( clk: in std_logic;
          lvl: in unsigned(4 downto 0);
          y0: out unsigned(3 downto 0);
          y1: out unsigned(3 downto 0));
end component;
-------------------------------------------------------------

-- MUX 7 SEGMENT --------------------------------------------
-- SIGNALS --------------------------------------------------
-- clk => gclk
-- y0, y1 => y0_connector, y1_connector BUT NOTE THAT THESE NEED TO BE CONVERTED TO
-- STD_LOGIC_VECTOR AS THEY'RE CURRENTLY UNSIGNEDS!!!
-- y2, y3 => "0000"
-- dp_set => "1111" in order to not have any decimal points. (low true).
-- seg => 7seg_cat
-- dp => 7seg_dp
-- an => 7seg_an

component mux7seg is
    port( clk : in  STD_LOGIC; -- runs on a fast (1 MHz or so) clock
          y0, y1, y2, y3 : in  STD_LOGIC_VECTOR (3 downto 0); -- digits
          dp_set : in std_logic_vector(3 downto 0);            -- decimal points
          seg : out  STD_LOGIC_VECTOR(0 to 6);    -- segments (a...g)
          dp : out std_logic;
          an : out  STD_LOGIC_VECTOR (3 downto 0) );      -- anodes
end component;
--------------------------------------------------------------
----CLOCK DIVIDER SIGNALS------------
-- Signals for the serial clock divider, which divides the 100 MHz clock down to 1 MHz
constant GCLK_DIVIDER_VALUE: integer := 100 / 2;
constant COUNT_LEN: integer := integer(ceil( log2( real(GCLK_DIVIDER_VALUE) ) ));
signal gclkdiv: unsigned(COUNT_LEN-1 downto 0) := (others => '0'); -- clock divider
signal gclk_unbuf: std_logic := '0'; -- unbuffered serial clock
signal gclk: std_logic := '0'; -- internal serial clock


begin

---SERIAL CLOCK DIVIDER----------------------------------
-- Clock buffer for sclk
-- The BUFG component puts the signal onto the FPGA clocking network
Slow_clock_buffer: BUFG
    port map (I => gclk_unbuf,
    O => gclk );
-- Divide the 100 MHz clock down to 2 MHz, then toggling a flip flop gives the final
-- 1 MHz system clock
Serial_clock_divider: process(mclk)
begin
    if rising_edge(mclk) then
        if gclkdiv = GCLK_DIVIDER_VALUE-1 then
            gclkdiv <= (others => '0');
            gclk_unbuf <= NOT(gclk_unbuf);
        else
            gclkdiv <= gclkdiv + 1;
        end if;
        end if;
end process Serial_clock_divider;


-- GLUE LOGIC ------------------------------------------------
    process(gclk, BTNU_DB_MP, BTNL_DB_MP, BTND_DB_MP, BTNR_DB_MP)
        begin
            
            if rising_edge(gclk) then
                button_pressed <= BTNU_DB_MP OR BTNL_DB_MP OR BTND_DB_MP OR BTNR_DB_MP;
            end if;
    end process;
--------------------------------------------------------------

simon_controller: controller port map(
    clk => gclk,
    start_reset => BTNC_DB_MP,
    gen_done => gen_done_connector,
    countdown_tc => countdown_tc_connector,
    play_done => play_done_connector,
    button_pressed => button_pressed,
    correct => correct_connector,
    seq_tc => seq_tc_connector,
    win => win_connector,
    eval_done => eval_done_connector,
    waitcount_tc => waitcount_tc_connector,
    reset => reset_connector,
    gen => gen_connector,
    countdown => countdown_connector,
    play => play_connector,
    allow_input => allow_input_connector,
    disp_input => disp_input_connector,
    eval => eval_connector,
    inc_lvl => inc_lvl_connector,
    waitcount => waitcount_connector);
simon_button_id: btn_id port map(
    clk => gclk,
    BTNU => BTNU_DB_MP,
    BTNL => BTNL_DB_MP,
    BTND => BTND_DB_MP,
    BTNR => BTNR_DB_MP,
    allow_input => allow_input_connector,
    btn_id => btn_id_connector);
simon_level: level port map(
    clk => gclk,
    inc_lvl => inc_lvl_connector,
    reset => reset_connector,
    lvl => lvl_connector);
simon_countdown: countdown port map(
    clk => gclk,
    countdown => countdown_connector,
    countdown_tc => countdown_tc_connector);
simon_wait_to_play: wait_to_play port map(
    clk => gclk,
    waitcount => waitcount_connector,
    waitcount_tc => waitcount_tc_connector);
simon_sequence_generator: sequence_generator port map(
    gen => gen_connector,
    clk => gclk,
    rng_out => rng_out_connector,
    write_index_addr => write_index_addr_connector,
    write_bit_addr => write_bit_addr_connector,
    gen_sequence_tc => gen_done_connector);
simon_sequence_memory: sequence_memory port map(
    clk => gclk,
    play_ctrl_signal => play_connector,
    eval_index => eval_index_connector,
    --play_index => play_index_connector,
    play_index => play_seq_id_connector,
    W_data => rng_out_connector,
    W_EN => gen_connector,
    W_i_addr => write_index_addr_connector,
    W_b_addr => write_bit_addr_connector,
    R_data => R_data_connector);
    --R_data => empty);
simon_play_sequence: play_sequence port map(
    clk => gclk,
    level => lvl_connector,
    play => play_connector,
    tone_EN => play_seq_EN_connector,
    play_done => play_done_connector,
    tone_id_index => play_seq_id_connector);
simon_tone_player: tone_player port map(
    clk => gclk,
    play_ctrl_signal => play_connector,
    play_seq_EN => play_seq_EN_connector,
    play_btn_EN => disp_input_connector,
    play_seq_tone => R_data_connector,
    play_btn_tone => btn_id_connector,
    audio_out => audio_out);
simon_LED_output: LED_output port map(
    clk => gclk,
    btn_id => btn_id_connector,
    Rdata => R_data_connector,
    play => play_connector,
    disp_input => disp_input_connector,
    play_led_EN => play_seq_EN_connector,
    P1 => P1_connector,
    P2 => P2_connector,
    P3 => P3_connector,
    P4 => P4_connector);
simon_eval_seq: eval_seq port map(
    clk => gclk,
    lvl => lvl_connector,
    eval => eval_connector,
    btn_id => btn_id_connector,
    R_data => R_data_connector,
    correct => correct_connector,
    seq_tc => seq_tc_connector,
    win => win_connector,
    eval_indx => eval_index_connector,
    eval_done => eval_done_connector);
simon_score2disp: scoreToDisp port map(
    clk => gclk,
    lvl => lvl_connector,
    y0 => y0_connector,
    y1 => y1_connector);
simon_mux7seg: mux7seg port map(
    clk => gclk,
    y0 => std_logic_vector(y0_connector),
    y1 => std_logic_vector(y1_connector),
    y2 => "0000",
    y3 => "0000",
    dp_set => "0000",
    seg => seg7_cat,
    dp => seg7_dp,
    an => seg7_an);
    

    BTNC_INV <= not(BTNC);
    BTNU_INV <= NOT(BTNU);
    BTNL_INV <= NOT(BTNL);
    BTND_INV <= NOT(BTND);
    BTNR_INV <= NOT(BTNR);
    
    P1 <= P1_connector;
    P2 <= P2_connector;
    P3 <= P3_connector;
    P4 <= P4_connector;


-- DEBOUNCERS -------------------------------------------------
BTNC_debouncer: debouncer port map(
    clk => gclk,
    button => BTNC_INV,
    button_db => BTNC_DB);    
BTNU_debouncer: debouncer port map(
    clk => gclk,
    button => BTNU_INV,
    button_db => BTNU_DB);    
BTNL_debouncer: debouncer port map(
    clk => gclk,
    button => BTNL_INV,
    button_db => BTNL_DB);    
BTND_debouncer: debouncer port map(
    clk => gclk,
    button => BTND_INV,
    button_db => BTND_DB);    
BTNR_debouncer: debouncer port map(
    clk => gclk,
    button => BTNR_INV,
    button_db => BTNR_DB);
-- MONOPULSERS ------------------------------------------------
BTNC_monopulser: monopulser port map(
    clk => gclk,
    x => BTNC_DB,
    Y => BTNC_DB_MP);    
BTNU_monopulser: monopulser port map(
    clk => gclk,
    x => BTNU_DB,
    Y => BTNU_DB_MP);    
BTNL_monopulser: monopulser port map(
    clk => gclk,
    x => BTNL_DB,
    Y => BTNL_DB_MP);    
BTND_monopulser: monopulser port map(
    clk => gclk,
    x => BTND_DB,
    Y => BTND_DB_MP);
BTNR_monopulser: monopulser port map(
    clk => gclk,
    x => BTNR_DB,
    Y => BTNR_DB_MP);
---------------------------------------------------------------

-- Signal assignments for debugging purposes.
--LA: process(mclk, BTNC_DB, BTNU_DB, BTNL_DB, BTND_DB, BTNR_DB, gen_connector, reset_connector, countdown_connector, play_connector, correct_connector, disp_input_connector, P1_connector, P2_connector, P3_connector, P4_connector)
--    begin
--        if rising_edge(mclk) then
--            BTNC_DB_LA <= BTNC_DB;
--            BTNU_DB_LA <= BTNU_DB;
--            BTNL_DB_LA <= BTNL_DB;
--            BTND_DB_LA <= BTND_DB;
--            BTNR_DB_LA <= BTNR_DB;
--            gen_connector_LA <= gen_connector;
--            reset_connector_LA <= reset_connector;
--            countdown_connector_LA <= countdown_connector;
--            play_connector_LA <= play_connector;
--            disp_input_connector_LA <= disp_input_connector;
--            correct_connector_LA <= correct_connector;
--            P1_LA <= P1_connector;
--            P2_LA <= P2_connector;
--            P3_LA <= P3_connector;
--            P4_LA <= P4_connector;
            
            
--        end if;
--end process LA;

end behavior;
