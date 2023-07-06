
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity CONDLogic is
Port(cond: in std_logic_vector(3 downto 0);
     flags: in std_logic_vector(3 downto 0);
     CondEX_in: out std_logic);
end CONDLogic;

architecture Behavioral of CONDLogic is

begin

process(cond,flags)
variable N,Z,C,V: std_logic;

begin

N:= flags(3);
Z:= flags(2);
C:= flags(1);
V:= flags(0);

case cond is 
when "0000"=>
	if (Z = '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0001"=>
	if (Z = '0') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0010"=>
	if (C = '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0011"=>
	if (C = '0') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0100"=>
	if (N = '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0101"=>
	if (N = '0') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0110"=>
	if (V = '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "0111"=>
	if (V = '0') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1000"=>
	if ((Z = '0') AND (C = '1')) then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1001"=>
	if ((Z = '1') or (C = '0')) then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1010"=>
	if ((not (N xor V))='1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1011"=>
	if ((N XOR V)= '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1100"=>
	if ((Z = '0') and (not (N XOR V))= '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1101"=>
	if ((Z = '1') or ((N XOR V)) = '1') then CondEx_in <= '1';
	else CondEx_in <= '0';
	end if;

when "1110"=> CondEx_in <= '1';
	
when "1111"=> CondEx_in <= '1';

when others=> null;
end case;

end process;


end Behavioral;
