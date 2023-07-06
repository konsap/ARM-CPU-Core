
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Status_Reg is
generic (WIDTH : positive := 4);
   Port (CLK : in STD_LOGIC;
         RESET : in STD_LOGIC;
         WE : in STD_LOGIC;
         Din : in std_logic_vector(WIDTH-1 downto 0);
         Dout : out std_logic_vector(WIDTH-1 downto 0));
end Status_Reg;

architecture Behavioral of Status_Reg is

begin

process(CLK,RESET,WE)
begin
        
    if RESET = '1' then Dout <= (others=>'0');
    elsif WE = '1' and rising_edge(CLK) then Dout<=Din;
    end if;
    
end process;
end Behavioral;
