library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopShell is
    port(
        clk: in std_logic;
        sw : in std_logic_vector(1 downto 0);
        led: out std_logic_vector(0 downto 0)
    );
end TopShell;

architecture Behavioral of TopShell is

    signal s_clk: std_logic;

begin
    pulse_generator: entity work.PulseGenerator(Behavioral)
        port map(
            reset => '0',
            sysClk => clk,
            pulseOut => s_clk
        );
       
    control_unit: entity work.ControlUnit(Behavioral)
        port map(
            clk => s_clk,
            reset => sw(0),
            x => sw(1),
            y => led(0)
        );
        
end Behavioral;