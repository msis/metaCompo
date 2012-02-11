<%
metamodel /metaCompo/model/metaCompo.ecore
%>

<%script type="metaCompo.mComp" name="vhdl" file="<%type%>.vhd"%>
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY <%type%> IS 
	PORT (
<%for (ports){%>		<%name%> : <%io%> <%type%><%if (parent().eAllContents("mPort").nLast()==current()){%><%}else{%>;<%}%>
<%}%>
		);
END <%type%>;

ARCHITECTURE rtl OF <%type%> IS

<%for (eAllContents("mVariable")){%>SIGNAL <%name%> : <%type%>;
<%}%>

<%if (FSMs==null){%>
<%}else{%>
<%for (FSMs){%>

TYPE t_state_FSM<%i()%> IS (<%for (states){%><%name%><%if (parent().eAllContents("mState").nLast()==current()){%><%}else{%>,<%}%><%}%>);
SIGNAL currentState_FSM<%i()%>, nextState_FSM<%i()%> : t_state_FSM<%i()%> := <%initialState.name%>;
<%for (fsmVar){%>SIGNAL <%name%> : <%type%>;<%}%>
<%for (descendant().eAllContents("mVariable")){%>SIGNAL <%name%> : <%type%>;
<%}%>

<%}%>
<%}%>

BEGIN 

<%for (subComps){%>
	<%name%> : ENTITY work.<%type%>(rtl) 
			port map (<%for (ports){%><%connToVar.name%><%connectedTo.name%><%if (parent().eAllContents("mPort").nLast()==current()){%> <%}else{%>, <%}%><%}%>);
<%}%>
	
	<%for (FSMs){%>
	-- clock and reset ports must have been declared
	seq_FSM_<%name%> : PROCESS(clock,reset) IS
	BEGIN
		IF reset = '0' THEN
			currenState_FSM<%i()%> <= <%initialState.name%>;
		ELSE
			IF (rising_edge(clock)) THEN
				currentState_FSM<%i()%> <= nextState_FSM<%i()%>;
			END IF;
		END IF;
	END PROCESS seq_FSM_<%name%> ;
	
	<%name%> : PROCESS (<%for (states){%><%for (outgoingTransitions){%><%for (trigerringVar){%><%name%>,<%}%><%for (triggeringPort){%><%name%>,<%}%><%}%><%}%>currentState_FSM<%i()%>)
	BEGIN
		CASE currentState_FSM<%i()%> IS
<%for (states){%>		WHEN <%name%> =>
<%for (outgoingTransitions){%>		--<%name%>
<%if (triggerExp.equalsIgnoreCase(null)){%>
	<%if (guard.equalsIgnoreCase(null)){%>
			<%action%>
			nextState_FSM<%i()%> <= <%destination.name%>;
	<%}else{%>
				IF <%guard%> THEN
					<%action%>
					nextState_FSM<%i()%> <= <%destination.name%>
				END IF;
	<%}%>
<%}else{%>
			IF <%triggerExp%> THEN
	<%if (guard.equalsIgnoreCase(null)){%>
				<%action%>
				nextState_FSM<%i()%> <= <%destination.name%>;
	<%}else{%>
				IF <%guard%> THEN
					<%action%>
					nextState_FSM<%i()%> <= <%destination.name%>
				END IF;
<%}%>
			END IF;
<%}%>
<%}%>
<%}%>
		END CASE;
	END PROCESS <%name%>;
<%}%>

END ARCHITECTURE rtl;
	
   
	 