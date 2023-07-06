
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Control is
 Port (Instr: in std_logic_vector(31 downto 0);
       flags: in std_logic_vector(3 downto 0);
       RegSrc: out std_logic_vector(2 downto 0);
       ALUSrc: out std_logic;
       MemtoReg: out std_logic;
       ALUControl: out std_logic_vector(3 downto 0);
       ImmSrc: out std_logic;
       MemWrite: out std_logic;
       FlagsWrite: out std_logic;
       RegWrite: out std_logic;
       PCSrc: out std_logic);
end Control;

architecture Structural of Control is

--COMPONENTS

--instruction decoder
component InstrDec is
Port(op: in std_logic_vector(1 downto 0);
     funct: in std_logic_vector(5 downto 0);
     shamt5: in std_logic_vector(4 downto 0);
     sh: in std_logic_vector(1 downto 0);
     RegSrc: out std_logic_vector(2 downto 0);
     ALUSrc: out std_logic;
     MemtoReg: out std_logic;
     ALUControl: out std_logic_vector(3 downto 0);
     ImmSrc: out std_logic;
     NoWrite_in: out std_logic);
end component;



-- write enable logic
component WELogic is
Port(op: in std_logic_vector(1 downto 0);
     SL: in std_logic;
     Instr_24: in std_logic;
     NoWrite_in: in std_logic;
     MemWrite_in: out std_logic;
     FlagsWrite_in: out std_logic;
     RegWrite_in: out std_logic);
end component;



--pc logic
component PCLogic is
Port (op: in std_logic;
      Rd: in std_logic_vector(3 downto 0);
      RegWrite_in: in std_logic;
      PCSrc_in: out std_logic);
end component;



--cond logic
component CONDLogic is
Port(cond: in std_logic_vector(3 downto 0);
     flags: in std_logic_vector(3 downto 0);
     CondEX_in: out std_logic);
end component;


--SIGNALS
signal NoWrite_in: std_logic;
signal MemWrite_in: std_logic;    
signal RegWrite_in: std_logic;
signal FlagsWrite_in: std_logic;
signal PCSrc_in: std_logic;
signal CondEX_in: std_logic;

 
begin

Instruction_Decoder: InstrDec port map(op=>Instr(27 downto 26),
                                       funct=>Instr(25 downto 20),
                                       shamt5=>Instr(11 downto 7),
                                       sh=>Instr(6 downto 5),
                                       RegSrc=>RegSrc,
                                       ALUSrc=>ALUSrc,
                                       MemtoReg=>MemtoReg,
                                       ALUControl=>ALUControl,
                                       ImmSrc=>ImmSrc,
                                       NoWrite_in=>NoWrite_in);


WE_Logic: WELogic port map(op=>Instr(27 downto 26),
                           SL=>Instr(20),
                           Instr_24=>Instr(24),
                           NoWrite_in=>NoWrite_in,
                           MemWrite_in=>MemWrite_in,
                           FlagsWrite_in=>FlagsWrite_in,
                           RegWrite_in=>RegWrite_in);
                           
                           
PC_Logic: PCLogic port map(op=>Instr(27),Rd=>Instr(15 downto 12),RegWrite_in=>RegWrite_in,PCSrc_in=>PCSrc_in);


Cond_Logic: CONDLogic port map(cond=>Instr(31 downto 28),flags=>Flags,CondEX_in=>CondEX_in);



--Output
MemWrite <= CondEX_in and MemWrite_in;
FlagsWrite <= CondEX_in and FlagsWrite_in;
RegWrite <= CondEX_in and RegWrite_in;
PCSrc <= CondEX_in and PCSrc_in;


end Structural;
