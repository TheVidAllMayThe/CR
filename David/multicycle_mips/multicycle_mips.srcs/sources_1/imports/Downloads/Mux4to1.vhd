library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Mux4to1 is
    generic(N : positive := 32);
    port(
        sel : in  std_logic_vector(1 downto 0);
        a   : in  std_logic_vector(N-1 downto 0);
        b   : in  std_logic_vector(N-1 downto 0);
        c   : in  std_logic_vector(N-1 downto 0);
        d   : in  std_logic_vector(N-1 downto 0);
        z   : out std_logic_vector(N-1 downto 0)
    );
end Mux4to1;

architecture Behavioral of Mux4to1 is
begin
	 z <= a when (sel = "00") else
	      b when (sel = "01") else
          c when (sel = "10") else
          d;
end Behavioral;
