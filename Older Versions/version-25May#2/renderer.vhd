library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity renderer is
PORT(clk: in std_logic;
background, pipe_on, pipe_on2, pipe_on3, pipe_on4, bird_on, ground_on, rom_mux_output: in std_logic;
heart_on, score_on: in std_logic;
red_out, green_out, blue_out: out std_logic);
end entity renderer;


architecture behaviour of renderer is
begin
process(clk, pipe_on, pipe_on2, bird_on, ground_on)
begin
if(bird_on = '1') then
red_out<= '1';
green_out<='1';
blue_out<='0';
elsif(ground_on = '1') then
red_out<= '1';
green_out<='0';
blue_out<='0';

elsif(pipe_on = '1' or pipe_on2 = '1' or pipe_on3 = '1' or pipe_on4 = '1') then
red_out<= '0';
green_out<='1';
blue_out<='0';
elsif(rom_mux_output = '1'and score_on='1') then
    red_out<= '1';
    green_out<='1';
    blue_out<='1';
elsif(rom_mux_output = '1' and heart_on = '1') then
    red_out<= '1';
    green_out<='0';
    blue_out<='0';
elsif(background = '1') then
red_out<= '0';
green_out<='1';
blue_out<='1';
else
red_out<= '0';
green_out<='0';
blue_out<='0';
end if;

end process;
end architecture behaviour;