library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
    port(
        in_clk: in std_logic;
        count : out std_logic_vector(2 downto 0)
        );
end Counter;

architecture Behavioral of Counter is
    signal s_count: std_logic_vector(2 downto 0) := "000";
begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then
            if (s_count = "111") then
                s_count <= "000";
            else    
                s_count <= s_count + "001";
            end if;
        end if;
    end process;
    count <= s_count;
end Behavioral;