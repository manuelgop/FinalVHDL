library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecBCD7Seg is
	port(	BCD : in STD_LOGIC_VECTOR(3 downto 0);
			Seg : out STD_LOGIC_VECTOR(7 downto 0));
end DecBCD7Seg;

architecture Behavioral of DecBCD7Seg is

begin
	
	with BCD select
	     -- .gfedcba
	Seg <= "11000000" when X"0",
			 "11111001" when X"1",
			 "10100100" when X"2",
			 "10110000" when X"3",
			 "10011001" when X"4",
			 "10010010" when X"5",
			 "10000010" when X"6",
			 "11111000" when X"7",
			 "10000000" when X"8",
			 "10010000" when X"9",
			 "10001000" when X"A",
			 "10000011" when X"B",
			 "11000110" when X"C",
			 "10100001" when X"D",
			 "10000110" when X"E",
			 "10001110" when X"F",
			 "11111111" when others;
			 
end Behavioral;