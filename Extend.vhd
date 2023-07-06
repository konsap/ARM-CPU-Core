
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Extend is
  Port (Instr: in std_logic_vector(23 downto 0);
        ImmSrc: in std_logic;
        ExtImm: out std_logic_vector(31 downto 0));
end Extend;

architecture Behavioral of Extend is

begin
process(Instr,ImmSrc)
    begin
    case ImmSrc is
        when '0' => ExtImm <= X"00000" & Instr(11 downto 0);
        when '1' => ExtImm <= Instr(23) & Instr(23) & Instr(23) & Instr(23) & Instr(23) & Instr(23) & Instr(23 downto 0) & "00";
        when others => null;
    end case;
end process;
end Behavioral;
