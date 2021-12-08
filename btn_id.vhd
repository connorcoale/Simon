----------------------------------------------------------------------------------
-- Engineer: Connor Coale
-- 
-- Create Date: 08/24/2020 04:27:02 PM
-- Design Name: 
-- Module Name: btn_id - behavior
-- Project Name: Simon Memory Game
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Stores the value of the most recently pressed input button.
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

entity btn_id is
    Port ( clk : in std_logic;
           BTNU : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           allow_input: in std_logic;
           btn_id : out unsigned(1 downto 0));
end btn_id;

architecture behavior of btn_id is
    signal button_pressed: std_logic := '0';
    signal btn_id_reg: unsigned(1 downto 0); -- Internal register to store button id.
begin
    
    btn_id <= btn_id_reg; -- Actual connection to output.

    btn_action: process(clk, BTNU, BTNL, BTND, BTNR, allow_input)
        begin
        if rising_edge(clk) then
            if allow_input = '1' then -- don't want to allow the input button to change while in disp_input!
                if BTNU = '1' then
                    btn_id_reg <= "00";
                elsif BTNL = '1' then
                    btn_id_reg <= "01";
                elsif BTND = '1' then
                    btn_id_reg <= "10";
                elsif BTNR = '1' then
                    btn_id_reg <= "11";
                else btn_id_reg <= btn_id_reg;
                end if;
            else btn_id_reg <= btn_id_reg;
            end if;
        end if;
        
        
    end process btn_action;


end behavior;
