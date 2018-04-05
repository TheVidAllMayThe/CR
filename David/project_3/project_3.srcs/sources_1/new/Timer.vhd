

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Timer is
    Port (clk : in std_logic;
          led: out std_logic_vector(15 downto 0);
          btnU: in std_logic;
          btnD: in std_logic;
          sw: in std_logic_vector(15 downto 0));
end Timer;


architecture Behavioral of Timer is

signal s_pulse: std_logic;
signal s_enable,s_terminalCount: std_logic_vector(3 downto 0);
signal s_btnu: std_logic := '0';
signal en0,en1,en2,en3 : std_logic := '0';
signal s_size1 : unsigned := "1001"; 
signal s_size2 : unsigned := "1001";
signal s_size0 : unsigned := "1001";
signal s_size3 : unsigned := "0101";

begin

    --process(btnd, sw)
    --begin
    --    if(btnd = '1') then
    --        if(sw(3 downto 0) > "1001") then
    --            s_size0 <= "1001";
    --            
    --        else s_size0 <= unsigned(sw(3 downto 0));
    --        
    --        end if;
    --        
    --        if(sw(7 downto 4) > "1001") then
    --            s_size1 <= "1001";
    --        else s_size1 <= unsigned(sw(7 downto 4));
    --        end if;
    --        
    --        if(sw(11 downto 8) > "1001") then
    --            s_size2 <= "1001";
    --        else s_size2 <= unsigned(sw(11 downto 8));    
    --        end if;
            
            
    --        if(sw(15 downto 12) > "0101") then
    --            s_size3 <= "0101";
    --        else s_size3 <= unsigned(sw(15 downto 12));
    --       end if;
            
    --    end if;
    --end process;
        
        
    controlUnit: entity work.ControlUnit
            port map(
                enable => s_enable,
                startstop => s_btnu,
                terminalCount => s_terminalCount,
                reset => btnd);
    
    pulseGen: entity work.PulseGenerator
            port map(
                reset => btnd,
                sysClk => clk,
                pulseOut => s_pulse
            );
            
    counter0: entity work.counter0
            generic map(N => "1001")
            port map(
                --N => s_size0,
                pulse => s_pulse,
                enable0 => s_enable(0),
                terminalCount => s_terminalCount(0),
                clock => clk,
                reset => btnd,
                output => led(3 downto 0)
                );
                
    
    counter1: entity work.counter0
            generic map(N => "1001")
            port map(
                
                pulse => s_pulse,
                enable0 => s_enable(1),
                terminalCount => s_terminalCount(1),
                clock => clk,
                reset => btnd,
                output => led(7 downto 4)
                );
                           
    en2 <= s_terminalCount(0) and s_terminalCount(1);
    
    counter2: entity work.counter0
            generic map(N => "1001")
            port map(
                
                pulse => s_pulse,
                enable0 => s_enable(2),
                terminalCount => s_terminalCount(2),
                clock => clk,
                reset => btnd,
                output => led(11 downto 8)
                );
                                  
    en3 <= s_terminalCount(0) and s_terminalCount(1) and s_terminalCount(2);
                                                
    counter3: entity work.counter0
            generic map(N => "0101")
            port map(
                
                pulse => s_pulse,
                enable0 => s_enable(3),
                terminalCount => s_terminalCount(3),
                clock => clk,
                reset => btnd,
                output => led(15 downto 12)
                );
    
            
    startStop: entity work.debounce
            port map(
                clk => clk,
                button => btnu,
                result => s_btnu
            );

end Behavioral;
