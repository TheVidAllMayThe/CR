library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Mux2to1 is
    generic(N : positive := 32);
    port(
        sel : in  std_logic;
        a   : in  std_logic_vector(N-1 downto 0);
        b   : in  std_logic_vector(N-1 downto 0);
        z   : out std_logic_vector(N-1 downto 0)
    );
end Mux2to1;

architecture Behavioral of Mux2to1 is
begin
	 z <= a when (sel = '0') else b;
end Behavioral;
