----------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: Connor Coale
-- 
-- Create Date: 08/23/2020 12:34:52 AM
-- Design Name: sequence_memory
-- Module Name: sequence_memory - behavior
-- Project Name: Final Project
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: This component allows for the writing, storing, and reading
-- of a 32x2 bit array of randomly generated bits.
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

entity sequence_memory is
    Port ( clk : in STD_LOGIC;
           play_ctrl_signal : in STD_LOGIC;
           eval_index : in unsigned (4 downto 0);
           play_index : in unsigned (4 downto 0);
           W_data : in STD_LOGIC;
           W_EN : in STD_LOGIC;
           W_i_addr : in std_logic_vector (4 downto 0);
           W_b_addr : in STD_LOGIC;
           R_data : out unsigned (1 downto 0));
end sequence_memory;

architecture behavior of sequence_memory is

-- The actual storage for the sequence itself.
type regfile_type is 
    array(0 to 31) of std_logic_vector(1 downto 0);

signal sequence: regfile_type := (others => (others => '0'));

signal R_addr: unsigned(4 downto 0); 

-- I don't know how to access individual bits from within the array's std_logic_vectors,
-- so instead I load each set of two consecutive bits into this register.
signal two_bits_in: std_logic_vector(1 downto 0) := "00";
--signal two_bits_index: unsigned(0 downto 0);

-- MUX for choosing which address to use, depending on which state the controller is in.
begin
    Address_MUX: process(play_ctrl_signal, play_index, eval_index)
        begin
        if play_ctrl_signal = '1' then
            R_addr <= play_index;
        else
            R_addr <= eval_index;
        end if;
    end process Address_MUX;
    
    
    -- Because I don't know how to access an individual bit within the array in order to change its value,
    -- I'm instead using a 2bit register to track the last two W_data bits. Then when W_b_addr is high,
    -- indicating every second W_data bit, I am able to load that value into the 2bit vector in the array
    -- at index given by W_i_addr
    two_bits_gen: process(clk, W_b_addr, W_data)
        begin
            if rising_edge(clk) then
                  
                if W_b_addr = '0' then
                    two_bits_in(0) <= W_data;
                else
                    two_bits_in(1) <= W_data;
                end if;

                
            end if;
            
    end process two_bits_gen;
    
    RegFile: process(clk, R_addr, sequence)
        begin
        if rising_edge(clk) then
            if W_EN = '1' then 
                if W_b_addr = '1' then
                    sequence(to_integer(unsigned((W_i_addr)))) <= two_bits_in;
                    -- This is where I assign the stored 2 bits on every second W_data bit, as controlled
                    -- by the W_b_addr logic signal.
                end if;
            end if;

        end if;
        
        R_data <= unsigned(sequence(to_integer(R_addr)));
    end process RegFile;


end behavior;

