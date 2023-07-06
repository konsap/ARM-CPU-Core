
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Processor_tb is
--  Port ( );
end Processor_tb;

architecture Behavioral of Processor_tb is

component Processor is 
 Port (CLK: in std_logic;
       RESET: in std_logic;
       PC: out std_logic_vector(5 downto 0);
       Instruction: out std_logic_vector(31 downto 0);
       ALUResult: out std_logic_vector(31 downto 0);
       WriteData: out std_logic_vector(31 downto 0);
       Result: out std_logic_vector(31 downto 0));
end component;

--SIGNALS
signal CLK: std_logic;
signal RESET: std_logic;
signal PC: std_logic_vector(5 downto 0);
signal Instruction: std_logic_vector(31 downto 0);
signal ALUResult: std_logic_vector(31 downto 0);
signal WriteData: std_logic_vector(31 downto 0);
signal Result: std_logic_vector(31 downto 0);
constant clkPeriod: time := 13ns;


begin


uut: Processor port map(CLK=>CLK,RESET=>RESET,PC=>PC,Instruction=>Instruction,ALUResult=>ALUResult,WriteData=>WriteData,Result=>Result);


clock: process
begin
    CLK<='0';
    wait for clkPeriod/2;
    CLK<= '1';
    wait for clkPeriod/2;
end process;

process
begin
RESET<='1';
wait for clkPeriod*10;
RESET<='0';
wait;
end process;

end Behavioral;
