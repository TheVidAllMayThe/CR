library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Testbench is
end Testbench;

architecture Stimulus of Testbench is
    signal s_reset, s_clk, s_x, s_y: std_logic;
begin
    uut: entity work.ControlUnit(Behavioral)
        port map(
            reset => s_reset,
            clk => s_clk,
            x => s_x,
            y => s_y
        );
        
    clock_proc: process
    begin
        s_clk <= '0'; wait for 100ns;
        s_clk <= '1'; wait for 100ns;
    end process;
    
    stim_proc: process
    begin
        s_reset <= '1';
        wait for 125ns;
        
        s_reset <= '0';
        s_x <= '0';
        wait for 100ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '0';
        wait for 200ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '0';
        wait for 200ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '1';
        wait for 200ns;
        
        s_x <= '0';
        wait for 200ns;
        
        s_x <= '0';
        wait for 200ns;
    end process;
end Stimulus;
