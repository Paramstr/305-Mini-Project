library IEEE;
use IEEE.std_logic_1164.all;   
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BCD_counter is
Port(Clk, Direction, Enable, init: in std_logic;
Q: out std_logic_vector(3 downto 0));
end entity BCD_counter;


architecture counting of BCD_counter is
signal counter: std_logic_vector(3 downto 0):= "0000";
begin
process(Clk)
begin
if(Clk'event and Clk = '1') then
	if (init = '1') then
		if (direction = '1') then
			counter<= "0000";
		else 
			counter<= "1001";
		end if;
	elsif(enable = '1') then
		if (direction = '1') then
			if (counter >=0 and counter<9) then
				counter<=counter+1;
			else
				counter <="0000";
			end if;
		elsif(direction = '0') then
			if (counter>0 and counter<=9) then
				counter<= counter-1;
			else
				counter<="1001";
			end if;
		end if;
	end if;
end if;
end process;
Q<=counter;
end architecture counting;