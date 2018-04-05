library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Testbench is 
end Testbench;

architecture Stimulus of Testbench is
    signal s_reset, s_clk: std_logic := '0';
begin    
    clock: process
    begin
        s_clk <= '1';
        wait for 10ns;
        s_clk <= '0';
        wait for 10ns;
    end process;
    
    reset: process
    begin
        s_reset <= '1';
        wait for 25ns;
        s_reset <= '0';
        wait for 6000ns;
    end process;

    uut: entity work.CPU(Structural)
    port map(
        reset => s_reset,
        clk => s_clk,
        dataIn => X"00000000",
        dataOut => open
    );
end Stimulus;
