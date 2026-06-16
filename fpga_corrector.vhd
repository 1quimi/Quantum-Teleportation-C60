-- Pulse corrector: 100 ns delay, 10 ns pulse width (200 MHz clock)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulse_corrector is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           result_in : in  STD_LOGIC_VECTOR (1 downto 0);
           pulse_out : out STD_LOGIC;
           phase_sel : out STD_LOGIC_VECTOR (1 downto 0)
         );
end pulse_corrector;

architecture Behavioral of pulse_corrector is
    type state_type is (IDLE, DELAY, PULSE);
    signal state : state_type;
    signal counter : integer range 0 to 31;
    signal result_latch : STD_LOGIC_VECTOR(1 downto 0);
    signal result_sync1, result_sync2 : STD_LOGIC_VECTOR(1 downto 0);
begin
    -- Input synchronizer (double flip‑flop)
    process(clk)
    begin
        if rising_edge(clk) then
            result_sync1 <= result_in;
            result_sync2 <= result_sync1;
        end if;
    end process;

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            pulse_out <= '0';
            phase_sel <= "00";
            counter <= 0;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if result_sync2 /= "00" then
                        result_latch <= result_sync2;
                        state <= DELAY;
                        counter <= 0;
                    end if;
                    pulse_out <= '0';
                when DELAY =>
                    if counter < 19 then          -- 20 cycles = 100 ns
                        counter <= counter + 1;
                    else
                        case result_latch is
                            when "00"   => phase_sel <= "00";
                            when "01"   => phase_sel <= "00";
                            when "10"   => phase_sel <= "01";
                            when "11"   => phase_sel <= "10";
                            when others => phase_sel <= "00";
                        end case;
                        pulse_out <= '1';
                        state <= PULSE;
                        counter <= 0;
                    end if;
                when PULSE =>
                    if counter < 1 then            -- 2 cycles = 10 ns
                        counter <= counter + 1;
                    else
                        pulse_out <= '0';
                        state <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
