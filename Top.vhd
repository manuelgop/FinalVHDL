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
    Port ( Input     : inout   STD_LOGIC;
           Output    : inout   STD_LOGIC;
			  Rst       : in   STD_LOGIC;
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
	
component ContDist
	port(	
		EnableIn  : in  STD_LOGIC;
		EnableClk : in  STD_LOGIC;
		Rst       : in  STD_LOGIC;
		Clk       : in  STD_LOGIC;
		Cuenta	 : out STD_LOGIC_VECTOR (14 downto 0)
	);
	end component;
	
component StateMachine
	port( 
		Rst       : in  STD_LOGIC;
		EnableClk : in  STD_LOGIC;
		Clk       : in  STD_LOGIC;
		cdist     : in  STD_LOGIC_VECTOR (14 downto 0);
		outsig    : out STD_LOGIC
	);
	end component;
	
component Cont0a3
	port (
		Clk      : in STD_LOGIC;
		Enable   : in STD_LOGIC;
		Rst      : in STD_LOGIC;
		Cuenta   : out STD_LOGIC_VECTOR (1 downto 0)
	);
end component;	

component Mux4to1
	port( numM    : in  STD_LOGIC_VECTOR (3 downto 0);
			numC    : in  STD_LOGIC_VECTOR (3 downto 0);
			numD    : in  STD_LOGIC_VECTOR (3 downto 0);
			numU    : in  STD_LOGIC_VECTOR (3 downto 0);
			Sel	  : in  STD_LOGIC_VECTOR (1 downto 0);
			Dist    : out STD_LOGIC_VECTOR (3 downto 0));
end component;	
	
signal Clk1Mhz_int        : STD_LOGIC;
signal Sel_int        : STD_LOGIC_VECTOR (1 downto 0);
signal Dist_int       : STD_LOGIC_VECTOR (3 downto 0);
signal ClkRefresh_int : STD_LOGIC;
signal c_dist      : STD_LOGIC_VECTOR (14 downto 0);
signal c_dist_t : STD_LOGIC_VECTOR (3 downto 0);
begin

U1 : SelAnodo
	port map (
		Sel   => Sel_int,
		Anodo => Disp
	);

U2 : DecBCD7Seg
	port map (
		BCD => Dist_int,
		Seg => Seg
	);

U3 : Clk1MHz
	port map (
		Rst    => Rst,
		Clk    => Clk100MHz,
		ClkOut => Clk1Mhz_int
	);
	 
U4 : RefreshDisplay
	port map (
		Rst    => Rst,
		Clk    => Clk100MHz,
		ClkOut => ClkRefresh_int
	);
	
U5 : ContDist
	port map (	
		EnableIn  => Input,
		EnableClk => Clk1Mhz_int,
		Rst       => Rst,
		Clk       => Clk100Mhz,
		Cuenta	 => c_dist
	);
	
U6 : StateMachine
	port map ( 
		Rst       => Rst,
		EnableClk => Clk1Mhz_int,
		Clk       => Clk100Mhz,
		cdist     => c_dist,
		outsig    => output
	);
	
U8 : Cont0a3
	port map (
		Clk     => Clk100Mhz,
		Enable  => ClkRefresh_int,
		Rst     => Rst,
		Cuenta  => Sel_int(1 downto 0)
	);

c_dist_t <= '0' & c_dist (14 downto 12);

U9: Mux4to1
	port map ( numM   => c_dist_t,
				  numC   => c_dist (11 downto 8),
				  numD   => c_dist (7 downto 4), 
				  numU   => c_dist (3 downto 0),
				  Sel    => Sel_int,
				  Dist   => Dist_int);	
					  
end Behavioral;

