-- uart_rx_fsm.vhd: UART controller - finite state machine controlling RX side
-- Author(s): Name Surname (xlogin00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity UART_RX_FSM is
    port(
       CLK : in std_logic;
       RST : in std_logic;
       CNT : in std_logic_vector(7 downto 0);
       DIN : in std_logic;
       VLD : out std_logic;
       CLEAR : out std_logic
    );
end entity;



architecture behavioral of UART_RX_FSM is
type STAV is (IDLE, COUNTING, VALID);
signal state : STAV := IDLE;
begin
	process (CLK) begin
		if rising_edge(CLK) then
			if RST = '1' then
				state <= IDLE;
			else
				case state is

				when IDLE => if DIN='0' then
					CLEAR <= '0';
					state <= COUNTING;
					end if;
					if DIN = '1' then
					CLEAR <= '1';
					end if;
				when COUNTING => if CNT ="10011000" then
					state <= VALID;
					VLD <= '1';
					end if;
				when VALID => if CNT = "10011001" then
					VLD <= '0';
					state <= IDLE;

					end if;
				when others => null;
				end case;
			end if;
				
		end if;
	
	end process;


end architecture;
