library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Cont0a3 is
	port( Enable : in  STD_LOGIC;
			Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			Cuenta : out STD_LOGIC_VECTOR(1 downto 0));
end Cont0a3;

architecture Behavioral of Cont0a3 is

--EMBEDDED
signal Count : STD_LOGIC_VECTOR (1 downto 0);

begin

	process (Rst, Clk, Enable,Count)
	begin
		if Rst = '1' then Count <= (others => '0');
		elsif (rising_edge(Clk) and Enable = '1') then Count <= Count + 1;
		end if;
		Cuenta <= Count;
	end process;
	
end Behavioral;