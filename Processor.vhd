
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
 Port (CLK: in std_logic;
       RESET: in std_logic;
       PC: out std_logic_vector(5 downto 0);
       Instruction: out std_logic_vector(31 downto 0);
       ALUResult: out std_logic_vector(31 downto 0);
       WriteData: out std_logic_vector(31 downto 0);
       Result: out std_logic_vector(31 downto 0));
end Processor;

architecture Structural of Processor is

--COMPONENTS

--Datapath
component Datapath is
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
end component;



--Control
component Control is
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
end component;


--SIGNALS
signal RegSrc: std_logic_vector(2 downto 0);   
signal ALUSrc: std_logic;                   
signal MemtoReg: std_logic;                  
signal ALUControl: std_logic_vector(3 downto 0);  
signal ImmSrc: std_logic;                 
signal MemWrite: std_logic;                    
signal FlagsWrite: std_logic;                
signal RegWrite: std_logic;                   
signal PCSrc: std_logic;                      
signal Instr: std_logic_vector(31 downto 0);    
signal Flags: std_logic_vector(3 downto 0);      

  

begin

Datapath_Unit: Datapath port map(CLK=>CLK,                          
                                 RESET=>RESET,                        
                                 RegSrc=>RegSrc,     
                                 ALUSrc=>ALUSrc,                       
                                 MemtoReg=> MemtoReg,                     
                                 ALUControl=>ALUControl, 
                                 ImmSrc=>ImmSrc,                 
                                 MemWrite=>MemWrite,                     
                                 FlagsWrite=>FlagsWrite,                  
                                 RegWrite=>RegWrite,                    
                                 PCSrc=>PCSrc,                       
                                 PC=>PC,        
                                 Instr=>Instr,    
                                 Flags=>Flags,     
                                 ALUResult=>ALUResult,
                                 WriteData=>WriteData,
                                 Result=>Result);
                            
                            
Control_Unit: Control port map(Instr=>Instr,
                               flags=>Flags,
                               RegSrc=>RegSrc,
                               ALUSrc=>ALUSrc,
                               MemtoReg=>MemtoReg,
                               ALUControl=>ALUControl,
                               ImmSrc=>ImmSrc,
                               MemWrite=>MemWrite,
                               FlagsWrite=>FlagsWrite,
                               RegWrite=>RegWrite,
                               PCSrc=>PCSrc); 
                               
                               
--OUTPUT
Instruction <= Instr;                                                         

end Structural;
