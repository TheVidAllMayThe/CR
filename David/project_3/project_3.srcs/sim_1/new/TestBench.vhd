----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2018 05:32:35 PM
-- Design Name: 
-- Module Name: TestBench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TestBench is
end TestBench;

architecture Behavioral of TestBench is


signal s_clk, s_btnu, s_btnd : std_logic := '0';

begin
    testing: entity work.Timer
        port map(clk => s_clk, btnu => s_btnu, btnd => s_btnd);

    clk: process
    begin
        s_clk <= '1';
        wait for 1ps;
        s_clk <= '0';
        wait for 1ps;
    end process;
    
    btn: process
    begin
        s_btnu <= '0';
        wait for 1ps; 
        s_btnu <= '1';
        wait for 1ps;
        s_btnu <= '0';
        wait;
    end process;
end Behavioral;
