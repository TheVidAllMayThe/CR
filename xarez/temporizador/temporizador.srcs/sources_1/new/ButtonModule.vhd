library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ButtonModule is
    port(
        sysClk: in std_logic;
        input: in std_logic;
        output: out std_logic
    );
end ButtonModule;

architecture Behavioral of ButtonModule is

    signal s_output: std_logic := '0';

begin
    
    module_input_proc: process(input)
    variable flag: boolean := true;
    begin
        if(rising_edge(sysClk)) then
            s_output <= '0';
            if (flag) then
                if(input = '1') then
                    s_output <= '1';
                    flag := false;
                end if;
            else
                if(input = '0') then
                    flag := true;
                end if;
            end if;
        end if;
    end process;
    
    output <= s_output;

end Behavioral;
