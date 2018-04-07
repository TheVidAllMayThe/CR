library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
    port(
        reset  : in std_logic;
        clk    : in std_logic;
        dataIn : in std_logic_vector(31 downto 0);
        dataOut: out std_logic_vector(31 downto 0)
    );
end CPU;

architecture Structural of CPU is
    -- Control unit signals
    signal s_opcode      : std_logic_vector(5 downto 0);
    signal s_PCWrite     : std_logic;
    signal s_IRWrite     : std_logic;
    signal s_IorD        : std_logic;
    signal s_regDst      : std_logic;
    signal s_PCSource    : std_logic_vector(1 downto 0);
    signal s_PCWriteCond : std_logic;
    signal s_memRead     : std_logic;
    signal s_memWrite    : std_logic;
    signal s_memToReg    : std_logic;
    signal s_memEnable   : std_logic;
    signal s_regWrite    : std_logic;
    signal s_ALUSelA     : std_logic;
    signal s_ALUSelB     : std_logic_vector(1 downto 0);
    signal s_ALUOp       : std_logic_vector(1 downto 0);
    signal s_ALUZero     : std_logic;
    signal s_ALUControl  : std_logic_vector(2 downto 0);

    -- Instruction register signals
    signal s_readInstruction : std_logic_vector(31 downto 0);
    signal s_rs, s_rt, s_rd  : std_logic_vector(4 downto 0);
    signal s_shamt           : std_logic_vector(4 downto 0);
    signal s_funct           : std_logic_vector(5 downto 0);
    signal s_imm             : std_logic_vector(15 downto 0);
    signal s_immExt          : std_logic_vector(31 downto 0);
    signal s_immExtShifted   : std_logic_vector(31 downto 0);

    signal s_JTA : std_logic_vector(25 downto 0);
    signal s_pc  : std_logic_vector(31 downto 0);
    
    -- RAM signals
    signal s_address   : std_logic_vector(31 downto 0);
    signal s_readData  : std_logic_vector(31 downto 0);

    -- Data register signals
    signal s_readRegister : std_logic_vector(31 downto 0);
    
    -- Register file signals
    signal s_regWriteEnable : std_logic;
    signal s_writeReg       : std_logic_vector(4 downto 0);
    signal s_regWriteData   : std_logic_vector(31 downto 0);
    signal s_rsData         : std_logic_vector(31 downto 0);
    signal s_rtData         : std_logic_vector(31 downto 0);
    signal s_a              : std_logic_vector(31 downto 0);
    signal s_b              : std_logic_vector(31 downto 0);
    
    -- ALU signals
    signal s_ALUIn1     : std_logic_vector(31 downto 0);
    signal s_ALUIn2     : std_logic_vector(31 downto 0);
    signal s_ALUResult  : std_logic_vector(31 downto 0);
    signal s_ALUOut     : std_logic_vector(31 downto 0);    
begin
    controlUnit: entity work.ControlUnit(Behavioral)
    port map(
        Clock       => clk,
        Reset       => reset,
        OpCode      => s_opcode,
        PCWrite     => s_PCWrite,
        IRWrite     => s_IRWrite,
        IorD        => s_IorD,
        PCSource    => s_PCSource,
        RegDest     => s_regDst,
        PCWriteCond => s_PCWriteCond,
        MemRead     => s_memRead,
        MemWrite    => s_memWrite,
        MemToReg    => s_memToReg,
        ALUSelA     => s_ALUSelA,
        ALUSelB     => s_ALUSelB,
        RegWrite    => s_regWrite,
        ALUop       => s_ALUop
    );
    
    ALUControlUnit: entity work.ALUControlUnit(Behavioral)			 
    port map(
        ALUop      => s_ALUOp,
        funct      => s_funct,
        ALUcontrol => s_ALUControl
    );   

    pc: entity work.PCUpdate(Behavioral)
    port map(
        clk         => clk,
        reset       => reset,
        zero        => s_ALUZero,
        PCSource    => s_PCSource,
        PCWrite     => s_PCWrite,
        PCWriteCond => s_PCWriteCond,
        PC4         => s_ALUResult,
        BTA         => s_ALUOut,
        JTA         => s_JTA,
        pc          => s_pc
    );
    
    -- Choose between PC and previous ALU out
    muxMem: entity work.Mux2to1(Behavioral)
    generic map(N => 32)
    port map(
        sel => s_IorD,
        a   => s_pc,
        b   => s_ALUOut,
        z   => s_address
    );
    
    s_memEnable <= '1' when (s_address(31 downto 8) = X"000000") else '0';
 
    ram: entity work.RAM(Behavioral)
    port map(
        clk       => clk,
        enable    => s_memEnable,
        readEn    => s_memRead,
        writeEn   => s_memWrite,
        address   => s_address(7 downto 2),
        writeData => s_rtData,
        readData  => s_readData
    );

    instructionRegister: entity work.RegisterN(Behavioral)
    port map(
        clk     => clk,
        enable  => s_IRWrite,
        input   => s_readData,
        output  => s_readInstruction
    );
    
    dataRegister: entity work.RegisterN(Behavioral)
    port map(
        clk    => clk,
        enable => '1',
        input  => s_readData,
        output => s_readRegister
    );
    
    -- Split the 32 bits of the instruction into more manageable chunks
    instructionSplitter: entity work.InstrSplitter(Behavioral)
    port map(
        instruction => s_readInstruction,
        opcode      => s_opcode,
        rs          => s_rs,
        rt          => s_rt,
        rd          => s_rd,
        shamt       => s_shamt,
        funct       => s_funct,
        imm         => s_imm,
        JTA         => s_JTA
    );
    
    -- Extend and shift the jump immediate
    signExtender: entity work.SignExtend(Behavioral)
    port map(
        dataIn  => s_imm,
        dataOut => s_immExt
    );
    leftShifter2: entity work.LeftShifter2(Behavioral)
    port map(
        dataIn  => s_immExt,
        dataOut => s_immExtShifted
    );
    
    -- Determine where to read the address of the register to which we will write
    muxReg: entity work.Mux2to1(Behavioral)
    generic map(N => 5)
    port map(
        sel => s_regDst,
        a   => s_rt,
        b   => s_rd,
        z   => s_writeReg
    );

    muxData: entity work.Mux2to1(Behavioral)
    generic map(N => 32)
    port map(
        sel => s_regDst,
        a   => s_readRegister,
        b   => s_ALUOut,
        z   => s_regWriteData
    );
    
    regFile: entity work.RegFile(Structural)
    port map(
        clk         => clk,
        writeEnable => s_regWrite,
        writeReg    => s_writeReg,
        writeData   => s_regWriteData,
        readReg1    => s_rs,
        readReg2    => s_rt,
        readData1   => s_rsData,
        readData2   => s_rtData
    );
    
    a: entity work.RegisterN(Behavioral)
    port map(
        clk    => clk, 
        input  => s_rsData,
        enable => '1',
        output => s_a
    );
    
    b: entity work.RegisterN(Behavioral)
    port map(
        clk    => clk, 
        input  => s_rtData,
        enable => '1',
        output => s_b
    );
    
    -- Choose between A and PC
    muxA: entity work.Mux2to1(Behavioral)
    generic map(N => 32)
    port map(
        sel => s_ALUSelA,
        a   => s_pc,
        b   => s_a,
        z   => s_ALUIn1
    );       
    
    -- Chooses between B, 4, sign extended immediate, and shifted sign extended immediate
    muxB: entity work.Mux4to1(Behavioral)
    generic map(N => 32)
    port map(
        sel => s_ALUSelB,
        a   => s_b,
        b   => X"00000004",
        c   => s_immExt,
        d   => s_immExtShifted,
        z   => s_ALUIn2
    );
    
    -- ALU
    alu: entity work.ALU(Behavioral)
    port map(
        a    => s_ALUIn1,
        b    => s_ALUIn2,
        oper => s_ALUControl,
        res  => s_ALUResult,
        zero => s_ALUZero
    );
    
    -- ALU out
    ALUOut: entity work.RegisterN(Behavioral)
    port map(
        clk    => clk,
        enable => '1',
        input  => s_ALUResult,
        output => s_ALUOut
    );
    
    dataOut <= X"00000000";
end Structural;
