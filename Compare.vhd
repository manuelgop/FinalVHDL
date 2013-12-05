library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Compare is
	port(	Min  	 : in  STD_LOGIC_VECTOR (3 downto 0);
			Cin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Din    : in  STD_LOGIC_VECTOR (3 downto 0);
			Uin    : in  STD_LOGIC_VECTOR (3 downto 0);
			MMin 	 : in  STD_LOGIC_VECTOR (3 downto 0);
			CCin   : in  STD_LOGIC_VECTOR (3 downto 0);
			DDin   : in  STD_LOGIC_VECTOR (3 downto 0);
			UUin   : in  STD_LOGIC_VECTOR (3 downto 0);
			M1     : out STD_LOGIC_VECTOR (3 downto 0);
			M2     : out STD_LOGIC_VECTOR (3 downto 0));
end Compare;

architecture Behavioral of Compare is

--EMBEDDED
signal medida : integer;
signal base   : integer;

begin

medida <= (conv_integer(Min)*1000)+(conv_integer(Cin)*100)+(conv_integer(Din)*10)+(conv_integer(Uin));
base   <= (conv_integer(MMin)*1000)+(conv_integer(CCin)*100)+(conv_integer(DDin)*10)+(conv_integer(UUin));

process (medida,base)
begin
	if (medida < base) then
		M1 <= "1111";
		M2 <= "0000";
	else
		M1 <= "0000";
		M2 <= "1111";
	end if;
end process;

end Behavioral;

