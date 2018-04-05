library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity RAM is
    generic( 
            ADDR_BUS_SIZE : positive := 6;
            DATA_BUS_SIZE : positive := 32);
    port(
        clk : in std_logic;
        enable : in std_logic;
        readEn : in std_logic;
        writeEn : in std_logic;
        address : in std_logic_vector(ADDR_BUS_SIZE-1 downto 0);
        writeData : in std_logic_vector(DATA_BUS_SIZE-1 downto 0);
        readData : out std_logic_vector(DATA_BUS_SIZE-1 downto 0));
end RAM;

architecture Behavioral of RAM is
    constant NUM_WORDS : positive := (2 ** ADDR_BUS_SIZE );
    subtype TData is std_logic_vector(DATA_BUS_SIZE-1 downto 0);
    
    type TMemory is array(0 to NUM_WORDS - 1) of TData;
    
    signal s_memory : TMemory := (
        X"8c010000", -- lw $1, 0($0)
        X"20020001", -- addi $2, $0, 1
        X"20030003", -- addi $3, $0, 3
        X"00622022", -- sub $4, $3, $2
        X"00432824", -- and $5, $2, $3
        X"00443025", -- or $6, $2, $4
        X"0062382a", -- slt $7, $3, $2
        X"0043382a", -- slt $7, $2, $3
        X"ac06003c", -- sw $6, 60($0)
        X"10620002", -- beq $3, $2, 2
        X"20420002", -- addi $2, $2, 2
        X"08000009", -- j 36
        X"70684021", -- clo $8, $3
        X"70694820", -- clz $9, $3
        others => (others => '0')
        );
     
begin
    process(clk)
    begin
    if(rising_edge(clk)) then
        if(enable = '1' and writeEn = '1') then
            s_memory(to_integer(unsigned(address))) <= writeData;
        end if;
    end if;
    end process;
    readData <= s_memory(to_integer(unsigned(address))) when
    readEn = '1' else (others => '-');
end Behavioral;