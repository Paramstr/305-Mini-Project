library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity renderer is
PORT(
clk: in std_logic;
pipe_on, pipe_on2, pipe_on3, pipe_on4, bird_on, ground_on, blackbar: in std_logic; 
rom_hearts, rom_mode, rom_scoreval, rom_score: in std_logic; --Char_om Inputs
currentMode: in std_logic_vector(1 downto 0);
mainscreen_red1, mainscreen_red2   : IN std_logic;	-- Mainscreen Red rectanges
red_out, green_out, blue_out: OUT STD_LOGIC
);

end entity renderer;


architecture behaviour of renderer is
    shared variable state: std_logic := '1';
begin
process(clk, pipe_on, pipe_on2, bird_on, ground_on)
begin
if(currentMode = "01" or currentMode = "10") then --normal mode
    if(bird_on = '1') then
        red_out<= '1';
        green_out<='1';
        blue_out<='0';
    elsif(ground_on = '1') then
        red_out<= '1';
        green_out<='0';
        blue_out<='0';
    elsif(rom_hearts = '1') then
        red_out<= '1';
        green_out<='0';
        blue_out<='0';
    elsif(rom_mode = '1') then
        red_out<= '1';
        green_out<='1';
        blue_out<='1';
    elsif(rom_scoreval = '1') then
        red_out<= '1';
        green_out<='1';
        blue_out<='1';
    elsif(rom_score = '1') then
        red_out<= '1';
        green_out<='1';
        blue_out<='1';
    elsif(blackbar = '1') then
        red_out<= '0';
        green_out<='0';
        blue_out<='0';
    elsif(pipe_on = '1' or pipe_on2 = '1' or pipe_on3 = '1' or pipe_on4 = '1') then
        red_out<= '0';
        green_out<='1';
        blue_out<='0';
    else
    red_out<= '0';
    green_out<='1';
    blue_out<='1';
    end if;
else  --main menu  currentMode = "11"
    if(rom_mode = '1') then 
        red_out<= '1';
        green_out<='1';
        blue_out<='1';
    elsif(mainscreen_red1 = '1') then --outline around training | TODO: need to add signal from FSM to select
        red_out<= '1';
        green_out<='0';
        blue_out<='0';
    elsif(mainscreen_red2 = '1') then --outline around training | TODO: need to add signal from FSM to select
        red_out<= '1';
        green_out<='0';
        blue_out<='0';

    else 
        red_out<= '0';
        green_out<='0';
        blue_out<='0';
    end if;
end if;


end process;
end architecture behaviour;