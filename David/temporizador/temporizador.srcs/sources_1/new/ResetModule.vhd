----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2018 11:28:15 PM
-- Design Name: 
-- Module Name: ResetModule - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ResetModule is
    generic(N   : positive := 4);
    port(
        sysClk   : in std_logic;
        resetIn  : in std_logic;
        resetOut : out std_logic);
end ResetModule;

architecture Behavioral of ResetModule is

    signal s_shiftReg : std_logic_vector((N-1) downto 0) := (others => '0');
    
begin
    
    assert(N >= 2);
    
    shift_proc : process(resetIn, sysClk)
    begin
        if(resetIn = '1') then
            s_shiftReg <= (others => '1');
        elsif(rising_edge(sysClk)) then
            s_shiftReg((N-1) downto 1) <= s_shiftReg((N-2) downto 0);
            s_shiftReg(0) <= '0';
        end if;
    end process;
    
    resetOut <= s_shiftReg(N-1);


end Behavioral;
