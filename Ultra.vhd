library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
    Port ( Rst        : in    STD_LOGIC;
			  Clk100MHz  : in    STD_LOGIC;
			  Load       : in    STD_LOGIC;
			  Input      : in    STD_LOGIC;
			  Input2     : in    STD_LOGIC;
           Output     : inout STD_LOGIC;
			  Output2    : inout STD_LOGIC;
			  Disp       : out   STD_LOGIC_VECTOR (3 downto 0);
			  Seg        : out   STD_LOGIC_VECTOR (7 downto 0);
			  OutMotor1  : out   STD_LOGIC_VECTOR (3 downto 0);
			  OutMotor2  : out   STD_LOGIC_VECTOR (3 downto 0);
			  OutMotor3  : out   STD_LOGIC_VECTOR (3 downto 0));
end Top;

architecture Behavioral of Top is

component StateMachine
	port( Rst       : in  STD_LOGIC;
			EnableClk : in  STD_LOGIC;
			Clk		 : in  STD_LOGIC;
			outsig    : out STD_LOGIC);
end component;

component Clk1Hz
	port(	Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			ClkOut : out STD_LOGIC);
end component;

component Clk1MHz
	port(	Rst    : in  STD_LOGIC;
			Clk    : in  STD_LOGIC;
			ClkOut : out STD_LOGIC);
end component;

component Cont0a9999
	port(	SalSM    : in  STD_LOGIC;
			Enable   : in  STD_LOGIC;
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

component FF
	port( Enable : in  STD_LOGIC;
			Clk	 : in  STD_LOGIC;
			Min  	 : in  STD_LOGIC_VECTOR (3 downto 0);
			Cin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Din    : in  STD_LOGIC_VECTOR (3 downto 0);
			Uin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Mout   : out STD_LOGIC_VECTOR (3 downto 0);
			Cout   : out STD_LOGIC_VECTOR (3 downto 0);
			Dout   : out STD_LOGIC_VECTOR (3 downto 0);
			Uout   : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Compare
	port(	Min  	 : in  STD_LOGIC_VECTOR (3 downto 0);
			Cin    : in  STD_LOGIC_VECTOR (3 downto 0);
			Din    : in  STD_LOGIC_VECTOR (3 downto 0);
			Uin    : in  STD_LOGIC_VECTOR (3 downto 0);
			MMin 	 : in  STD_LOGIC_VECTOR (3 downto 0);
			CCin   : in  STD_LOGIC_VECTOR (3 downto 0);
			DDin   : in  STD_LOGIC_VECTOR (3 downto 0);
			UUin   : in  STD_LOGIC_VECTOR (3 downto 0);
			M1     : out STD_LOGIC_VECTOR (3 downto 0);
			M2     : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-- 1 bit Embedded Signals
signal Clk1MHz_int    : STD_LOGIC;
signal ClkRefresh_int : STD_LOGIC;
signal ClkCmHz_int	 : STD_LOGIC;
signal Clk1Hz_int     : STD_LOGIC;

-- 2 bit Embedded Signals
signal Sel_int        : STD_LOGIC_VECTOR (1 downto 0);

-- 3 bit Embedded Signals
signal BCD_M		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_C		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_D		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_U		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_M2		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_C2		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_D2		    : STD_LOGIC_VECTOR (3 downto 0);
signal BCD_U2		    : STD_LOGIC_VECTOR (3 downto 0);
signal Distancia_int  : STD_LOGIC_VECTOR (3 downto 0);
signal perm_M         : STD_LOGIC_VECTOR (3 downto 0);
signal perm_C         : STD_LOGIC_VECTOR (3 downto 0);
signal perm_D         : STD_LOGIC_VECTOR (3 downto 0);
signal perm_U         : STD_LOGIC_VECTOR (3 downto 0);
signal perm_M2        : STD_LOGIC_VECTOR (3 downto 0);
signal perm_C2        : STD_LOGIC_VECTOR (3 downto 0);
signal perm_D2        : STD_LOGIC_VECTOR (3 downto 0);
signal perm_U2        : STD_LOGIC_VECTOR (3 downto 0);
signal l_M2           : STD_LOGIC_VECTOR (3 downto 0);
signal l_C2           : STD_LOGIC_VECTOR (3 downto 0);
signal l_D2           : STD_LOGIC_VECTOR (3 downto 0);
signal l_U2           : STD_LOGIC_VECTOR (3 downto 0);

begin

U1: StateMachine
	port map ( 	Rst       => Rst,
					EnableClk => Clk1MHz_int,
					Clk       => Clk100MHz,
					outsig    => Output);	

U2 : Clk1Hz
	port map (	Rst    => Rst,
					Clk    => Clk100MHz,
					ClkOut => Clk1Hz_int);
					
U3 : Clk1MHz
	port map (	Rst    => Rst,
					Clk    => Clk100MHz,
					ClkOut => Clk1MHz_int);
					
U4	: Cont0a9999
	port map (	SalSM    => Output,
					Enable   => Input,
					Rst      => Rst,
					Clk      => ClkCmHz_int,
					Millares => BCD_M,
					Centenas	=> BCD_C,
					Decenas  => BCD_D,
					Unidades => BCD_U);

U5 : Mux4to1					
	port map (	Millares  => perm_M,
					Centenas  => perm_C,
					Decenas   => perm_D,
					Unidades  => perm_U,
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
					
U11 : FF
	port map (	Enable => Clk1Hz_int,
					Clk    => Clk100MHz,
					Min    => BCD_M,
					Cin    => BCD_C,
					Din    => BCD_D,
					Uin    => BCD_U,
					Mout   => perm_M,
					Cout   => perm_C,
					Dout   => perm_D,
					Uout   => perm_U);

U12 : Cont0a9999
	port map (	SalSM    => Output2,
					Enable   => Input2,
					Rst      => Rst,
					Clk      => ClkCmHz_int,
					Millares => BCD_M2,
					Centenas	=> BCD_C2,
					Decenas  => BCD_D2,
					Unidades => BCD_U2);
					
U13 : FF
	port map (	Enable => Clk1Hz_int,
					Clk    => Clk100MHz,
					Min    => BCD_M2,
					Cin    => BCD_C2,
					Din    => BCD_D2,
					Uin    => BCD_U2,
					Mout   => perm_M2,
					Cout   => perm_C2,
					Dout   => perm_D2,
					Uout   => perm_U2);
					
U14 : FF
	port map (	Enable => Load,
					Clk    => Clk100MHz,
					Min    => perm_M2,
					Cin    => perm_C2,
					Din    => perm_D2,
					Uin    => perm_U2,
					Mout   => l_M2,
					Cout   => l_C2,
					Dout   => l_D2,
					Uout   => l_U2);
					
U15 : Compare
	port map (	Min    => perm_M2,
					Cin    => perm_C2,
					Din    => perm_D2,
					Uin    => perm_U2,
					MMin   => l_M2,
					CCin   => l_C2,
					DDin   => l_D2,
					UUin   => l_U2,
					M1     => OutMotor2,
					M2     => OutMotor3);
					
Output2 <= OutPut;
OutMotor1(0) <= perm_D(2);
OutMotor1(1) <= perm_D(3);
OutMotor1(2) <= perm_C(0);
OutMotor1(3) <= perm_C(1);

end Behavioral;