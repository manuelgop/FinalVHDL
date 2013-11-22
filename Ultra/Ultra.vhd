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
    Port ( Input     : in    STD_LOGIC;
           Output    : out   STD_LOGIC;
			  Rst       : in    STD_LOGIC;
			  Clk100MHz : in    STD_LOGIC);
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

-- Embedded Signals
signal c_dist      : STD_LOGIC_VECTOR (14 downto 0);
signal Clk1MHz_int : STD_LOGIC;

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
					  
end Behavioral;