
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clk1MHz is
  port (
    Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 ClkOut : out STD_LOGIC);
end Clk1MHz;

architecture Behavioral of Clk1MHz is
  --Declaraciones de constantes
  constant Fosc    : integer := 100000000;   --Frecuencia del oscilador de tabletas NEXYS 3
  constant Fdiv    : integer := 1000000;     --Frecuencia deseada del divisor
  constant CtaMax  : integer := Fosc / Fdiv; --Cuenta maxima a la que hay que llegar
  --Declaracion de signals
  signal Cont      : integer range 0 to CtaMax;
begin
  --Proceso que Divide la Frecuencia de entrada para obtener una Frecuencia de 1 Hz
  process (Rst, Clk)
  begin
    if Rst = '1' then
	   Cont <= 0;
	 elsif (rising_edge(Clk)) then
	   if Cont = CtaMax then
        Cont <= 0;
        ClkOut <= '1';
      else		  
	     Cont <= Cont + 1;
		  ClkOut<= '0';
		end if;
	end if;
  end process;

end Behavioral;
