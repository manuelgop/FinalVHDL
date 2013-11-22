
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4to1 is
	port( NumM    : in  STD_LOGIC_VECTOR (3 downto 0);
			NumC    : in  STD_LOGIC_VECTOR (3 downto 0);
			NumD    : in  STD_LOGIC_VECTOR (3 downto 0);
			NumU    : in  STD_LOGIC_VECTOR (3 downto 0);
			Sel		 : in  STD_LOGIC_VECTOR (1 downto 0);
			Dist    : out STD_LOGIC_VECTOR (3 downto 0));
end Mux4to1;

architecture Behavioral of Mux4to1 is

begin
	with Sel select
      Dist <= NumM when "00",
					 NumC when "01",
					 NumD when "10",
					 NumU when others;
end Behavioral;

