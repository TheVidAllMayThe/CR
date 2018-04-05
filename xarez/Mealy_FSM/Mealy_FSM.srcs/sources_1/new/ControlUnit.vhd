library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    port(
        clk  : in std_logic;
        reset: in std_logic;
        x    : in std_logic;
        y    : out std_logic
    );
end ControlUnit;

architecture Behavioral of ControlUnit is

    type TState is (S0, S1, S2, S3);
    signal s_currentState, s_nextState: TState;

begin
    sync_proc: process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset='1') then
                s_currentState <= S0;
            else
                s_currentState <= s_nextState;
            end if;
        end if;
    end process;
    
    comb_proc: process(s_currentState, x,reset)
    begin
        case (s_currentState) is
        when S0 =>
            y <= '0';
            if (x='0') then
                s_nextState <= S0;
            else
                s_nextState <= S1;
            end if;
        
        when S1 =>
            y <= '0';
            if (x='0') then
                s_nextState <= S0;
            else
                s_nextState <= S2;
            end if;
        
        when S2 =>
            y <= '0';
            if (x='0') then
                s_nextState <= S3;
            else
                s_nextState <= S2;
            end if;
       
        when S3 =>
            if(x='0') then
                y <= '0';
                s_nextState <= S0;
            else
                y <= '1';
                s_nextState <= S1;
            end if;
        end case;
    end process;
end Behavioral;
