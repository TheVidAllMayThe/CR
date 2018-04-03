library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopShell is
    port(
        btnC: in std_logic;
        btnD: in std_logic;
        clk: in std_logic
    );
end TopShell;

architecture Behavioral of TopShell is

    signal s_terminalCount, s_enable: std_logic_vector(3 downto 0);
    
begin
    control_unit: entity work.ControlUnit(Behavioral)
        port map(
            clk => clk;
            reset => BTND;
            startstop => BTNC;
            terminalCount => s_terminalCount;
            enable => s_enable
        );
        

end Behavioral;
