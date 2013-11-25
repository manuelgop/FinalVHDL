----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:18 11/25/2013 
-- Design Name: 
-- Module Name:    FF - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FF is
	port( Enable : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			Min    : in  STD_LOGIC_VECTOR (3 downto 0);
			Cin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Din    : in  STD_LOGIC_VECTOR (3 downto 0);
			Uin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Mout   : out STD_LOGIC_VECTOR (3 downto 0);
			Cout   : out STD_LOGIC_VECTOR (3 downto 0);
			Dout   : out STD_LOGIC_VECTOR (3 downto 0);
			Uout   : out STD_LOGIC_VECTOR (3 downto 0));
end FF;

architecture Behavioral of FF is

begin

	process (Clk, Enable)
	begin
		if (rising_edge(Clk) and Enable = '1') then 
			Mout <= Min;
			Cout <= Cin;
			Dout <= Din;
			Uout <= Uin;
		end if;
	end process;


end Behavioral;

