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

type TState is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
signal s_currentState, s_nextState: TState; 
signal s_enable: std_logic_vector(3 downto 0);

begin
    sync_process: process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '0') then
                enable <= "0001";
                s_currentState <= S1;
            else
                enable <= s_enable;
                s_currentState <= s_nextState;
            end if;
        end if;
    end process;
    
    comb_process: process(terminalCount, startstop, reset)
    begin
        if (rising_edge(clk)) then
        case (s_currentState) is
        when S0 =>
            if (startstop = '0') then
                s_enable <= "0001";
                s_nextState <= S1;
            else
                s_enable <= "0000";
                s_nextState <= S0;
            end if;
        
        when S1 =>
            if (startstop = '0') then
                s_enable <= "0000";
                s_nextState <= S0;
            else
                if (terminalCount(3) = '1') then
                    s_enable <= "0001";
                    s_nextState <= S2;
                
                elsif (terminalCount(2) = '1') then
                    s_enable <= "1111";
                    s_nextState <= S1;

                elsif (terminalCount(1) = '1') then
                    s_enable <= "0111";
                    s_nextState <= S1;
                    
                elsif (terminalCount(0) = '1') then
                    s_enable <= "0011";
                    s_nextState <= S1;
                    
                else
                    s_enable <= "0001";
                    s_nextState <= S1;
                end if;
            end if;
        
        when S2 =>
            if (startstop = '0') then
                s_enable <= "0000";
                s_nextState <= S3;
            else
                if (terminalcount(3) = '1') then
                    s_enable <= "0001";
                    s_nextState <= S4;
                    
                elsif (terminalcount(2) = '1') then
                    s_enable <= "1111";
                    s_nextState <= S2;
                    
                elsif (terminalcount(1) = '1') then
                    s_enable <= "0111";
                    s_nextState <= S2;
                
                elsif (terminalcount(0) = '1') then
                    s_enable <= "0011";
                    s_nextState <= S2;
                
                else 
                    s_enable <= "0001";
                    s_nextState <= S2;
                end if;
            end if;
        
        when S3 =>
            if (startstop = '0') then
                s_enable <= "0001";
                s_nextState <= S2;
            else
                s_enable <= "0000";
                s_nextState <= S3;
            end if;
            
        when S4 =>
            if (startstop = '0') then
                s_enable <= "0000";
                s_nextState <= S5;
            else
                if (terminalcount(2) = '1') then
                    s_enable <= "0001";
                    s_nextState <= S6;
                elsif (terminalcount(1) = '1') then
                    s_enable <= "0111";
                    s_nextState <= S4;
                elsif (terminalcount(0) = '1') then
                    s_enable <= "0011";
                    s_nextState <= S4;
                else
                    s_enable <= "0001";
                    s_nextState <= S4;
                end if;
            end if;
            
        when S5 =>
            if (startstop = '0') then
                s_enable <= "0001";
                s_nextState <= S4;
            else
                s_enable <= "0000";
                s_nextState <= S5;
            end if;
            
        when S6 =>
            if (startstop = '0') then
                s_enable <= "0000";
                s_nextState <= S7;
            else
                if (terminalcount(1) = '1') then
                    s_enable <= "0001";
                    s_nextState <= S8;
                elsif (terminalcount(0) = '1') then
                    s_enable <= "0011";
                    s_nextState <= S6;
                else
                    s_enable <= "0001";
                    s_nextState <= S6;
                end if;
            end if;
            
        when S7 =>
            if (startstop = '0') then
                s_enable <= "0001";
                s_nextState <= S6;
            else
                s_enable <= "0000";
                s_nextState <= S7;
            end if;
        
        when S8 =>
            if (startstop = '0') then
                s_nextState <= S9;
            else
                if (terminalcount(0) = '1') then
                    s_enable <= "0001";
                    s_nextState <= S10;
                else
                    s_enable <= "0001";
                    s_nextState <= S8;
                end if;
            end if;
        
        when S9 =>
            if (startstop = '0') then
                s_enable <= "0001";
                s_nextState <= S8;
            else
                s_enable <= "0000";
                s_nextState <= S9;
            end if;
        
        when S10 =>
            s_enable <= "0000";
            s_nextState <= S10;
        
        when others =>
            s_nextState <= S0;
         
        end case;
        end if;
    end process;
end Behavioral;