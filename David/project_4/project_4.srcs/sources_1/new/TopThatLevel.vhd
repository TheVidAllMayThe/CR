library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopThatLevel is
    Port (reset, clock: in std_logic);
end TopThatLevel;

architecture MesmoTOP of TopThatLevel is
    signal s_Clock :  std_logic;
    signal s_Reset :  std_logic;
    signal s_OpCode :  std_logic_vector(5 downto 0);
    signal s_PCWrite :  std_logic;
    signal s_IRWrite :  std_logic;
    signal s_IorD :  std_logic;
    signal s_PCSource :  std_logic_vector(1 downto 0);
    signal s_RegDest :  std_logic;
    signal s_PCWriteCond :  std_logic;
    signal s_MemRead :  std_logic;
    signal s_MemWrite :  std_logic;
    signal s_MemToReg :  std_logic;
    signal s_ALUSelA :  std_logic;
    signal s_ALUSelB :  std_logic_vector(1 downto 0);
    signal s_RegWrite :  std_logic;
    signal s_ALUop :  std_logic_vector(1 downto 0); 

    component ControlUnit
    port(Clock : in std_logic;
         Reset : in std_logic;
         OpCode : in std_logic_vector(5 downto 0);
         PCWrite : out std_logic;
         IRWrite : out std_logic;
         IorD : out std_logic;
         PCSource : out std_logic_vector(1 downto 0);
         RegDest : out std_logic;
         PCWriteCond : out std_logic;
         MemRead : out std_logic;
         MemWrite : out std_logic;
         MemToReg : out std_logic;
         ALUSelA : out std_logic;
         ALUSelB : out std_logic_vector(1 downto 0);
         RegWrite : out std_logic;
         ALUop : out std_logic_vector(1 downto 0));
    end component;
    
    signal s_zero : std_logic;
    signal s_PC4 : std_logic_vector(31 downto 0);
    signal s_BTA : std_logic_vector(31 downto 0);
    signal s_jAddr : std_logic_vector(25 downto 0);
    signal s_pc : std_logic_vector(31 downto 0);
    
    component PCupdate is
        port(
            clk         : in std_logic;
            reset       : in std_logic;
            zero        : in std_logic;
            PCSource    : in std_logic_vector(1 downto 0);
            PCWrite     : in std_logic;
            PCWriteCond : in std_logic;
            PC4         : in std_logic_vector(31 downto 0);
            BTA         : in std_logic_vector(31 downto 0);
            jAddr       : in std_logic_vector(25 downto 0);
            pc          : out std_logic_vector(31 downto 0)
        );
    end component;
    
    constant s_ADDR_BUS_SIZE : positive := 6;
    constant s_DATA_BUS_SIZE : positive := 32;
    signal s_address : std_logic_vector(s_ADDR_BUS_SIZE-1 downto 0);
    signal s_writeData : std_logic_vector(s_DATA_BUS_SIZE-1 downto 0);
    signal s_readData : std_logic_vector(s_DATA_BUS_SIZE-1 downto 0);
    
    
    component RAM is
        generic(ADDR_BUS_SIZE : positive := 6;
                DATA_BUS_SIZE : positive := 32);
        port(   clk : in std_logic;
                readEn : in std_logic;
                writeEn : in std_logic;
                address : in std_logic_vector(ADDR_BUS_SIZE-1 downto 0);
                writeData : in std_logic_vector(DATA_BUS_SIZE-1 downto 0);
                readData : out std_logic_vector(DATA_BUS_SIZE-1 downto 0));
    end component;
    
    
    
    signal s_writeEnable: std_logic;
    signal s_writeReg   : std_logic_vector(4 downto 0);
    signal s_writeData_reg  : std_logic_vector(31 downto 0);
    signal s_readReg1   : std_logic_vector(4 downto 0);
    signal s_readReg2   : std_logic_vector(4 downto 0);
    signal s_readData1  : std_logic_vector(31 downto 0);
    signal s_readData2  : std_logic_vector(31 downto 0);
    
    component RegFile is
        port(
            clk        : in std_logic;
            writeEnable: in std_logic;
            writeReg   : in std_logic_vector(4 downto 0);
            writeData  : in std_logic_vector(31 downto 0);
            readReg1   : in std_logic_vector(4 downto 0);
            readReg2   : in std_logic_vector(4 downto 0);
            readData1  : out std_logic_vector(31 downto 0);
            readData2  : out std_logic_vector(31 downto 0)
        );
    end Component;
    
    signal s_ALUout : std_logic_vector(31 downto 0);
    
    component Mux2Nto1 is
        generic(N : positive := 2);
        port(
            sel : in  std_logic;
            a   : in  std_logic_vector(N-1 downto 0);
            b   : in  std_logic_vector(N-1 downto 0);
            z   : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    
    signal s_instruction : std_logic_vector(31 downto 0);
    signal s_rd : std_logic_vector(4 downto 0);
    signal s_shamt : std_logic_vector(4 downto 0);
    signal s_func : std_logic_vector(5 downto 0);
    signal s_imm : std_logic_vector(15 downto 0);
    
    
    component InstrSplitter is
        port(
            instruction : in std_logic_vector(31 downto 0);
            opcode : out std_logic_vector(5 downto 0);
            rs : out std_logic_vector(4 downto 0);
            rt : out std_logic_vector(4 downto 0);
            rd : out std_logic_vector(4 downto 0);
            shamt : out std_logic_vector(4 downto 0);
            funct : out std_logic_vector(5 downto 0);
            imm : out std_logic_vector(15 downto 0);
            jAddr : out std_logic_vector(25 downto 0)
        );
    end component;
    
    signal s_imm_ext : std_logic_vector(31 downto 0);
    
    component SignExtend is
        port(
            dataIn : in std_logic_vector(15 downto 0);
            dataOut : out std_logic_vector(31 downto 0)
        );
    end component;
    
    
    signal s_dataOut : std_logic_vector(31 downto 0);
    signal s_readData1out  : std_logic_vector(31 downto 0);
    signal s_readData2out  : std_logic_vector(31 downto 0);
    
    
    component NBitsRegister is  
        generic(N: positive:= 32);
        port(
            input:  in std_logic_vector(N-1 downto 0);
            enable: in std_logic;
            clk:    in std_logic;
            output: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    
    
    signal s_result: std_logic_vector(31 downto 0);
    signal s_oper: std_logic_vector(2 downto 0);
    
    component ALUControlUnit is
        port(ALUop : in std_logic_vector(1 downto 0);
             funct : in std_logic_vector(5 downto 0);
             ALUcontrol : out std_logic_vector(2 downto 0));
    end component;
    
    signal s_a : std_logic_vector(31 downto 0);
    signal s_b : std_logic_vector(31 downto 0);
    
    component ALU32 is
        port(a : in std_logic_vector(31 downto 0);
             b : in std_logic_vector(31 downto 0);
             oper : in std_logic_vector(2 downto 0);
             res : out std_logic_vector(31 downto 0);
             zero : out std_logic;
             ovf : out std_logic);
    end component;
    
    component Mux4to1 is
        generic(N : positive := 32);
        port(
            sel : in  std_logic_vector(1 downto 0);
            a   : in  std_logic_vector(N-1 downto 0);
            b   : in  std_logic_vector(N-1 downto 0);
            c   : in  std_logic_vector(N-1 downto 0);
            d   : in  std_logic_vector(N-1 downto 0);
            z   : out std_logic_vector(N-1 downto 0)
        );
    end component;
    

    signal s_tmp : std_logic_vector(31 downto 0);

    component Mux3to1 is
        generic(N : positive := 32);
        port(
            sel : in  std_logic_vector(1 downto 0);
            a   : in  std_logic_vector(N-1 downto 0);
            b   : in  std_logic_vector(N-1 downto 0);
            c   : in  std_logic_vector(N-1 downto 0);
            z   : out std_logic_vector(N-1 downto 0)
        );
    end component;
begin
    U1: ControlUnit port map(Clock       => clock,
                             Reset       => reset,
                             OpCode      => s_OpCode,
                             PCWrite     => s_PCWrite,
                             IRWrite     => s_IRWrite,
                             IorD        => s_IorD,
                             PCSource    => s_PCSource,
                             RegDest     => s_RegDest,
                             PCWriteCond => s_PCWriteCond,
                             MemRead     => s_MemRead,
                             MemWrite    => s_MemWrite,
                             MemToReg    => s_MemToReg,
                             ALUSelA     => s_ALUSelA,
                             ALUSelB     => s_ALUSelB,
                             RegWrite    => s_RegWrite,
                             ALUop       => s_ALUop);
                        
                             
    PC: PCUpdate port map(clk         => clock,
                          reset       => reset,
                          zero        => s_zero,
                          PCSource    => s_PCSource,
                          PCWrite     => s_PCWrite,
                          PCWriteCond => s_PCWriteCond,
                          PC4         => s_PC4,
                          BTA         => s_BTA,
                          jAddr       => s_jAddr,
                          pc          => s_pc);       
    
    
    Memory: RAM port map(clk       => clock,       
                         readEn    => s_MemRead,    
                         writeEn   => s_MemWrite,   
                         address   => s_address,
                         writeData => s_writeData,
                         readData  => s_readData); 
    
    
    Registers: RegFile port map(
                        clk         => clock,
                        writeEnable => s_writeEnable,
                        writeReg    => s_writeReg,   
                        writeData   => s_writeData_reg,  
                        readReg1    => s_readReg1,   
                        readReg2    => s_readReg2,   
                        readData1   => s_readData1,  
                        readData2   => s_readData2); 
    
    M1 : Mux2Nto1 generic map(
                        N => 32
                        )
                        
                  port map(
                        sel => s_Iord,
                        a   => s_pc,
                        b   => s_ALUout,
                        z   => s_address
                        );
    
    Splitter: InstrSplitter port map(
                                    instruction => s_instruction,
                                    opcode      => s_OpCode,
                                    rs          => s_readReg1,
                                    rt          => s_readReg2,
                                    rd          => s_rd,
                                    shamt       => s_shamt,
                                    funct       => s_func,
                                    imm         => s_imm,
                                    jAddr       => s_jAddr
                                    );
                
    SignExtender: SignExtend port map(
                                dataIn => s_imm,
                                dataOut => s_imm_ext);
                                
    
    InstructionRegister: NBitsRegister port map(
                            input => s_readData,
                            output => s_instruction,
                            enable => s_IRWrite,
                            clk => clock
                            );
    
    
    DataRegister: NBitsRegister port map(
                        input => s_readData,
                        output => s_dataOut,
                        enable => '1',
                        clk => clock
                        );
    
    
    RegA : NBitsRegister port map(
                    input => s_readData1,
                    output => s_readData1out,
                    enable => '1',
                    clk => clock
                    );
    
    RegB : NBitsRegister port map(
                    input => s_readData2,
                    output => s_writeData,
                    enable => '1',
                    clk => clock
                    );
                        
    
    M4 : Mux2Nto1 port map(
                    sel => s_ALUSelA,
                    a => s_pc,
                    b => s_readData1out,
                    z => s_a
                    );
    
    
    M5 : Mux4to1 port map(
                    sel => s_ALUSelB,
                    a => s_writeData,
                    b => "000000000000000000000000000000000100",
                    c => s_imm_ext,
                    d => s_imm_ext,
                    z => s_b
                    ); 
    
    ALU : ALU32 port map(
                    zero => s_zero,
                    a => s_a,
                    b => s_b,
                    res => s_result,
                    oper => s_oper
                    );
                    
    ALUControl: ALUControlUnit port map(
                    ALUop => s_ALUOp,
                    funct => s_func,
                    ALUcontrol => s_oper
                    );
    
    ALUOut: NBitsRegister port map(
                    input => s_result,
                    output => s_ALUout,
                    enable => '1',
                    clk => clock
                    );
    
    s_tmp <= s_pc(31 downto 28) & s_jAddr & "00";
    
    M3: Mux3to1 port map(
                    sel => s_PCSource,
                    c => s_tmp,
                    b => s_ALUout,
                    a => s_result, 
                    z => s_PCSource
                    );

end MesmoTOP;
