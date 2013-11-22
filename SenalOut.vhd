
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SenalOut is
	port (Delay     : in  STD_LOGIC;
			Clk       : in  STD_LOGIC;
			outSignal : out STD_LOGIC);
end SenalOut;

architecture Behavioral of SenalOut is

begin
outSignal <= '0'; -- Borrar

end Behavioral;

