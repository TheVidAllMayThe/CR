library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestBench is
end TestBench;

architecture Stimulus of TestBench is
    signal s_reset, s_clk: std_logic := '0';
    signal s_sw, s_led: std_logic_vector(15 downto 0);

begin
    uut: entity work.TopThatLevel(MesmoTOP)
        port map(
            btnCpuReset => s_reset,
            clk => s_clk,
            sw => s_sw,
            led => s_led  
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
        s_sw <= "0000000000000011";
        wait for 25ns;
         s_reset <= '0';
        wait for 10000ns;
    end process;
end Stimulus;
