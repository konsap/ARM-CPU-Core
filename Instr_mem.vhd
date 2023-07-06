
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Instr_mem is
generic (N: positive := 6;
         M: positive := 32);
      
Port (ADDR: in std_logic_vector(N-1 downto 0);
      Instr_out: out std_logic_vector(M-1 downto 0));
end Instr_mem;


architecture Behavioral of Instr_mem is

type rom_array is array (0 to (2**N)-1) of std_logic_vector(M-1 downto 0);
constant rom : rom_array :=(
    X"E3A00000",     --START: MOV R0, #0;  
    X"E3E01000",     --MVN R1, #0;  
    X"E0812000",     --ADD R2, R1, R0; 
    X"E24230FF",     --SUB R3, R2, #255;
    X"E1A00000",     --NOP;
    X"E580200A",     --STR R2, [R0,#10]; 
    X"E590400A",     --LDR R4, [R0,#10]; 
    X"E1A04204",     --LSL R4, R4, #4;
    X"E1A04244",     --ASR R4, R4, #4
    X"E1A04224",     --LSR R4, R4, #4;
    X"E1A04264",     --ROR R4, R4, #4;
    X"E590500A",     --LDR R5, [R0,#10];
    X"E590600A",     --LDR R6, [R0,#10];
    X"E1550006",     --CMP R5,R6;   
    X"02407002",     --SUBEQ R7, R0, #2;
    X"12807002",     --ADDNE R7, R0, #2;
    X"41A08007",     --MOVMI R8, R7;  
    X"EB000001",     --BL FOO;
    X"E1A00000",     --NOP;  
    X"EAFFFFEB",     --B START;
    X"E180B001",     --FOO: ORR R11, R0, R1;        
    X"E000B001",     --AND R11, R0, R1; 
    X"E02BC000",     --EOR R12, R11, R0;
    X"E1A0F00E",     --MOV PC, LR;
    X"00000000",  
    X"00000000",  
    X"00000000", 
    X"00000000",  
    X"00000000",  
    X"00000000",
    X"00000000",
    X"00000000",   
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",    
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000");


begin

Instr_out <= rom(to_integer(unsigned(ADDR)));

end Behavioral;
