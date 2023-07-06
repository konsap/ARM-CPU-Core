
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Reg_File is
generic(N: positive := 4;
        M: positive := 32);
 Port (CLK: in std_logic;
       WE: in std_logic;
       ADDR_R1: in std_logic_vector(N-1 downto 0);
       ADDR_R2: in std_logic_vector(N-1 downto 0);
       R15: in std_logic_vector(M-1 downto 0);
       WD: in std_logic_vector(N-1 downto 0);
       D_in: in std_logic_vector(M-1 downto 0);
       RD1: out std_logic_vector(M-1 downto 0);
       RD2: out std_logic_vector(M-1 downto 0));
end Reg_File;

architecture Behavioral of Reg_File is
type RegFile_Array is array ((2**N)-2 downto 0) of std_logic_vector(M-1 downto 0);
signal RegFile: RegFile_Array;

begin
sync_write: process(CLK) begin
    if (CLK ='1' and CLK'event) then
        if (WE='1') then
            if (to_integer(unsigned(WD)) /= 15) then  
                RegFile(to_integer(unsigned(WD))) <= D_in;
            end if;    
        end if;
    end if; 
end process;

RD1 <= R15 when (to_integer(unsigned(ADDR_R1)) = 15) else RegFile(to_integer(unsigned(ADDR_R1))); 
RD2 <= R15 when (to_integer(unsigned(ADDR_R2)) = 15) else RegFile(to_integer(unsigned(ADDR_R2)));  

end Behavioral;
