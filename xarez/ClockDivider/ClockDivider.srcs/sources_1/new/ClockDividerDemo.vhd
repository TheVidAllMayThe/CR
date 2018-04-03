library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDividerDemo is
    port(
        clk: in std_logic;
        sw : in std_logic_vector(0 downto 0);
        led: out std_logic_vector(0 downto 0)
    );
end ClockDividerDemo;

architecture Behavioral of ClockDividerDemo is
begin
    clockdivider : entity work.FreqDivStatic(Behavioral)
    generic map(k => 100000000)
    port map(
        reset => sw(0),
        clkIn => clk,
        clkOut => led(0)
    );
end Behavioral;
