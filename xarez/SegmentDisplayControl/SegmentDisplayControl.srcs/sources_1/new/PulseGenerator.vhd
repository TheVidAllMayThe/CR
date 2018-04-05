library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PulseGenerator is
    port(
        reset   : in std_logic;
        sysClk  : in std_logic;
        pulseOut: out std_logic
    );
end PulseGenerator;

architecture Behavioral of PulseGenerator is
    constant NUMBER_STEPS: positive := 125000;
    subtype TCounter is natural range 0 to (NUMBER_STEPS - 1);
    signal s_counter: TCounter;
    signal s_pulseOut: std_logic;
begin
    count_proc: process(sysClk)
    begin
        if rising_edge(sysClk) then
            if ((reset = '1') or (s_counter >= (NUMBER_STEPS -1))) then
                s_counter <= 0;
            else
                s_counter <= s_counter + 1;
            end if;
        end if;
    end process;
    
    s_pulseOut <= '1' when (s_counter = 0) else '0';
    
    out_reg_proc: process(sysClk)
    begin
        if (rising_edge(sysClk)) then
            if (reset = '1') then
                pulseOut <= '0';
            else
                pulseOut <= s_pulseOut;
            end if;
        end if;
    end process;
end Behavioral;