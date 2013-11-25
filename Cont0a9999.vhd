library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Cont0a9999 is
	port(	SalSM    : in  STD_LOGIC;
			Enable   : in  STD_LOGIC;
			Rst      : in  STD_LOGIC;
			Clk      : in  STD_LOGIC;
			Millares : out STD_LOGIC_VECTOR(3 downto 0);
			Centenas : out STD_LOGIC_VECTOR(3 downto 0);
			Decenas  : out STD_LOGIC_VECTOR(3 downto 0);
			Unidades : out STD_LOGIC_VECTOR(3 downto 0));
end Cont0a9999;

architecture Behavioral of Cont0a9999 is

--EMBEDDED
signal CountUni : STD_LOGIC_VECTOR (3 downto 0);
signal CountDec : STD_LOGIC_VECTOR (3 downto 0);
signal CountCen : STD_LOGIC_VECTOR (3 downto 0);
signal CountMil : STD_LOGIC_VECTOR (3 downto 0);

begin

-- Count Unidades
process (Rst,Clk,SalSM)
begin
	if ((Rst = '1') or (SalSM = '1')) then CountUni <= (others => '0');
	elsif (rising_edge(Clk)) then
		if (Enable = '1') then
		-- CountUni is reset when unidades = 9
			if (CountUni = "1001") then CountUni <= (others => '0');
			else CountUni <= CountUni + 1;
			end if;
		else CountUni <= CountUni;
		end if;
	end if;
end process;

-- Count Decenas
process (Rst,Clk,SalSM)
begin
	if ((Rst = '1') or (SalSM = '1')) then CountDec <= (others => '0');
	elsif (rising_edge(Clk)) then
		if (Enable = '1') then
		-- CountDec is reset when decenas = 9
			if (CountDec = "1001") then CountDec <= (others => '0');
			-- Only increment the tens when the units reach 9
			elsif (CountUni = "1001") then CountDec <= CountDec + 1;
			end if;
		else CountDec <= CountDec;
		end if;
	end if;
end process;

-- Count Centenas
process (Rst,Clk,SalSM)
begin
	if ((Rst = '1') or (SalSM = '1')) then CountCen <= (others => '0');
	elsif (rising_edge(Clk)) then
		if (Enable = '1') then
		-- CountCen is reset when centenas = 9
			if (CountCen = "1001") then CountCen <= (others => '0');
			-- Only increment the cents when the tens reach 9
			elsif (CountDec = "1001") then CountCen <= CountCen + 1;
			end if;
		else CountCen <= CountCen;
		end if;
	end if;
end process;

-- Count Millares
process (Rst,Clk,SalSM)
begin
	if ((Rst = '1') or (SalSM = '1')) then CountMil <= (others => '0');
	elsif (rising_edge(Clk)) then
		if (Enable = '1') then
		-- CountMil is reset when millares = 9
			if (CountMil = "1001") then CountMil <= (others => '0');
			-- Only increment the millars when the cents reach 9
			elsif (CountCen = "1001") then CountMil <= CountMil + 1;
			end if;
		else CountMil <= CountMil;
		end if;
	end if;
end process;

Unidades <= CountUni;
Decenas  <= CountDec;
Centenas <= CountCen;
Millares <= CountMil;

end Behavioral;

