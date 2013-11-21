----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:43:54 11/20/2013 
-- Design Name: 
-- Module Name:    Top - Behavioral 
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

entity Top is
    Port ( Input     : in   STD_LOGIC;
           Output    : out  STD_LOGIC;
			  Seg       : out  STD_LOGIC_VECTOR (7 downto 0);
			  Disp      : out  STD_LOGIC_VECTOR (3 downto 0);
			  Clk100MHz : in   STD_LOGIC);
end Top;

architecture Behavioral of Top is

component SelAnodo
	port (
		Sel   : in  STD_LOGIC_VECTOR(1 downto 0);
		Anodo : out  STD_LOGIC_VECTOR(3 downto 0)
	);
	end component;
	
component DecBCD7Seg
	port (
		BCD : in  STD_LOGIC_VECTOR(3 downto 0);
		Seg : out  STD_LOGIC_VECTOR(7 downto 0)
	);
	end component;
	
component Clk1MHz
	port (
		Rst    : in  STD_LOGIC;
		Clk    : in  STD_LOGIC;
		ClkOut : out STD_LOGIC
	);
	end component;
	
component RefreshDisplay
	port (
		Rst    : in  STD_LOGIC;
		Clk    : in  STD_LOGIC;
		ClkOut : out STD_LOGIC
	);
	end component;

component SenalOut
	port (
		Delay     : in  STD_LOGIC;
		Clk       : in  STD_LOGIC;
		outSignal : out STD_LOGIC
	);
	end component;

component SenalIn
	port (
		Enable : in  STD_LOGIC;
		inSignal : out STD_LOGIC
	);
	end component;
	
	
component Contador
	port (
		Clk      : in STD_LOGIC;
		Enable   : in STD_LOGIC;
		numM     : out STD_LOGIC_VECTOR (3 downto 0);
		numC     : out STD_LOGIC_VECTOR (3 downto 0);
		numD     : out STD_LOGIC_VECTOR (3 downto 0);
		numU     : out STD_LOGIC_VECTOR (3 downto 0)
	);
	end component;	
	
signal Clk_1MHz_int : STD_LOGIC;
signal Output_int   : STD_LOGIC;
signal Input_int    : STD_LOGIC;
signal Rst          : STD_LOGIC;
signal NumM_int     : STD_LOGIC_VECTOR (3 downto 0);
signal NumC_int     : STD_LOGIC_VECTOR (3 downto 0);
signal NumD_int     : STD_LOGIC_VECTOR (3 downto 0);
signal NumU_int     : STD_LOGIC_VECTOR (3 downto 0);
signal Sel_int      : STD_LOGIC_VECTOR (1 downto 0);
signal tiempo_int   : STD_LOGIC_VECTOR (3 downto 0);
signal ClkRefresh_int : STD_LOGIC;
begin

U1 : SelAnodo
	port map (
		Sel   => Sel_int,
		Anodo => Disp
	);

U2 : DecBCD7Seg
	port map (
		BCD => Tiempo_int,
		Seg => Seg
	);

U3 : Clk1MHz
	port map (
		Rst    => Rst,
		Clk    => Clk100MHz,
		ClkOut => Clk_1MHz_int
	);
	
U4 : RefreshDisplay
	port map (
		Rst    => Rst,
		Clk    => Clk100MHz,
		ClkOut => ClkRefresh_int
	);
	
U5 : SenalIn
	port map (
		Enable   => Output_int,
		inSignal => Input_int
	);

U6 : SenalOut
	port map (
		Delay     => Input_int,
		Clk       => Clk_1MHz_int,
		outSignal => Output_int
	);

U7 : Contador
	port map (
		Clk      => Clk_1MHz_int,
		Enable   => Input_int,
		numM     => NumM_int,
		numC     => NumC_int,
		numD     => NumD_int,
		numU     => NumU_int
	);
	

end Behavioral;

