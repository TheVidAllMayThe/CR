

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopThatLevel is
    Port (reset, clock: in std_logic);
end TopThatLevel;

architecture MesmoTOP of TopThatLevel is
    --Global
    constant s_ADDR_BUS_SIZE : positive := 6;
    constant s_DATA_BUS_SIZE : positive := 32;
    signal s_Clock :  std_logic;
    signal s_Reset :  std_logic;
    
    --Control Unit
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
    
    -- PC
    signal s_zero : std_logic;
    signal s_PC4 : std_logic_vector(31 downto 0);
    signal s_BTA : std_logic_vector(31 downto 0);
    signal s_jAddr : std_logic_vector(25 downto 0);
    signal s_pc : std_logic_vector(31 downto 0);

    -- Memory
    signal s_memEnable : std_logic;
    signal s_address : std_logic_vector(31 downto 0);
    signal s_writeData : std_logic_vector(s_DATA_BUS_SIZE-1 downto 0);
    signal s_readData : std_logic_vector(s_DATA_BUS_SIZE-1 downto 0);
    
    -- Registers
    signal s_writeEnable: std_logic;
    signal s_writeReg   : std_logic_vector(4 downto 0);
    signal s_writeData_reg  : std_logic_vector(31 downto 0);
    signal s_readReg1   : std_logic_vector(4 downto 0);
    signal s_readReg2   : std_logic_vector(4 downto 0);
    signal s_readData1  : std_logic_vector(31 downto 0);
    signal s_readData2  : std_logic_vector(31 downto 0);
    
    -- ALU
    signal s_ALUout : std_logic_vector(31 downto 0);
    signal s_result: std_logic_vector(31 downto 0);
    signal s_oper: std_logic_vector(2 downto 0);
    signal s_a : std_logic_vector(31 downto 0);
    signal s_b : std_logic_vector(31 downto 0);
        
    
    -- Splitter
    signal s_instruction : std_logic_vector(31 downto 0);
    signal s_rd : std_logic_vector(4 downto 0);
    signal s_shamt : std_logic_vector(4 downto 0);
    signal s_func : std_logic_vector(5 downto 0);
    signal s_imm : std_logic_vector(15 downto 0);
    
    -- Sign extender
    signal s_imm_ext : std_logic_vector(31 downto 0);
    
    
    -- Registers
    signal s_dataOut : std_logic_vector(31 downto 0);
    signal s_readData1out  : std_logic_vector(31 downto 0);
    signal s_readData2out  : std_logic_vector(31 downto 0);
    
    -- Left shift
    signal s_imm_ext_ls: std_logic_vector(31 downto 0);
    
begin
    U1: entity work.ControlUnit port map(Clock       => clock,
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
                        
                             
    PC: entity work.PCUpdate port map(clk         => clock,
                          reset       => reset,
                          zero        => s_zero,
                          PCSource    => s_PCSource,
                          PCWrite     => s_PCWrite,
                          PCWriteCond => s_PCWriteCond,
                          PC4         => s_result,
                          BTA         => s_ALUOut,
                          jAddr       => s_jAddr,
                          pc          => s_pc);       
    
    
    s_memEnable <= '1' when (s_address(31 downto 8) = X"000000") else '0';
    
    Memory: entity work.RAM port map(clk       => clock,
                         enable    => s_memEnable,     
                         readEn    => s_MemRead,    
                         writeEn   => s_MemWrite,   
                         address   => s_address(s_ADDR_BUS_SIZE+1 downto 2),
                         writeData => s_writeData,
                         readData  => s_readData);
    
    
    Registers: entity work.RegFile port map(
                        clk         => clock,
                        writeEnable => s_RegWrite,
                        writeReg    => s_writeReg,   
                        writeData   => s_writeData_reg,  
                        readReg1    => s_readReg1,   
                        readReg2    => s_readReg2,   
                        readData1   => s_readData1,  
                        readData2   => s_readData2); 
    
    M1 : entity work.Mux2Nto1 generic map(
                        N => 32
                        )
                        
                  port map(
                        sel => s_Iord,
                        a   => s_pc,
                        b   => s_ALUout,
                        z   => s_address
                        );
    
    Splitter: entity work.InstrSplitter port map(
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
                
    M2 : entity work.Mux2Nto1 generic map(
                    N => 5
                    )
                    
                port map(
                    sel => s_regDest,
                    a => s_readReg2,
                    b => s_rd,
                    z => s_writeReg
                );
                
    SignExtender: entity work.SignExtend port map(
                                dataIn => s_imm,
                                dataOut => s_imm_ext);
                                
    
    InstructionRegister: entity work.NBitsRegister port map(
                            input => s_readData,
                            output => s_instruction,
                            enable => s_IRWrite,
                            clk => clock
                            );
    
 
    
    DataRegister: entity work.NBitsRegister port map(
                        input => s_readData,
                        output => s_dataOut,
                        enable => '1',
                        clk => clock
                        );
    
   M3 : entity work.Mux2Nto1 generic map(
                         N => 32
                         )
                         
                     port map(
                         sel => s_MemToReg,
                         a => s_aluOut,
                         b => s_dataOut,
                         z => s_writeData_reg
                     );
    
    RegA : entity work.NBitsRegister port map(
                    input => s_readData1,
                    output => s_readData1out,
                    enable => '1',
                    clk => clock
                    );
    
    RegB : entity work.NBitsRegister port map(
                    input => s_readData2,
                    output => s_writeData,
                    enable => '1',
                    clk => clock
                    );
                        
    
    M4 : entity work.Mux2Nto1 
                generic map(
                    N => 32
                ) 
                port map(
                    sel => s_ALUSelA,
                    a => s_pc,
                    b => s_readData1out,
                    z => s_a
                );
    
    ShiftLeft2: entity work.LeftShifter2 port map(
                    dataIn => s_imm_ext,
                    dataOut => s_imm_ext_ls
                    );
                    
    M5 : entity work.Mux4to1 port map(
                    sel => s_ALUSelB,
                    a => s_writeData,
                    b => "00000000000000000000000000000100",
                    c => s_imm_ext,
                    d => s_imm_ext_ls,
                    z => s_b
                    ); 
    
    ALU : entity work.ALU32 port map(
                    zero => s_zero,
                    a => s_a,
                    b => s_b,
                    res => s_result,
                    oper => s_oper
                    );
                    
    ALUControl: entity work.ALUControlUnit port map(
                    ALUop => s_ALUOp,
                    funct => s_func,
                    ALUcontrol => s_oper
                    );
    
    ALUOut: entity work.NBitsRegister
                 generic map(
                    N => s_DATA_BUS_SIZE
                 )
                 port map(
                    input => s_result,
                    output => s_ALUout,
                    enable => '1',
                    clk => clock
                    );
    
end MesmoTOP;
