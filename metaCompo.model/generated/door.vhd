LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY door IS 
	PORT (
		key : in std_logic;
		lock : out std_logic
		);
END door;

ARCHITECTURE rtl OF door IS



TYPE t_state_FSM0 IS (locked,unlocked);
SIGNAL currentState_FSM0, nextState_FSM0 : t_state_FSM0 := locked;


BEGIN 

	
	seq_FSM_main : PROCESS(clock,reset) IS
	BEGIN
		IF reset = '0' THEN
			currenState_FSM0 <= locked;
		ELSE
			IF (rising_edge(clock)) THEN
				currentState_FSM0 <= nextState_FSM0;
			END IF;
		END IF;
	END PROCESS seq_FSM_main ;
	
	main : PROCESS (key,key,currentState_FSM0)
	BEGIN
		CASE currentState_FSM0 IS
		WHEN locked =>
		--unlocking
			IF key = '1' THEN
				lock <= '0';
				nextState_FSM0 <= unlocked;
			END IF;
		WHEN unlocked =>
		--locking
			IF key = '0' THEN
				lock <= '1';
				nextState_FSM0 <= locked;
			END IF;
		END CASE;
	END PROCESS main;

END ARCHITECTURE rtl;
	