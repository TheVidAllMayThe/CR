----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2018 09:33:12 AM
-- Design Name: 
-- Module Name: LeftShifter2 - Behavioral
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

entity LeftShifter2 is
    port( dataIn : in std_logic_vector(31 downto 0);
          dataOut: out std_logic_vector(31 downto 0));
end LeftShifter2;

architecture Behavioral of LeftShifter2 is
begin
    dataOut <= dataIn(29 downto 0) & "00";
end Behavioral;
