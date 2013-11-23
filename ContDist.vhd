library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ContDist is

port(	EnableIn  : in  STD_LOGIC;
		EnableClk : in  STD_LOGIC;
		Rst       : in  STD_LOGIC;
		Clk       : in  STD_LOGIC;
		Cuenta	 : out STD_LOGIC_VECTOR (14 downto 0));

end ContDist;

architecture Behavioral of ContDist is

--EMBEDDED
signal Count : STD_LOGIC_VECTOR (14 downto 0);

begin

	process (Rst, Clk, EnableClk, EnableIn, Count)
	begin
		if Rst = '1' then Count <= (others => '0');
		elsif (rising_edge(Clk) and EnableClk = '1' and EnableIn = '1') then Count <= Count + 1;
		end if;
		Cuenta <= Count;
	end process;

end Behavioral;

