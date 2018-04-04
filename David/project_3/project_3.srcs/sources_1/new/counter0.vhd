library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter0 is
    generic(N : unsigned := "1001"); 
    Port ( --N : in unsigned := "1001";
           enable0 : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           pulse: in std_logic;
           output : out STD_LOGIC_VECTOR (3 downto 0);
           terminalCount : out STD_LOGIC);
end counter0;

architecture Behavioral of counter0 is

    signal s_count: unsigned := N; 
    signal s_terminalCount : std_logic := '0';
begin
    process(reset, clock)
    begin
    
        if rising_edge(clock)then
            if reset = '1' then
                s_count <= N;
                terminalCount <= '0';
                
            elsif (pulse = '1') then
                if (enable0) = '1' then
                    if (s_count = "0000") then        
                        s_count <= N;
                        terminalCount <= '0';        
                    else
                        if s_count = "0001" then
                          terminalCount <= '1';  
                        end if;
                        s_count <= s_count - 1;  
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    output <= std_logic_vector(s_count);
    --terminalCount <= '1';
    
end Behavioral;
