library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY top_bar IS
	PORT
		(pb1, pb2, clk, vert_sync, stop: IN std_logic;
          pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);
		  reset_behaviour: IN std_logic;
		  reset_after_collision: IN std_logic;
          black_bar: OUT std_logic;
        
        );
END top_bar;

architecture behavior of top_bar is

signal initial: std_logic:='1';

BEGIN    

black_bar<= '1' when((pixel_row>=0 and pixel_row<=40)and (pixel_column>=0 and pixel_column<=640)) else '0';


-- Process to show 'SCORE'
show_scoretext:process(vert_sync)
begin
if (rising_edge(vert_sync)) then	


end process show_scoretext;



-- Process to show 'SCORE VALUE'
show_scorevalue:process(vert_sync)
    begin
    if (rising_edge(vert_sync)) then	

    
end process show_scorevalue;



-- Process to show 'HEALTH'
show_heath:process(vert_sync)

    begin
    if (rising_edge(vert_sync)) then	


end process show_scoretext;



-- Process to show health bars
show_healthbars:process(vert_sync)

    begin
    if (rising_edge(vert_sync)) then	

    
end process show_scoretext;



-- Process to show game mode
show_gamemode:process(vert_sync)

    begin
    if (rising_edge(vert_sync)) then	


end process show_gamemode;

END behavior;