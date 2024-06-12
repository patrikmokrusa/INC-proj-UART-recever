-- uart_rx.vhd: UART controller - receiving (RX) side
-- Author(s): Name Surname (xlogin00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



-- Entity declaration (DO NOT ALTER THIS PART!)
entity UART_RX is
    port(
        CLK      : in std_logic;
        RST      : in std_logic;
        DIN      : in std_logic;
        DOUT     : out std_logic_vector(7 downto 0);
        DOUT_VLD : out std_logic
    );
end entity;



-- Architecture implementation (INSERT YOUR IMPLEMENTATION HERE)
architecture behavioral of UART_RX is
signal cnt : std_logic_vector(7 downto 0);
signal valid : std_logic;
signal clear : std_logic;
begin

    -- Instance of RX FSM
    fsm: entity work.UART_RX_FSM
    port map (
        CLK => CLK,
        RST => RST,
        DIN => DIN,
        cnt => CNT,
        VLD => valid,
        CLEAR => clear
    );
    DOUT_VLD <= valid;

    process (CLK, RST) begin
    	if rising_edge(CLK) then
    		if RST = '1' then
    			DOUT <= "00000000";
    			cnt <= "00000000";
    		else
    			if clear = '1' then
    				DOUT <= "00000000";
    				cnt <= "00000000";
    			end if;
    			if clear = '0' then
    			cnt <= cnt + 1;
    			end if;
    			case cnt is
    				when "00011000" => DOUT(0) <= DIN;
    				when "00101000" => DOUT(1) <= DIN;
    				when "00111000" => DOUT(2) <= DIN;
    				when "01001000" => DOUT(3) <= DIN;
    				when "01011000" => DOUT(4) <= DIN;
    				when "01101000" => DOUT(5) <= DIN;
    				when "01111000" => DOUT(6) <= DIN;
    				when "10001000" => DOUT(7) <= DIN;
    				when others => null;
    			end case;
    		end if;
    	end if;
    		
    end process;

end architecture;
