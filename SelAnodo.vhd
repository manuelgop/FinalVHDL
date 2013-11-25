library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SelAnodo is
	port( Sel : in STD_LOGIC_VECTOR(1 downto 0);
			Anodo : out STD_LOGIC_VECTOR(3 downto 0));
end SelAnodo;

architecture Behavioral of SelAnodo is

begin

	with Sel select
	Anodo <= "1110" when "00",
				"1101" when "01",
				"1011" when "10",
				"0111" when others;
				
end Behavioral;