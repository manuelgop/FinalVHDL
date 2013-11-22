----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:05:46 11/22/2013 
-- Design Name: 
-- Module Name:    SenalIn - Behavioral 
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



entity SenalIn is
	port (Enable : in  STD_LOGIC;
			inSignal : out STD_LOGIC);
end SenalIn;

architecture Behavioral of SenalIn is

begin
inSignal <= Enable; -- Borrar

end Behavioral;

