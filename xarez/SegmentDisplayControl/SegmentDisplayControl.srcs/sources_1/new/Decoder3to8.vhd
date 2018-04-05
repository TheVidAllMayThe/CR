library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity Decoder3to8 is
    Port ( input : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder3to8;
 
architecture Behavioral of Decoder3to8 is
   
begin
    process(input)
    begin
        case input is
            when "000" => output <= "11111110";
            when "001" => output <= "11111101";
            when "010" => output <= "11111011";
            when "011" => output <= "11110111";
            when "100" => output <= "11101111";
            when "101" => output <= "11011111";
            when "110" => output <= "10111111";
            when "111" => output <= "01111111";
        end case;
    end process;
end Behavioral;