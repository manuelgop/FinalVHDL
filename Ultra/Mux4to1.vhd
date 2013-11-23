library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4to1 is
	port(	Millares  : in STD_LOGIC_VECTOR(3 downto 0);
			Centenas  : in STD_LOGIC_VECTOR(3 downto 0);
			Decenas   : in STD_LOGIC_VECTOR(3 downto 0);
			Unidades  : in STD_LOGIC_VECTOR(3 downto 0);
			Sel       : in STD_LOGIC_VECTOR(1 downto 0);
			Distancia : out STD_LOGIC_VECTOR(3 downto 0));
end Mux4to1;

architecture Behavioral of Mux4to1 is
begin
--implement multiplexer
	with Sel select
		Distancia <= Unidades when "00",
						 Decenas  when "01",
						 Centenas when "10",
						 Millares when others;
		
end Behavioral;