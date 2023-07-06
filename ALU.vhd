
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ALU is
generic(WIDTH: positive := 32);
 Port (SrcA: in std_logic_vector(WIDTH-1 downto 0);
       SrcB: in std_logic_vector(WIDTH-1 downto 0);
       ALUControl: in std_logic_vector(3 downto 0);
       shamt5: in std_logic_vector(4 downto 0);
       ALUFlags: out std_logic_vector(3 downto 0);
       ALUResult: out std_logic_vector(WIDTH-1 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

process(SrcA,SrcB,ALUControl,shamt5)
variable temp_A: unsigned(WIDTH+1 downto 0);
variable temp_B: unsigned(WIDTH+1 downto 0);
variable temp_Sum: unsigned(WIDTH+1 downto 0);
variable B_unsigned: unsigned(WIDTH-1 downto 0);
variable B_signed: signed(WIDTH-1 downto 0);
variable temp_shamt5: natural range 0 to 31;
variable Cout: std_logic;
variable temp_result: std_logic_vector(WIDTH-1 downto 0);

begin
temp_shamt5 := to_integer(unsigned(shamt5));
B_unsigned := unsigned (SrcB);
B_signed := signed (SrcB);

case ALUControl is

when "0000" =>                                                                                   -- ADD
temp_A:= unsigned('0' & SrcA(WIDTH-1) & SrcA);
temp_B := unsigned('0' & SrcB(WIDTH-1) & SrcB);
temp_sum := temp_A + temp_B;
temp_result := std_logic_vector(temp_sum(WIDTH-1 downto 0));
Cout := temp_sum(WIDTH+1);
ALUFlags(0) <= (not ALUControl(1)) and (temp_result(WIDTH-1) xor SrcA(WIDTH-1)) and (not(SrcA(WIDTH-1) xor SrcB(WIDTH-1) xor ALUControl(0)));   -- oVerflow
ALUFlags(1) <= (not ALUControl(1)) and Cout;                                                                                                    -- Carry
                                                                                                
when "0001" =>                                                                                   -- SUB
temp_A := unsigned('0' & SrcA(WIDTH-1) & SrcA);
temp_B := unsigned('0' & SrcB(WIDTH-1) & SrcB);
temp_sum := temp_A - temp_B;
temp_result := std_logic_vector(temp_sum(WIDTH-1 downto 0));
Cout := temp_sum(WIDTH+1);
ALUFlags(0) <= (not ALUControl(1)) and (temp_result(WIDTH-1) xor SrcA(WIDTH-1)) and (not(SrcA(WIDTH-1) xor SrcB(WIDTH-1) xor ALUControl(0)));   -- oVerflow
ALUFlags(1) <= (not ALUControl(1)) and Cout;                                                                                                    -- Carry
                                                                                                 
when "0010" => temp_result := SrcA and SrcB;                                                     -- AND
when "0011" => temp_result := SrcA or SrcB;                                                      -- OR
when "0100" => temp_result := SrcB;                                                              -- MOV
when "0101" => temp_result := not SrcB;                                                          -- MVN
when "0110" => temp_result := SrcA xor SrcB;                                                     -- XOR
when "0111" => temp_result := SrcA xor SrcB;                                                     -- XOR
when "1000" => temp_result := std_logic_vector(SHIFT_LEFT (B_unsigned, temp_shamt5));            -- LSL
when "1001" => temp_result := std_logic_vector(SHIFT_RIGHT (B_unsigned, temp_shamt5));           -- LSR
when "1010" => temp_result := std_logic_vector(SHIFT_RIGHT (B_signed, temp_shamt5));             -- SASR
when "1011" => temp_result := std_logic_vector(ROTATE_RIGHT (B_signed, temp_shamt5));            -- ROR
when "1100" => temp_result := std_logic_vector(SHIFT_LEFT (B_unsigned, temp_shamt5));            -- LSL
when "1101" => temp_result := std_logic_vector(SHIFT_RIGHT (B_unsigned, temp_shamt5));           -- LSR
when "1110" => temp_result := std_logic_vector(SHIFT_RIGHT (B_signed, temp_shamt5));             -- SASR
when "1111" => temp_result := std_logic_vector(ROTATE_RIGHT (B_signed, temp_shamt5));            -- ROR
when others => null;
end case;
        
if unsigned(temp_result) = 0 then ALUFlAgs(2) <= '1';                            -- Zero
else ALUFlAgs(2) <= '0'; 
end if;
        
ALUFlAgs(3) <= temp_result(WIDTH-1);                                             -- Negative
ALUResult <= temp_result;

end process;
end Behavioral;
