----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:05:55 11/22/2013 
-- Design Name: 
-- Module Name:    Contador - Behavioral 
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

entity Contador is
	port (Clk      : in STD_LOGIC;
			Enable   : in STD_LOGIC;
			numM     : out STD_LOGIC_VECTOR (3 downto 0);
			numC     : out STD_LOGIC_VECTOR (3 downto 0);
			numD     : out STD_LOGIC_VECTOR (3 downto 0);
			numU     : out STD_LOGIC_VECTOR (3 downto 0));
end Contador;

architecture Behavioral of Contador is

begin
numM <= "0000";
numC <= "0000";
numD <= "0000";
numU <= "0000";

end Behavioral;

