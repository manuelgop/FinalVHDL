
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Cont0a3 is
	port( Enable    : in  STD_LOGIC;
			Rst       : in  STD_LOGIC;
			Clk       : in  STD_LOGIC;
			Cuenta    : out STD_LOGIC_VECTOR (1 downto 0));
end Cont0a3;

architecture Behavioral of Cont0a3 is
	signal Cuenta_int : STD_LOGIC_VECTOR (1 downto 0);
begin
	Counter: process(Enable, Rst, Clk, Cuenta_int)
	begin
		if Rst = '1' then
			Cuenta_int <= (others => '0');
		elsif (Enable = '1' and rising_edge(Clk)) then
			case Cuenta_int is
				when "11" => Cuenta_int <= "00"; 
				when others => Cuenta_int <= Cuenta_int + 1; 
			end case;
		end if;
	end process Counter;
	Cuenta <= Cuenta_int; 
end Behavioral;

