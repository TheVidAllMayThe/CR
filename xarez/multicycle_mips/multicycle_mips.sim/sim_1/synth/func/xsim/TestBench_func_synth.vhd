-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
-- Date        : Tue Apr  3 14:58:14 2018
-- Host        : david-Lenovo-U31-70 running 64-bit elementary OS 0.4.1 Loki
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               /home/david/Documents/CR/xarez/multicycle_mips/multicycle_mips.sim/sim_1/synth/func/xsim/TestBench_func_synth.vhd
-- Design      : TestBench
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ControlUnit is
end ControlUnit;

architecture STRUCTURE of ControlUnit is
  signal \FSM_onehot_CS[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[10]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[10]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[10]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[10]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[5]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS[6]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_CS_reg_n_0_[10]\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[10]\ : signal is "yes";
  signal \FSM_onehot_CS_reg_n_0_[1]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[1]\ : signal is "yes";
  signal \FSM_onehot_CS_reg_n_0_[2]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[2]\ : signal is "yes";
  signal \FSM_onehot_CS_reg_n_0_[3]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[3]\ : signal is "yes";
  signal \FSM_onehot_CS_reg_n_0_[4]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[4]\ : signal is "yes";
  signal \FSM_onehot_CS_reg_n_0_[5]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[5]\ : signal is "yes";
  signal \FSM_onehot_CS_reg_n_0_[9]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_CS_reg_n_0_[9]\ : signal is "yes";
  signal s_IRWrite : STD_LOGIC;
  attribute RTL_KEEP of s_IRWrite : signal is "yes";
  signal s_MemWrite : STD_LOGIC;
  attribute RTL_KEEP of s_MemWrite : signal is "yes";
  signal s_PCSource : STD_LOGIC_VECTOR ( 1 to 1 );
  attribute RTL_KEEP of s_PCSource : signal is "yes";
  signal s_PCWriteCond : STD_LOGIC;
  attribute RTL_KEEP of s_PCWriteCond : signal is "yes";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[0]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP : string;
  attribute KEEP of \FSM_onehot_CS_reg[0]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[10]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[10]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[1]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[1]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[2]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[2]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[3]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[3]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[4]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[4]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[5]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[5]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[6]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[6]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[7]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[7]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[8]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[8]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_CS_reg[9]\ : label is "e0:00000000001,e1:00000000010,e2:00000001000,e3:00000010000,e4:00000100000,e5:00001000000,e6:00000000100,e7:10000000000,e8:1000,e9:00010000000,e10:00100000000,e11:01000000000";
  attribute KEEP of \FSM_onehot_CS_reg[9]\ : label is "yes";
begin
\FSM_onehot_CS[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \FSM_onehot_CS[10]_i_4_n_0\,
      I1 => \FSM_onehot_CS_reg_n_0_[4]\,
      I2 => \FSM_onehot_CS_reg_n_0_[1]\,
      I3 => s_IRWrite,
      I4 => \FSM_onehot_CS_reg_n_0_[3]\,
      O => \FSM_onehot_CS[0]_i_1_n_0\
    );
\FSM_onehot_CS[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \FSM_onehot_CS_reg_n_0_[9]\,
      I1 => \FSM_onehot_CS_reg_n_0_[2]\,
      I2 => s_IRWrite,
      I3 => \FSM_onehot_CS_reg_n_0_[4]\,
      I4 => \FSM_onehot_CS[10]_i_3_n_0\,
      O => \FSM_onehot_CS[10]_i_1_n_0\
    );
\FSM_onehot_CS[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \FSM_onehot_CS_reg_n_0_[4]\,
      I1 => \FSM_onehot_CS_reg_n_0_[1]\,
      I2 => s_IRWrite,
      I3 => \FSM_onehot_CS_reg_n_0_[3]\,
      I4 => \FSM_onehot_CS[10]_i_4_n_0\,
      O => \FSM_onehot_CS[10]_i_2_n_0\
    );
\FSM_onehot_CS[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \FSM_onehot_CS_reg_n_0_[1]\,
      I1 => \FSM_onehot_CS_reg_n_0_[10]\,
      I2 => s_PCSource(1),
      I3 => s_PCWriteCond,
      I4 => \FSM_onehot_CS_reg_n_0_[5]\,
      I5 => s_MemWrite,
      O => \FSM_onehot_CS[10]_i_3_n_0\
    );
\FSM_onehot_CS[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEEEEFFFFFFFE"
    )
        port map (
      I0 => s_MemWrite,
      I1 => \FSM_onehot_CS_reg_n_0_[5]\,
      I2 => \FSM_onehot_CS_reg_n_0_[10]\,
      I3 => s_PCSource(1),
      I4 => s_PCWriteCond,
      I5 => \FSM_onehot_CS_reg_n_0_[2]\,
      O => \FSM_onehot_CS[10]_i_4_n_0\
    );
\FSM_onehot_CS[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_onehot_CS_reg_n_0_[1]\,
      I1 => s_IRWrite,
      O => \FSM_onehot_CS[2]_i_1_n_0\
    );
\FSM_onehot_CS[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \FSM_onehot_CS_reg_n_0_[3]\,
      I1 => s_IRWrite,
      I2 => \FSM_onehot_CS_reg_n_0_[1]\,
      I3 => \FSM_onehot_CS_reg_n_0_[4]\,
      O => \FSM_onehot_CS[5]_i_1_n_0\
    );
\FSM_onehot_CS[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \FSM_onehot_CS_reg_n_0_[3]\,
      I1 => \FSM_onehot_CS_reg_n_0_[1]\,
      I2 => s_IRWrite,
      O => \FSM_onehot_CS[6]_i_1_n_0\
    );
\FSM_onehot_CS_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => \FSM_onehot_CS[0]_i_1_n_0\,
      Q => s_IRWrite,
      R => '0'
    );
\FSM_onehot_CS_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => \FSM_onehot_CS[10]_i_2_n_0\,
      Q => \FSM_onehot_CS_reg_n_0_[10]\,
      R => '0'
    );
\FSM_onehot_CS_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => s_IRWrite,
      Q => \FSM_onehot_CS_reg_n_0_[1]\,
      R => '0'
    );
\FSM_onehot_CS_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => \FSM_onehot_CS[2]_i_1_n_0\,
      Q => \FSM_onehot_CS_reg_n_0_[2]\,
      R => '0'
    );
\FSM_onehot_CS_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => '0',
      Q => \FSM_onehot_CS_reg_n_0_[3]\,
      R => '0'
    );
\FSM_onehot_CS_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => '0',
      Q => \FSM_onehot_CS_reg_n_0_[4]\,
      R => '0'
    );
\FSM_onehot_CS_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => \FSM_onehot_CS[5]_i_1_n_0\,
      Q => \FSM_onehot_CS_reg_n_0_[5]\,
      R => '0'
    );
\FSM_onehot_CS_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => \FSM_onehot_CS[6]_i_1_n_0\,
      Q => s_MemWrite,
      R => '0'
    );
\FSM_onehot_CS_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => '0',
      Q => s_PCWriteCond,
      R => '0'
    );
\FSM_onehot_CS_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => '0',
      Q => s_PCSource(1),
      R => '0'
    );
\FSM_onehot_CS_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => '0',
      CE => \FSM_onehot_CS[10]_i_1_n_0\,
      D => '0',
      Q => \FSM_onehot_CS_reg_n_0_[9]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TopThatLevel is
end TopThatLevel;

architecture STRUCTURE of TopThatLevel is
begin
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TestBench is
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of TestBench : entity is true;
end TestBench;

architecture STRUCTURE of TestBench is
begin
end STRUCTURE;
