library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY main_screen IS
	PORT
    (
		pb1, pb2, clk, vert_sync : IN std_logic;
          pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);
          clock			: 	IN STD_LOGIC ;
		  mainscreen_out: OUT std_logic);
    );
END main_screen;

ARCHITECTURE SYN OF main_screen IS

    COMPONENT altsyncram
	SIGNAL rom_data		: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL rom_address	: STD_LOGIC_VECTOR (8 DOWNTO 0);

    GENERIC (
		address_aclr_a			: STRING;
		clock_enable_input_a	: STRING;
		clock_enable_output_a	: STRING;
		init_file				: STRING;
		intended_device_family	: STRING;
		lpm_hint				: STRING;
		lpm_type				: STRING;
		numwords_a				: NATURAL;
		operation_mode			: STRING;
		outdata_aclr_a			: STRING;
		outdata_reg_a			: STRING;
		widthad_a				: NATURAL;
		width_a					: NATURAL;
		width_byteena_a			: NATURAL
	);
    PORT (
		clock0		: IN STD_LOGIC ;
		address_a	: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		q_a			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);

BEGIN

	altsyncram_component : altsyncram
	GENERIC MAP (
        address_aclr_a = "NONE",
		clock_enable_input_a = "BYPASS",
		clock_enable_output_a = "BYPASS",
		init_file = "output2.mif",
		intended_device_family = "Cyclone V",
		lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		lpm_type = "altsyncram",
		numwords_a = 480,
		operation_mode = "ROM",
		outdata_aclr_a = "NONE",
		outdata_reg_a = "CLOCK0",
		widthad_a = 9,
		width_a = 640,
		width_byteena_a = 1;
	);
	PORT MAP (
		clock0 => clock,
		address_a => rom_address,
		q_a => rom_data
	);



    rom_address <= character_address & font_row;
    rom_mux_output <= rom_data (CONV_INTEGER(NOT font_col(2 DOWNTO 0)));
    --once state machine outputs '1', output logic to render FLAPPY BIRD onto the screen

--output 'F'

	mainscreen_out <= '1';

END behavior;
