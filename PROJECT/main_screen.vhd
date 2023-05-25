library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY mainscreen IS
	PORT
		(pb1, pb2, clk, vert_sync, stop: IN std_logic;
          pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);
		  mainscreen_letters_on: OUT std_logic);

END mainscreen;

architecture behavior of mainscreen is

    in_font_row, in_font_col	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
--signals letters

component char_rom is
	PORT
	(
		character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock			: 	IN STD_LOGIC ;
		rom_mux_output		:	OUT STD_LOGIC
	);
end component;
BEGIN    
char_rom_inst : char_rom
  port map (
    clock => clk,           -- clock input
    font_row => in_font_row,    -- font row
    font_col => in_font_col,    --font column
    character_address => letter, --letter to ouput
    rom_mux_output  => mainscreen_letters_on  -- ou
  ); 


BEGIN    
    --once state machine outputs '1', output logic to render FLAPPY BIRD onto the screen

    --output 'F'

    in_font_row <= ""




END behavior;
