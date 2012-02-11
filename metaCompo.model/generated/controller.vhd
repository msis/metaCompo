LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY controller IS 
	PORT (
		ctrl_clk : in std_logic;
		ctrl_rst : in std_logic;
		sig_in : in std_logic;
		data_lo_ld : out std_logic;
		data_hi_ld : out std_logic;
		data_out_ld : out std_logic;
		sig_out : out std_logic
		);
END controller;

ARCHITECTURE rtl OF controller IS



BEGIN 

	

END ARCHITECTURE rtl;
	