
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity WELogic is
Port(op: in std_logic_vector(1 downto 0);
     SL: in std_logic;
     Instr_24: in std_logic;
     NoWrite_in: in std_logic;
     MemWrite_in: out std_logic;
     FlagsWrite_in: out std_logic;
     RegWrite_in: out std_logic);
end WELogic;

architecture Behavioral of WELogic is

begin

process(op,SL,Instr_24,NoWrite_in)
begin

case op is 
when "00"=>
	if (SL = '1') then FlagsWrite_in<= '1';
	else FlagsWrite_in<= '0'; 
	end if;
	
	if (NoWrite_in = '1') then RegWrite_in <= '0';
	else RegWrite_in <= '1';
	end if;
	
	MemWrite_in <= '0';

when "01" =>
	if (SL = '1') then 
		RegWrite_in <= '1';
		MemWrite_in <= '0';
	else
		RegWrite_in <= '0';
		MemWrite_in <= '1';
	end if;
	
	FlagsWrite_in <= '0';

when "10"=> 
	if (Instr_24 = '0') then
		RegWrite_in <= '0';
		MemWrite_in <= '0';
	else
		RegWrite_in <= '1';
		MemWrite_in <= '0';
	end if;
	
	FlagsWrite_in <= '0';

when others => null;
end case;

end process;

end Behavioral;
