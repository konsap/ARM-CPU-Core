
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity Add_4 is
    Port ( Din : in STD_LOGIC_VECTOR (31 downto 0);
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end Add_4;

architecture Behavioral of Add_4 is

begin

    Dout <= std_logic_vector(unsigned(Din) + to_unsigned(4,32));  --incr 4

end Behavioral;
