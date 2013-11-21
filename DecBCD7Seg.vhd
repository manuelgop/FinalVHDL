library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecBCD7Seg is
	port( BCD : in  STD_LOGIC_VECTOR (3 downto 0);
			Seg : out STD_LOGIC_VECTOR (7 downto 0));
end DecBCD7Seg;

architecture Behavioral of DecBCD7Seg is

begin
	with BCD select
		Seg <= not x"7E" when x"0",
				 not x"30" when x"1",
				 not x"6D" when x"2",
				 not x"79" when x"3",
				 not x"33" when x"4",
				 not x"5B" when x"5",
				 not x"5F" when x"6",
				 not x"70" when x"7",
				 not x"7F" when x"8",
				 not x"7B" when x"9",
				 not x"77" when x"A",
				 not x"1F" when x"B",
				 not x"4E" when x"C",
				 not x"3D" when x"D",
				 not x"4F" when x"E",
				 not x"47" when others;
end Behavioral;

