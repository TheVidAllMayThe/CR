library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    port(
        clk: in std_logic;
        reset: in std_logic;
        startstop: in std_logic;
        terminalCount: in std_logic_vector(3 downto 0);
        enable: out std_logic_vector(3 downto 0)
    );
end ControlUnit;

architecture Behavioral of ControlUnit is

type TState is (Start, Stop);
signal s_currentState: TState := Stop;
signal s_nextState: TState := Start; 
signal tmpState: TState;


begin
    sync_process: process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                s_currentState <= Stop;
                s_nextState <= Start;
            elsif (startstop = '1') then
                 tmpState <= s_currentState;
                 s_currentState <= s_nextState;
                 s_nextState <= tmpState;
            end if;
            
        end if;
        
    end process;
    
    comb_process: process(terminalCount, startstop, reset)
    begin
        case (s_currentState) is
        when (Stop) =>
            enable <= (others => '0');
        
        when (Start) =>
            if (terminalCount(3) = '1') then
                enable(3) <= '0';
                if (terminalCount(2) = '1') then
                    enable(2) <= '0';
                    if (terminalCount(1) = '1') then
                        enable(1) <= '0';
                        if (terminalCount(0) = '1') then
                            enable(0) <= '0';
            end if;
            
            if (terminalCount(0) = '1') then
                enable(1) <= '1';
                if (terminalCount(1) = '1') then
                    enable(2) <= '1';
                    if (terminalCount(2) = '1') then
                        enable(3) <= '1';
            else
                enable(3 downto 1) <= (others => '0');
            end if;
        end case Start;    
    end process;
end Behavioral;
