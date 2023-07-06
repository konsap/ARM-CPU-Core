
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PCLogic is
  Port (op: in std_logic;
        Rd: in std_logic_vector(3 downto 0);
        RegWrite_in: in std_logic;
        PCSrc_in: out std_logic);
end PCLogic;

architecture Behavioral of PCLogic is

begin
process(op,Rd,RegWrite_in)
begin
    if (op='0') then
        if Rd="1111" and RegWrite_in='1' then PCSrc_in<='1';
        else PCSrc_in <='0';
        end if;
   else
        PCSrc_in <='1';
   end if;


end process;  

end Behavioral;
