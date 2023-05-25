library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY mainscreen IS
	PORT
		pb1, pb2, clk, vert_sync, stop: IN std_logic;
          pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);
		  mainscreen_out: OUT std_logic);

END mainscreen;

architecture behavior of mainscreen is

    in_font_row, in_font_col	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
--signals letters


BEGIN    

    --once state machine outputs '1', output logic to render FLAPPY BIRD onto the screen

    --output 'F'


	mainscreen_out <= '1';




END behavior;
