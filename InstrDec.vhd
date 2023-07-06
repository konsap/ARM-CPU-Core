
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity InstrDec is
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
end InstrDec;

architecture Behavioral of InstrDec is

begin

process(op,funct,shamt5,sh)
variable temp_out: std_logic_vector(10 downto 0);
begin

case op is 

when "00"=>
	case funct is 
--ADD
	when "101000" => temp_out := "00010000000";
	when "101001" => temp_out := "00010000000"; 
	when "001000" => temp_out := "00000000000";
	when "001001" => temp_out := "00000000000";
--SUB
	when "100100" => temp_out := "00010000100"; 
	when "100101" => temp_out := "00010000100";
	when "000100" => temp_out := "00000000100"; 
	when "000101" => temp_out := "00000000100";
--AND
	when "100000" => temp_out := "00010001000";
	when "100001" => temp_out := "00010001000"; 
	when "000000" => temp_out := "00000001000";
	when "000001" => temp_out := "00000001000";
--OR
	when "111000" => temp_out := "00010001100";
	when "111001" => temp_out := "00010001100";
	when "011000" => temp_out := "00000001100";
	when "011001" => temp_out := "00000001100";
--XOR
	when "100010" => temp_out := "00010011000";
	when "100011" => temp_out := "00010011000";
	when "000010" => temp_out := "00000011000";
	when "000011" => temp_out := "00000011000";
--CMP
	when "110101" => temp_out := "00010000101";
	when "010101" => temp_out := "00000000101";
--MVN
	when "111110" => temp_out := "00010010100";
	when "011110" => temp_out := "00000010100";
--MOV
	when "111010" => temp_out := "00010010000";
	
	when "011010"=>
		case sh is 
			when "00"=> 
				if (shamt5="00000") then temp_out:= "00000010000";  --MOV,NOP
				else temp_out:= "00000100000";                      --LSL
				end if;
			when "01"=> temp_out:= "00000100100";                   --LSR
			when "10"=> temp_out:= "00000101000";                   --ASR  
			when "11"=> temp_out:= "00000101100";                   --ROR
			when others=> null;
		end case;
	when others=> null;
	end case;
	
when "01"=>
	case funct is 
	--STR
		when "011000" => temp_out := "01010000000";
		when "010000" => temp_out := "01010000100";
    --LDR
		when "011001" => temp_out := "00010000010";
		when "010001" => temp_out := "00010000110";
		when others=> null; 
	end case;

when "10"=>
	if (funct(4)='0') then temp_out:= "00111000000";  --B
	else temp_out:= "10111000000";                    --BL
	end if;

when others=> null;
end case;

--OUT

RegSrc <= temp_out(10 downto 8);
ALUSrc <= temp_out(7);
ImmSrc <= temp_out(6);
ALUControl <= temp_out(5 downto 2);
MemtoReg <= temp_out(1);
NoWrite_in <= temp_out(0);

end process;

end Behavioral;
