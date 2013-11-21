library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clk1Hz is
	port ( Rst    : in  STD_LOGIC;
			 Clk    : in  STD_LOGIC;
			 ClkOut : out STD_LOGIC);
end Clk1Hz;

architecture Behavioral of Clk1Hz is
	constant BoardFreq : natural := 50000000;
	constant MaxCount  : natural := BoardFreq; 
	signal FreqCounter : natural range 0 to (MaxCount - 1);
begin
  FreqDiv: process(Clk,Rst)
  begin
    if Rst = '1' then
	   FreqCounter <= 0;
		ClkOut      <= '0';
	  elsif rising_edge(Clk) then
		 if (FreqCounter = (MaxCount - 1)) then
		   FreqCounter <= 0; 
		   ClkOut     <= '1'; 
		 else
		   FreqCounter <= FreqCounter + 1;
			ClkOut     <= '0'; 
		end if;
    end if;
  end process FreqDiv;
end Behavioral;

