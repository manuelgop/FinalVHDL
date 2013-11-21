
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4to1 is
	port( DecHor    : in  STD_LOGIC_VECTOR (3 downto 0);
			UniHor    : in  STD_LOGIC_VECTOR (3 downto 0);
			DecMin    : in  STD_LOGIC_VECTOR (3 downto 0);
			UniMin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Sel		 : in  STD_LOGIC_VECTOR (1 downto 0);
			Tiempo    : out STD_LOGIC_VECTOR (3 downto 0));
end Mux4to1;

architecture Behavioral of Mux4to1 is

begin
	with Sel select
      Tiempo <= DecHor when "00",
					 UniHor when "01",
					 DecMin when "10",
					 UniMin when others;
end Behavioral;

