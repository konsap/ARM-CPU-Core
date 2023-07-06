
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2to1 is
generic(WIDTH : positive := 32);
port(CTRL: in STD_LOGIC;
	 Din_1: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	 Din_2: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	 Dout: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end mux_2to1;




architecture Behavioral of mux_2to1 is
begin

Dout <= Din_1 when CTRL ='0' else Din_2;

end Behavioral;
