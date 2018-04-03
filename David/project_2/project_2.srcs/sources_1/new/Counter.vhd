

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter is
    Port ( in_clk : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (2 downto 0));
end Counter;

architecture Behavioral of Counter is
signal s_count : std_logic_vector(2 downto 0) := "000";
begin    
    process(in_clk)
    begin
        if rising_edge(in_clk) then
            s_count <= s_count + "001";
        end if;
    end process;
    count <= s_count;

end Behavioral;
