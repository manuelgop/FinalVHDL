
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RefreshDisplay is
	port ( Rst    : in  STD_LOGIC;
			 Clk    : in  STD_LOGIC;
			 ClkOut : out STD_LOGIC);
end RefreshDisplay;

architecture Behavioral of RefreshDisplay is
	constant BoardFreq : natural := 50000000;
	constant MaxCount  : natural := 50000; 
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

