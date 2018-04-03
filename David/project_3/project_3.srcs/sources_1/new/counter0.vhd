----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2018 10:05:07 AM
-- Design Name: 
-- Module Name: counter0 - Behavioral
-- Project Name: 
-- Target Devices: 
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

entity counter0 is
    Port ( enable0 : in STD_LOGIC;
           enable1 : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           out : out STD_LOGIC_VECTOR (3 downto 0);
           terminalCount : out STD_LOGIC);
end counter0;

architecture Behavioral of counter0 is

begin


end Behavioral;
