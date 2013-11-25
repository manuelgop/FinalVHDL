----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:30:47 11/23/2013 
-- Design Name: 
-- Module Name:    SLVtoBCD - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SLVtoBCD is
port(	binaryIn : in  STD_LOGIC_VECTOR (14 downto 0);
		BCDm		: out STD_LOGIC_VECTOR (3 downto 0);
		BCDc		: out STD_LOGIC_VECTOR (3 downto 0);
		BCDd		: out STD_LOGIC_VECTOR (3 downto 0);
		BCDu		: out STD_LOGIC_VECTOR (3 downto 0));
end SLVtoBCD;

architecture Behavioral of SLVtoBCD is

signal i    : integer;
signal bcd  : STD_LOGIC_VECTOR (15 downto 0);
signal bint : STD_LOGIC_VECTOR (8 downto 0);

begin

bcd  <= (others => '0');
bint <= "111111111";

process (i, bcd, bint)
begin
	for i in 0 to 8 loop -- repeating 9 times.
	
	bcd(15 downto 1) <= bcd(14 downto 0); --shifting the bits.
	bcd(0) <= bint(8);
	bint(8 downto 1) <= bint(7 downto 0);
	bint(0) <= '0';

	if(i < 7 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
	bcd(3 downto 0) <= bcd(3 downto 0) + "0011";
	end if;

	if(i < 7 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
	bcd(7 downto 4) <= bcd(7 downto 4) + "0011";
	end if;

	if((i < 7) and (bcd(11 downto 8) > "0100")) then --add 3 if BCD digit is greater than 4.
	bcd(11 downto 8) <= bcd(11 downto 8) + "0011";
	end if;

	if(i < 7 and bcd(15 downto 12) > "0100") then --add 3 if BCD digit is greater than 4.
	bcd(15 downto 12) <= bcd(15 downto 12) + "0011";
	end if;

	end loop;
end process;

BCDm <= bcd(15 downto 12);
BCDc <= bcd(11 downto  8);
BCDd <= bcd(7  downto  4);
BCDu <= bcd(3  downto  0);

end Behavioral;

