library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder2to4 is
    port(
        enable : in std_logic;
        inputs : in std_logic_vector (1 downto 0);
        outputs : out std_logic_vector (3 downto 0)
    );
end decoder2to4;

architecture Behavioral of decoder2to4 is
begin
    process(enable, inputs)
    begin
        if (enable = '0') then
            outputs <= "0000";
        else
            if (inputs = "00") then
                outputs <= "0001";
            elsif (inputs = "01") then
                outputs <= "0010";
            elsif (inputs = "10") then
                outputs <= "0100";
            else
                outputs <= "1000";
            end if;
        end if;
    end process;
end Behavioral;