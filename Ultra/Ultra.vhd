----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:02 11/22/2013 
-- Design Name: 
-- Module Name:    Ultra - Behavioral 
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
    Port ( Input     : in  STD_LOGIC;
           Output    : out STD_LOGIC;
			  Rst       : in  STD_LOGIC;
			  Clk100MHz : in  STD_LOGIC;
			  Disp      : out STD_LOGIC_VECTOR (3 downto 0);
			  Seg       : out STD_LOGIC_VECTOR (7 downto 0));
end Top;

architecture Behavioral of Top is

component StateMachine
	port( Rst       : in  STD_LOGIC;
			EnableClk : in  STD_LOGIC;
			Clk		 : in  STD_LOGIC;
			cdist     : in  STD_LOGIC_VECTOR (14 downto 0);
			outsig    : out STD_LOGIC);
end component;

component ContDist
	port(	EnableIn  : in  STD_LOGIC;
			EnableClk : in  STD_LOGIC;
			Rst       : in  STD_LOGIC;
			Clk       : in  STD_LOGIC;
			Cuenta	 : out STD_LOGIC_VECTOR (14 downto 0));
end component;

component Clk1MHz
	port(	Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			ClkOut : out STD_LOGIC);
end component;

component Cont0a9999
	port(	Enable   : in  STD_LOGIC;
			Rst      : in  STD_LOGIC;
			Clk      : in  STD_LOGIC;
			Millares : out STD_LOGIC_VECTOR(3 downto 0);
			Centenas : out STD_LOGIC_VECTOR(3 downto 0);
			Decenas  : out STD_LOGIC_VECTOR(3 downto 0);
			Unidades : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component Mux4to1
	port( Millares  : in  STD_LOGIC_VECTOR(3 downto 0);
			Centenas  : in  STD_LOGIC_VECTOR(3 downto 0);
			Decenas   : in  STD_LOGIC_VECTOR(3 downto 0);
			Unidades  : in  STD_LOGIC_VECTOR(3 downto 0);
			Sel       : in  STD_LOGIC_VECTOR(1 downto 0);
			Distancia : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component Cont0a3
	port(	Enable : in  STD_LOGIC;
			Rst    : in  STD_LOGIC;  
			Clk    : in  STD_LOGIC;
			Cuenta : out STD_LOGIC_VECTOR(1 downto 0));
end component;

component RefreshDisplay
	port( Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			ClkOut : out STD_LOGIC);
end component;

component SelAnodo
	port( Sel   : in  STD_LOGIC_VECTOR(1 downto 0);
			Anodo : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component DecBCD7Seg
	port(	BCD : in  STD_LOGIC_VECTOR(3 downto 0);
			Seg : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component ClkCmHz
	port(	Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			ClkOut : out STD_LOGIC);
end component;

-- Embedded Signals
signal c_dist         : STD_LOGIC_VECTOR (14 downto 0);
signal Clk1MHz_int    : STD_LOGIC;
signal BCD_M		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_C		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_D		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_U		    : STD_LOGIC_VECTOR (3 downto 0);
signal Sel_int        : STD_LOGIC_VECTOR (1 downto 0);
signal Distancia_int  : STD_LOGIC_VECTOR (3 downto 0);
signal ClkRefresh_int : STD_LOGIC;
signal ClkCmHz_int	 : STD_LOGIC;

begin

U1: StateMachine
	port map ( 	Rst       => Rst,
					EnableClk => Clk1MHz_int,
					Clk       => Clk100MHz,
					cdist     => c_dist,
					outsig    => Output);	

U2 : ContDist
	port map (	EnableIn  => Input,
					EnableClk => Clk1MHz_int,
					Rst       => Rst,
					Clk       => Clk100MHz,
					Cuenta    => c_dist);
					
U3 : Clk1MHz
	port map (	Rst    => Rst,
					Clk    => Clk100MHz,
					ClkOut => Clk1MHz_int);
					
U4	: Cont0a9999
	port map (	Enable   => Input,
					Rst      => Rst,
					Clk      => ClkCmHz_int,
					Millares => BCD_M,
					Centenas	=> BCD_C,
					Decenas  => BCD_D,
					Unidades => BCD_U);

U5 : Mux4to1					
	port map (	Millares  => BCD_M,
					Centenas  => BCD_C,
					Decenas   => BCD_D,
					Unidades  => BCD_U,
					Sel       => Sel_int,
					Distancia => Distancia_int);
					  
U6 : Cont0a3
	port map (	Enable => ClkRefresh_int,
					Rst    => Rst,
					Clk    => Clk100MHz,
					Cuenta => Sel_int);
					  
U7 : RefreshDisplay
	port map (	Rst    => Rst,
					Clk    => Clk100MHz,
					ClkOut => ClkRefresh_int);
				
U8 : SelAnodo
	port map (	Sel   => Sel_int,
					Anodo => Disp);

U9 : DecBCD7Seg
	port map ( 	BCD => Distancia_int,
					Seg => Seg);
U10 : ClkCmHz
	port map (	Rst    => Rst,
					Clk    => Clk100MHz,
					ClkOut => ClkCmHz_int);

end Behavioral;