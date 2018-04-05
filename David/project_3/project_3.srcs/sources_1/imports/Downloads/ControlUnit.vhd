library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    
    port(
        reset: in std_logic;
        startstop: in std_logic;
        terminalCount: in std_logic_vector(3 downto 0);
        enable: out std_logic_vector(3 downto 0)
    );
end ControlUnit;


architecture Behavioral of ControlUnit is

signal s_state: std_logic := '1';

begin
    sync_process: process(reset, startstop)
    begin
        if (reset = '1') then
            s_state <= '0';
        elsif (rising_edge(startstop)) then
            s_state <= not s_state;
        end if;
    end process;
    
    comb_process: process(terminalCount, startstop, reset)
    begin
        if (s_state = '0') then
            enable <= "0000";
        
        elsif (s_state = '1') then
            if (terminalCount(0)  = '1') then
                if(terminalCount(3 downto 1) = "111") then
                    enable(0) <= '0';
                else
                    enable(0) <= '1';
                end if;    
            else
                enable(0) <= '1';
            end if;
            
            
            if(terminalCount(1) = '1') then
                if(terminalCount(3 downto 2) = "11") then
                    enable(1) <= '0';
                elsif (terminalCount(0) = '1') then
                        enable(1) <= '1';
                end if;
            else
                if(terminalCount(0) = '1') then
                    enable(1) <= '1';
                else
                    enable(1) <= '0';
                end if;
            end if;
                
            if(terminalCount(2) = '1') then
                if(terminalCount(3) = '1') then
                    enable(2) <= '0';
                elsif(terminalCount(1 downto 0) = "11") then
                        enable(2) <= '1';
                end if;
            else
                if(terminalCount(1 downto 0) = "11") then
                    enable(2) <= '1';
                else
                    enable(2) <= '0';
                end if;
            end if;
              
            if(terminalCount(3) = '1') then
                enable(3) <= '0';
            elsif (terminalCount(2 downto 0) = "111") then
                enable(3) <= '1';
            else
                enable(3) <= '0';
            end if;
        end if;   
                    
    end process;
    
end Behavioral;
