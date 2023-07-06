
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Data_mem is
generic(N: positive := 5;
        M: positive := 32);
  Port (CLK: in std_logic;
        WE: in std_logic;
        ADDR: in std_logic_vector(N-1 downto 0);
        Din: in std_logic_vector(M-1 downto 0);
        Dout: out std_logic_vector(M-1 downto 0));
end Data_mem;

architecture Behavioral of Data_mem is

type ram_array is array (2**N-1 downto 0) of std_logic_vector(M-1 downto 0);
signal ram: ram_array;

begin

process(CLK)
begin
if (CLK = '1' and CLK'event) then
    if (WE = '1') then
        ram(to_integer(unsigned(ADDR))) <= Din;
    end if;
end if;
end process;

Dout <= ram(to_integer(unsigned(ADDR)));


end Behavioral;
