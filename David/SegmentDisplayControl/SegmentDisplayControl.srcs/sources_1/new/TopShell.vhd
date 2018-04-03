library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopShell is
    port(
        clk: in std_logic;
        sw : in std_logic_vector(15 downto 0);
        seg: out std_logic_vector(6 downto 0);
        dp : out std_logic;
        an : out std_logic_vector(7 downto 0)
    );
end TopShell;

architecture Behavioral of TopShell is
    signal s_count: std_logic_vector(2 downto 0);
    signal s_enable: std_logic;
    signal s_segDisplay: std_logic_vector(3 downto 0);
    signal s_clk: std_logic;
    signal s_dp: std_logic;
begin
    clk_divider: entity work.PulseGenerator(Behavioral)
        port map(
            reset => '0',
            sysClk => clk,
            pulseOut => s_clk
        );
        
    counter: entity work.Counter(Behavioral)
        port map(
            in_clk => s_clk,
            count => s_count
        );
    
    disp_multiplexer: entity work.Multiplexer(Behavioral)
        port map(
            input0 => sw(3 downto 0),
            input1 => sw(7 downto 4),
            input2 => sw(3 downto 0),
            input3 => sw(7 downto 4),
            input4 => sw(3 downto 0),
            input5 => sw(7 downto 4),
            input6 => sw(3 downto 0),
            input7 => sw(7 downto 4),
            sel => s_count,
            output => s_segDisplay   
        );
    
    decoder: entity work.Decoder3to8(Behavioral)
        port map(
            input => s_count,
            output => an
        );
        
    enable_multiplexer_digit: entity work.Enable_multiplexer(Behavioral)
        port map(
            input(0) => sw(8),
            input(1) => sw(8),
            input(2) => sw(9),
            input(3) => sw(9),
            input(4) => sw(10),
            input(5) => sw(10),
            input(6) => sw(11),
            input(7) => sw(11),
            sel => s_count,
            output => s_enable
        );
    
    enable_multiplexer_point: entity work.Enable_multiplexer(Behavioral)
        port map(
            input(0) => sw(12),
            input(1) => sw(12),
            input(2) => sw(13),
            input(3) => sw(13),
            input(4) => sw(14),
            input(5) => sw(14),
            input(6) => sw(15),
            input(7) => sw(15),
            sel => s_count,
            output => s_dp
        );
        
    binToSegDecoder: entity work.Bin2SegDecoder(Behavioral)
        port map(
            bin => s_segDisplay,
            enable => s_enable,
            seg => seg
        );
        
    dp <= not s_dp;
end Behavioral;