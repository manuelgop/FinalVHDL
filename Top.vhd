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
		Clk      : in STD_LOGIC;
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
	
signal Clk_int        : STD_LOGIC;
signal NumM_int       : STD_LOGIC_VECTOR (3 downto 0);
signal NumC_int       : STD_LOGIC_VECTOR (3 downto 0);
signal NumD_int       : STD_LOGIC_VECTOR (3 downto 0);
signal NumU_int       : STD_LOGIC_VECTOR (3 downto 0);
signal Sel_int        : STD_LOGIC_VECTOR (1 downto 0);
signal Dist_int       : STD_LOGIC_VECTOR (3 downto 0);
signal ClkRefresh_int : STD_LOGIC;
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
		ClkOut => Clk_int
	);
	 
U4 : RefreshDisplay
	port map (
		Rst    => Rst,
		Clk    => Clk100MHz,
		ClkOut => ClkRefresh_int
	);
	
U5 : SenalIn
	port map (
		Enable   => Output,
		Clk      => Clk100Mhz,
		inSignal => Input
	);

U6 : SenalOut
	port map (
		Delay     => Input,
		Clk       => Clk_int,
		outSignal => Output
	);

U7 : Contador
	port map (
		Clk      => Clk_int,
		Enable   => Input,
		numM     => NumM_int,
		numC     => NumC_int,
		numD     => NumD_int,
		numU     => NumU_int
	);
	
	
U8 : Cont0a3
	port map (
		Clk     => Clk100Mhz,
		Enable  => ClkRefresh_int,
		Rst     => Rst,
		Cuenta  => Sel_int(1 downto 0)
	);

U9: Mux4to1
	port map ( numM   => numM_int (3 downto 0),
				  numC   => numC_int (3 downto 0),
				  numD   => numD_int (3 downto 0), 
				  numU   => numU_int (3 downto 0),
				  Sel    => Sel_int,
				  Dist   => Dist_int);	
					  
end Behavioral;

