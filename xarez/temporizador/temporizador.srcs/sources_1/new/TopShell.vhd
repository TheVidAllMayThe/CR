library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopShell is
    port(
        btnC: in std_logic;
        btnD: in std_logic;
        clk: in std_logic;
        led: out std_logic_vector(15 downto 0)
    );
end TopShell;

architecture Behavioral of TopShell is

    signal s_terminalCount, s_enable: std_logic_vector(3 downto 0);
    signal s_pulse, s_reset, s_startstop: std_logic;
    
begin     
    pulse_generator: entity work.PulseGenerator(Behavioral)
        port map(
            sysClk => clk,
            reset => s_reset,
            pulseOut => s_pulse
        );
        
        startstop_module: entity work.ButtonModule(Behavioral)
          port map(
              sysClk => clk,
              input => BTNC,
              output => s_startstop
          );
          
      reset_module: entity work.ResetModule(Behavioral)
          port map(
              sysClk => clk,
              resetIn => BTND,
              resetOut => s_reset
          );
        
    control_unit: entity work.ControlUnit(Behavioral)
        port map(
            clk => s_pulse,
            reset => BTND,
            startstop => BTNC,
            terminalCount => s_terminalCount,
            enable => s_enable
        );
     
     counter0: entity work.Counter(Behavioral)
        port map(
            in_clk => s_pulse,
            reset => BTNC,
            enable => s_enable(0),
            count => led(3 downto 0),
            terminalCount => s_terminalCount(0)
        );
      
     counter1: entity work.Counter(Behavioral)
        port map(
            in_clk => s_pulse,
            reset => BTNC,
            enable => s_enable(1),
            count => led(7 downto 4),
            terminalCount => s_terminalCount(1)
        );
        

     counter2: entity work.Counter(Behavioral)
        port map(
            in_clk => s_pulse,
            reset => BTNC,
            enable => s_enable(2),
            count => led(11 downto 8),
            terminalCount => s_terminalCount(2)
        );
        

     counter3: entity work.Counter(Behavioral)
        port map(
            in_clk => s_pulse,
            reset => BTNC,
            enable => s_enable(3),
            count => led(15 downto 12),
            terminalCount => s_terminalCount(3)
        );
end Behavioral;