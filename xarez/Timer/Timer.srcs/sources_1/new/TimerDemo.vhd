library ieee;
use ieee.std_logic_1164.all;

entity TimerDemo is
    port(
        clk : in std_logic;
        sw : in std_logic_vector (2 downto 0);
        led : out std_logic_vector (0 downto 0)
    );
end TimerDemo;

architecture Behavioral of TimerDemo is
begin
    timer : entity work.TimerOffDelay(Behavioral)
        generic map(K => 100000000)
        port map(
            clk => clk,
            reset => sw(0),
            enable => sw(1),
            start => sw(2),
            timerOut => led(0)
        );
end Behavioral;