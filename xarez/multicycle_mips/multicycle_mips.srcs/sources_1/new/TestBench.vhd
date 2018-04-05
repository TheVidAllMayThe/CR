library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestBench is
end TestBench;

architecture Stimulus of TestBench is
    signal s_reset, s_clk: std_logic := '0';

begin
    uut: entity work.TopThatLevel(MesmoTOP)
        port map(
            reset => s_reset,
            clock => s_clk     
        );
    
    clock_proc: process
    begin
        s_clk <= '1';
        wait for 50ns;
        s_clk <= '0';
        wait for 50ns;
    end process;
    
    stim_proc: process
    begin
        s_reset <= '1';
        wait for 25ns;
         s_reset <= '0';
        wait for 10000ns;
    end process;
end Stimulus;
