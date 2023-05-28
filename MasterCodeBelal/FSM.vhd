library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity FSM is
PORT(clk, vert_sync: in std_logic;
SW2: in std_logic;
reset: in std_logic;
death: in std_logic;
gamePause: in std_logic;
mouse_clicked: in std_logic;
enable_collisions: out std_logic;
Mode: out std_logic_vector(1 downto 0));
end entity FSM;


architecture behaviour of FSM is
signal GameIsOn: std_logic;
begin


process(clk)
variable reset_now: std_logic;
begin
if(rising_edge(clk)) then

	if(reset = '1') then
	Mode<="00";
	reset_now:='1';
	end if;
	
	if(reset_now/='1') then
	if(mouse_clicked = '0') then
	Mode<="00";
	elsif(SW2 = '1') then
	Mode<= "10"; ---single player mode
	enable_collisions<='1';
	elsif(SW2 = '0') then
	Mode<= "01";----training mode
	enable_collisions<='0';
	elsif(death = '1') then
	Mode<= "11"; ---death menu
	end if;
	else
	if(mouse_clicked='1') then
	reset_now:='0';
	end if;
	end if;

end if;


end process;

end architecture behaviour;