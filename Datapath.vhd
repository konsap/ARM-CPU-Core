
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Datapath is
 Port (CLK: in std_logic;
       RESET: in std_logic;
       RegSrc: in std_logic_vector(2 downto 0);
       ALUSrc: in std_logic;
       MemtoReg: in std_logic;
       ALUControl: in std_logic_vector(3 downto 0);
       ImmSrc: in std_logic;
       MemWrite: in std_logic;
       FlagsWrite: in std_logic;
       RegWrite: in std_logic;
       PCSrc: in std_logic;
       PC: out std_logic_vector(5 downto 0);
       Instr: out std_logic_vector(31 downto 0);
       Flags: out std_logic_vector(3 downto 0);
       ALUResult: out std_logic_vector(31 downto 0);
       WriteData: out std_logic_vector(31 downto 0);
       Result: out std_logic_vector(31 downto 0));
end Datapath;

architecture Structural of Datapath is

--Components


--mux 2 to 1
component mux_2to1 is
generic(WIDTH : positive := 32);
port(CTRL: in STD_LOGIC;
	 Din_1: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	 Din_2: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	 Dout: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end component;



--program counter
component PC_reg is 
generic (WIDTH : positive := 32);
   Port (CLK : in STD_LOGIC;
         RESET : in STD_LOGIC;
         Din : in std_logic_vector(WIDTH-1 downto 0);
         Dout : out std_logic_vector(WIDTH-1 downto 0));
end component;



--pc + 4
component Add_4 is
Port (Din : in STD_LOGIC_VECTOR (31 downto 0);
      Dout : out STD_LOGIC_VECTOR (31 downto 0));
end component;



--instruction memory
component Instr_mem is
generic (N: positive := 6;
         M: positive := 32);
      
Port (ADDR: in std_logic_vector(N-1 downto 0);
      Instr_out: out std_logic_vector(M-1 downto 0));
end component;



--register file
component Reg_File is
generic(N: positive := 4;
        M: positive := 32);
 Port (CLK: in std_logic;
       WE: in std_logic;
       ADDR_R1: in std_logic_vector(N-1 downto 0);
       ADDR_R2: in std_logic_vector(N-1 downto 0);
       R15: in std_logic_vector(M-1 downto 0);
       WD: in std_logic_vector(N-1 downto 0);
       D_in: in std_logic_vector(M-1 downto 0);
       RD1: out std_logic_vector(M-1 downto 0);
       RD2: out std_logic_vector(M-1 downto 0));
end component;



--extend 
component Extend is
Port (Instr: in std_logic_vector(23 downto 0);
      ImmSrc: in std_logic;
      ExtImm: out std_logic_vector(31 downto 0));
end component;



--alu
component ALU is
generic(WIDTH: positive := 32);
 Port (SrcA: in std_logic_vector(WIDTH-1 downto 0);
       SrcB: in std_logic_vector(WIDTH-1 downto 0);
       ALUControl: in std_logic_vector(3 downto 0);
       shamt5: in std_logic_vector(4 downto 0);
       ALUFlags: out std_logic_vector(3 downto 0);
       ALUResult: out std_logic_vector(WIDTH-1 downto 0));
end component;


--status register
component Status_Reg is 
generic (WIDTH : positive := 4);
   Port (CLK : in STD_LOGIC;
         RESET : in STD_LOGIC;
         WE : in STD_LOGIC;
         Din : in std_logic_vector(WIDTH-1 downto 0);
         Dout : out std_logic_vector(WIDTH-1 downto 0));
end component;

        

--data memory
component Data_mem is
generic(N: positive := 5;
        M: positive := 32);
  Port (CLK: in std_logic;
        WE: in std_logic;
        ADDR: in std_logic_vector(N-1 downto 0);
        Din: in std_logic_vector(M-1 downto 0);
        Dout: out std_logic_vector(M-1 downto 0));
end component;



--SIGNALS
signal PCN: std_logic_vector(31 downto 0);
signal temp_PC: std_logic_vector(31 downto 0);
signal PCplus4: std_logic_vector(31 downto 0);
signal Instr_out: std_logic_vector(31 downto 0);
signal PCplus8: std_logic_vector(31 downto 0);
signal RA1: std_logic_vector(3 downto 0);
signal RA2: std_logic_vector(3 downto 0);
signal WA: std_logic_vector(3 downto 0);
signal temp_result: std_logic_vector(31 downto 0);
signal WD3: std_logic_vector(31 downto 0);
signal SrcA: std_logic_vector(31 downto 0);
signal RD2: std_logic_vector(31 downto 0);
signal ExtImm: std_logic_vector(31 downto 0);
signal SrcB: std_logic_vector(31 downto 0);
signal temp_flags: std_logic_vector(3 downto 0);
signal temp_ALU_result: std_logic_vector(31 downto 0);
signal Ram_out: std_logic_vector(31 downto 0);




begin

Programm_Counter:    PC_Reg generic map(32) port map(CLK => CLK, RESET => RESET, Din => PCN, Dout => temp_PC);
Instruction_Memory:  Instr_mem generic map(6,32) port map(ADDR => temp_PC(7 downto 2), Instr_out => Instr_out);
PC_plus_4:           Add_4 port map(Din => temp_PC, Dout => PCplus4);
PC_plus_8:           Add_4 port map(Din => PCplus4, Dout => PCplus8);
RA1_mux:             mux_2to1 generic map(4)  port map(CTRL=>RegSrc(0),Din_1=>Instr_out(19 downto 16),Din_2=>"1111",Dout=>RA1);
RA2_mux:             mux_2to1 generic map(4)  port map(CTRL=>RegSrc(1),Din_1=>Instr_out(3 downto 0),Din_2=>Instr_out(15 downto 12),Dout=>RA2);
WA_mux:              mux_2to1 generic map(4)  port map(CTRL=>RegSrc(2),Din_1=>Instr_out(15 downto 12),Din_2=>"1110",Dout=>WA);
WD3_mux:             mux_2to1 generic map(32) port map(CTRL=>RegSrc(2),Din_1=>temp_result,Din_2=>PCplus4,Dout=>WD3);
Register_file:       Reg_File generic map(4,32) port map(CLK=>CLK,WE=>RegWrite,ADDR_R1=>RA1,ADDR_R2=>RA2,R15=>PCplus8,WD=>WA,D_in=>WD3,RD1=>SrcA,RD2=>RD2);
Extend_Unit:         Extend port map(Instr=>Instr_out(23 downto 0),ImmSrc=>ImmSrc,ExtImm=>ExtImm);
SrcB_mux:            mux_2to1 generic map(32) port map(CTRL=>ALUSrc,Din_1=>RD2,Din_2=>ExtImm,Dout=>SrcB);
ALU_Unit:            ALU generic map(32) port map(SrcA=>SrcA,SrcB=>SrcB,ALUControl=>ALUControl,shamt5=>Instr_out(11 downto 7),ALUFlags=>temp_flags,ALUResult=>temp_ALU_result);
Status_Register:     Status_Reg generic map(4) port map(CLK=>CLK,RESET=>RESET,WE=>FlagsWrite,Din=>temp_flags,Dout=>Flags);
Data_Memory:         Data_mem generic map(5,32) port map(CLK=>CLK,WE=>MemWrite,ADDR=>temp_ALU_result(6 downto 2),Din=>RD2,Dout=>Ram_out);
MemtoReg_mux:        mux_2to1 generic map(32) port map(CTRL=>MemtoReg,Din_1=>temp_ALU_result,Din_2=>Ram_out,Dout=>temp_result);
PCSrc_mux:           mux_2to1 generic map(32) port map(CTRL => PCSrc, Din_1 => PCplus4, Din_2 => temp_result, Dout => PCN);   


Instr <= Instr_out;
PC <= temp_PC(7 downto 2);
ALUResult <= temp_ALU_result;
WriteData <= RD2;
Result <= temp_result;


end Structural;
