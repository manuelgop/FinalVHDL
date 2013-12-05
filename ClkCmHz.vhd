library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClkCmHz is

port (	Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			ClkOut : out STD_LOGIC);

end ClkCmHz;

architecture Behavioral of ClkCmHz is

-- CONSTANTS
constant Fosc : integer := 100000000; 	-- Nexys 3 oscilator frequency
constant Fdiv : integer := 17170;		-- Desired frequency
constant CtaMax : integer := Fosc / Fdiv;
-- EMBEDDED
signal Count : integer range 0 to CtaMax;

begin

	process (Rst, Clk)
	begin
		if Rst = '1' then Count <= 0;
		elsif (rising_edge(Clk)) then
			if Count = CtaMax then
				Count <= 0;
				ClkOut <= '1';
			else
				Count <= Count + 1;
				ClkOut<= '0';
			end if;
		end if;
	end process;

end Behavioral;

