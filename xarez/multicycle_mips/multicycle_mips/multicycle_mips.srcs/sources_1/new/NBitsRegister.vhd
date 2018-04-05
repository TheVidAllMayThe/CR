library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NBitsRegister is  
    generic(N: positive:= 32);
    port(
        input:  in std_logic_vector(N-1 downto 0);
        enable: in std_logic;
        clk:    in std_logic;
        output: out std_logic_vector(N-1 downto 0)
    );
end NBitsRegister;

architecture Behavioral of NBitsRegister is

begin
    process(clk) is
    begin
        if(rising_edge(clk)) then
            if(enable = '1') then
                output <= input;
            end if;
        end if;
    end process;
end Behavioral;
