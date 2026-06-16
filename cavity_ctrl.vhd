-- Cavity piezo controller (500 ns on-time)
-- Clock: 200 MHz (5 ns period)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cavity_ctrl is
    Port ( clk        : in  STD_LOGIC;
           start_ent  : in  STD_LOGIC;
           piezo_out  : out STD_LOGIC
         );
end cavity_ctrl;

architecture Behavioral of cavity_ctrl is
    signal counter : integer range 0 to 100;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if start_ent = '1' then
                piezo_out <= '1';
                counter <= 0;
            elsif counter < 100 then   -- 100 * 5 ns = 500 ns
                counter <= counter + 1;
            else
                piezo_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;
