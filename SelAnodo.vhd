
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SelAnodo is
	port( Sel   : in   STD_LOGIC_VECTOR (1 downto 0);
			Anodo : out  STD_LOGIC_VECTOR (3 downto 0));
end SelAnodo;

architecture Behavioral of SelAnodo is

begin
	with Sel select
      Anodo <= "0111" when "00",
					"1011" when "01",
					"1101" when "10",
					"1110" when others;
end Behavioral;

