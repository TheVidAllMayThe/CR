library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShifterDemo is
    port(
        sw : in std_logic_vector (11 downto 0);
        led: out std_logic_vector (7 downto 0)
    );
end ShifterDemo;

architecture Behavioral of ShifterDemo is
begin
    shifter : entity work.CombShifter(Behavioral)
    port map(
        dataIn => sw(7 downto 0),
        dirLeft => sw(8),
	    shAmount => sw(11 downto 9),
        dataOut => led(7 downto 0));
end Behavioral;