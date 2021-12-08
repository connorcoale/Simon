----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Connor Coale
-- 
-- Create Date: 08/21/2020 02:31:25 AM
-- Design Name: sequence generator
-- Module Name: sequence_generator - behavior
-- Project Name: Final Project - Simon Memory Game
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: This component contains the RNG and the interface which will connect
-- to the 32x2 memory file storing the game's sequence. It is used during the 
-- gen_sequence state.
-- Dependencies: - 'rng' as a component
-- 
-- Revision: 1: Had to create a small delay before starting to write stuff into the memory.
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

entity sequence_generator is
    Port ( gen : in STD_LOGIC;
           clk : in STD_LOGIC;
           rng_out : out STD_LOGIC;
           write_index_addr : out STD_LOGIC_VECTOR (4 downto 0);
           write_bit_addr : out STD_LOGIC;
           gen_sequence_tc : out STD_LOGIC);
end sequence_generator;

architecture behavior of sequence_generator is
    signal count: unsigned(5 downto 0) := (others => '0');
    
    signal delay_count: unsigned(3 downto 0) := (others => '0');
    signal delay_count_tc: std_logic;
    
    signal set_seed_mp: std_logic := '0';
    
    signal rng_out_connector: std_logic := '0';
    
    component rng is 
        port(clk: in std_logic;
             rst_rng: in std_logic;
             output: out std_logic );
    end component;
    
    
    component monopulser is
        port(clk: in std_logic;
             x: in std_logic;
             y: out std_logic);
    end component;
    
begin
    write_index_addr <= std_logic_vector(count(5 downto 1));
    write_bit_addr <= std_logic(count(0));
    rng_out <= rng_out_connector;

    random_bit: rng port map(
        clk => clk,
        rst_rng => set_seed_mp,
        output => rng_out_connector);
        
    -- This is used to monopulse the gen input in order to set the seed of the random number generator.
    -- It allows a pseudo-random process to be defined by a truly random user input, which is the time 
    -- it takes until the user presses start.  
    mp: monopulser port map(
        clk => clk,
        x => gen,
        y => set_seed_mp);
        
    -- Process for adding the bits to the sequence memory itself.
    sequence_population: process(clk, gen)
        begin
            if rising_edge(clk) then
                if gen = '1' then
                    if delay_count_tc = '0' then
                        delay_count <= delay_count + 1;
                    else delay_count <= delay_count;
                    end if;
                    if delay_count_tc = '1' then
                        count <= count + 1;
                    else count <= count;
                    end if;
                end if;
                
                delay_count_tc <= '0';
                if delay_count = "110" and gen = '1' then
                    delay_count_tc <= '1';
                end if;
                
                gen_sequence_tc <= '0';
                if count = "111111" and gen = '1' then
                    gen_sequence_tc <= '1';
                    count <= (others => '0');
                    delay_count <= (others => '0');
                end if;
                    
                end if;
            
    end process sequence_population;
    


end behavior;












