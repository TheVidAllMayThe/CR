library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
    port(
        in_clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        count : out std_logic_vector(3 downto 0);
        terminalCount: out std_logic
        );
end Counter;

architecture Behavioral of Counter is
    signal s_count: std_logic_vector(3 downto 0);
    signal s_terminalCount: std_logic;
begin
    process(reset, in_clk)
    begin
        if (reset = '0') then
            s_count <= "0000";
            s_terminalCount <= '0';
        elsif (rising_edge(in_clk)) then
            if (enable = '1') then
                if (s_count = "1001") then
                    s_count <= "0000";
                    s_terminalCount <= '0';
                else    
                    s_count <= s_count + "0001";
                    if (s_count = "1001") then
                        s_terminalCount <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
    terminalCount <= s_terminalCount;
    count <= s_count;
end Behavioral;