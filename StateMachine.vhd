library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity StateMachine is
	port( Rst       : in  STD_LOGIC;
			EnableClk : in  STD_LOGIC;
			Clk       : in  STD_LOGIC;
			cdist     : in  STD_LOGIC_VECTOR (14 downto 0);
			outsig    : out STD_LOGIC);
end StateMachine;

architecture Behavioral of StateMachine is

-- EMBEDDED and CONSTANTS
	constant TimeMax  : natural := 19450;
	
-- EMBEDDED
	signal period     : natural range 0 to TimeMax;
	signal count      : natural range 0 to TimeMax;
	
-- STATES DEFNITION
	-- default binary state codes
	type   state_values is (ST0,ST1,ST2,ST3);
	signal pres_state, next_state: state_values;

begin
	
-----------------------------------------------------------
-- MODULE 1 StateReg --------------------------------------
-----------------------------------------------------------
-- Process wich describes the Current State Register ------
  statereg: process (Clk,EnableClk,Rst)
  begin
    if (Rst = '1') then 
      pres_state <= ST0;
		count <= 0;
    elsif (rising_edge(Clk) and (EnableClk = '1')) then
		count <= count +1;
		if (count = period) then
			pres_state <= next_state;
			count <= 0;
		end if;
    end if;
  end process statereg;

-----------------------------------------------------------
-- MODULE 2 -----------------------------------------------
-----------------------------------------------------------
-- Upper section of state machine -------------------------
  NextState: process (pres_state,cdist)
  begin
    case pres_state is
      when ST0 =>
        next_state <= ST1;
        period <= 5;
      when ST1 =>    
        next_state <= ST2;
		  period <= 750;
      when ST2 =>
        next_state <= ST3;
        period <= conv_integer(cdist);
      when ST3 =>
        next_state <= ST0;
		  period <= 200;
    end case;
  end process NextState;
  -----------------------------------------------------------

-- MODULE 3 -----------------------------------------------
-----------------------------------------------------------
-- Output section of state machine ------------------------
  process (pres_state)
  begin
    case pres_state is
	   when ST0    => outsig <= '1';
		when ST1    => outsig <= '0';
		when ST2    => outsig <= '0';
		when ST3    => outsig <= '0';
      when others => outsig <= '0';
	 end case;
  end process;

end Behavioral;

