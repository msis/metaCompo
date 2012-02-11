LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY bridge IS 
	PORT (
		clock : in std_logic;
		reset : in std_logic;
		rdy_in : in std_logic;
		data_in : in std_logic_vector(3 downto 0);
		rdy_out : out std_logic;
		data_out : out std_logic_vector(7 downto 0)
		);
END bridge;

ARCHITECTURE rtl OF bridge IS

SIGNAL wire0 : std_logic;
SIGNAL wire1 : std_logic;
SIGNAL wire2 : std_logic;
SIGNAL connection : std_logic_vector(7 downto 0);


BEGIN 

	SREG_1 : ENTITY work.registers(rtl) 
			port map (clock, reset, wire1, data_in, connection);
	SREG_2 : ENTITY work.registers(rtl) 
			port map (clock, reset, wire0, data_in, connection);
	BREG : ENTITY work.registers(rtl) 
			port map (clock, reset, wire2, connection, data_out);
	CTRL : ENTITY work.controller(rtl) 
			port map (clock, reset, rdy_in, wire0, wire1, wire2, rdy_out);
	

END ARCHITECTURE rtl;
	