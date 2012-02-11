LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY registers IS 
	PORT (
		clk : in std_logic;
		rst : in std_logic;
		ld : in std_logic;
		reg_in : in std_logic_vector(n-1 downto 0);
		reg_out : out std_logic_vector(n-1 downto 0)
		);
END registers;

ARCHITECTURE rtl OF registers IS



BEGIN 

	

END ARCHITECTURE rtl;
	