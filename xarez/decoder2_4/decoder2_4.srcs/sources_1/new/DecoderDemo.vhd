library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecoderDemo is
    port(
        sw : in std_logic_vector (2 downto 0);
        led: out std_logic_vector (3 downto 0)
    );
end DecoderDemo;

architecture Behavioral of DecoderDemo is
begin
    timer : entity work.decoder2_4(Behavioral)
    port map(
        enable => sw(0),
        inputs => sw(2 downto 1),
        outputs => led(3 downto 0));
end Behavioral;