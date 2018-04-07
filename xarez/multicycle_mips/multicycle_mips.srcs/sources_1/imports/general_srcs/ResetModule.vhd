library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ResetModule is
    generic(
        N: positive := 4
    );
    port(
        sysClk: in std_logic;
        resetIn: in std_logic;
        resetOut: out std_logic
    );
end ResetModule;

architecture Behavioral of ResetModule is

    signal s_shiftReg: std_logic_vector((N-1) downto 0) := (others => '0');

begin
    shift_proc: process(resetIn, sysClk)
    begin
        if ( resetIn = '0') then
            s_shiftReg <= (others => '1');
        elsif (rising_edge(sysClk)) then
            s_shiftReg((N-1) downto 1) <= s_shiftReg((N-2) downto 0);
            s_shiftReg(0) <= '0';
        end if;
    end process;

    resetOut <= not s_shiftReg(N-1);
end Behavioral;