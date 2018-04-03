library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestBench is
end TestBench;

architecture Stimulus of TestBench is
    signal s_reset, s_clk: std_logic;

begin
    uut: entity work.TopThatLevel(MesmoTOP)
        port map(
            reset => s_reset,
            clk => s_clk     
        );
    
    clock_proc: process
    begin
        s_clk <= '1';
        wait for 10ns;
        s_clk <= '0';
        wait for 10ns;
    end process;
    
    stim_proc: process
    begin
        s_reset <= '1';
        wait for 25ns;
        s_reset <= '0';
    end
end Stimulus;
