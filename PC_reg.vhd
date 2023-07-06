
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PC_reg is
generic (WIDTH : positive := 32);
   Port (CLK : in STD_LOGIC;
         RESET : in STD_LOGIC;
         Din : in std_logic_vector(WIDTH-1 downto 0);
         Dout : out std_logic_vector(WIDTH-1 downto 0));
end PC_reg;

architecture Behavioral of PC_reg is

begin
process(CLK,RESET)
begin
  
    if RESET = '1' then Dout <= (others=>'0');
    elsif rising_edge(CLK) then Dout <= Din;
    end if;
    
end process;

end Behavioral;
