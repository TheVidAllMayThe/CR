library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.VComponents.all;

entity tb_decoder2to4 is
end tb_decoder2to4;

architecture tb of tb_decoder2to4 is

    component decoder2to4
        port (enable  : in std_logic;
              inputs  : in std_logic_vector (1 downto 0);
              outputs : out std_logic_vector (3 downto 0));
    end component;

    signal enable  : std_logic;
    signal inputs  : std_logic_vector (1 downto 0);
    signal outputs : std_logic_vector (3 downto 0);

begin

    decoder2to4
    port map (enable  => enable,
              inputs  => inputs,
              outputs => outputs);

    process
    begin
        
        enable <= '0';
        inputs <= (others => '0');

       
        wait;
    end process;

end tb;
