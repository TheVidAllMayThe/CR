

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
            when "000" => output <= "00000001";
            when "001" => output <= "00000010";
            when "010" => output <= "00000100";
            when "011" => output <= "00001000";
            when "100" => output <= "00010000";
            when "101" => output <= "00100000";
            when "110" => output <= "01000000";
            when "111" => output <= "10000000";
        end case;
    end process;
end Behavioral;
