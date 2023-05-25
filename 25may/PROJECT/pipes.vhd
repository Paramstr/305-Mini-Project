library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY pipes IS
	PORT
		(pb1, pb2, clk, vert_sync, stop: IN std_logic;
          pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);
		  reset_behaviour: IN std_logic;
		  pipe_on, pipe_on_2, pipe_on_3, pipe_on_4, ground_on, black_bar: OUT std_logic;
		pipe1_pos, pipe2_pos, pipe3_pos, pipe4_pos: out std_logic_vector (10 downto 0);
		pipey, pipey2, pipey3, pipey4: out std_logic_vector(9 downto 0));		
END pipes;

architecture behavior of pipes is

--signals for the pipe
SIGNAL pipe_x_pos				: std_logic_vector(10 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(250,11);
SIGNAL pipe2_x_pos				: std_logic_vector(10 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(430,11);
SIGNAL pipe3_x_pos: std_logic_vector(10 downto 0):= CONV_STD_LOGIC_VECTOR(610,11);
SIGNAL pipe4_x_pos: std_logic_vector(10 downto 0):= CONV_STD_LOGIC_VECTOR(790,11);
SIGNAL gap_width				: std_logic_vector(9 downto 0);
SIGNAL gap_height				: std_logic_vector(9 downto 0);
SIGNAL pipe_width 		:std_logic_vector(9 downto 0);
SIGNAL pipe_y_pos :std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(200,10);
SIGNAL pipe2_y_pos: std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(200,10);
SIGNAL pipe3_y_pos: std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(200,10);
SIGNAL pipe4_y_pos: std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(200,10);
signal COMPUTE1: std_logic_vector(10 downto 0):=CONV_STD_LOGIC_VECTOR(250,11);
signal COMPUTE2: std_logic_vector(10 downto 0):=CONV_STD_LOGIC_VECTOR(430,11);
signal COMPUTE3: std_logic_vector(10 downto 0):= CONV_STD_LOGIC_VECTOR(610,11);
signal COMPUTE4: std_logic_vector(10 downto 0):= CONV_STD_LOGIC_VECTOR(790,11);

signal initial: std_logic:='1';

constant lfsr_poly                  : std_logic_vector(31 downto 0) := x"80000057";
    constant lfsr_seed                  : std_logic_vector(31 downto 0) := x"ACE1B4EF";
SIGNAL lfsr_out                 : std_logic_vector(31 downto 0);

component lfsr is
    port (
      clk       : in  std_logic;                              -- clock input
      rst       : in  std_logic;                              -- reset input
      seed      : in  std_logic_vector(31 downto 0);         -- initial seed value
      poly      : in  std_logic_vector(31 downto 0);         -- feedback polynomial
      output    : out std_logic_vector(31 downto 0)         -- output signal
    );
end component;
BEGIN    
lfsr_inst : lfsr
  port map (
    clk => vert_sync,           -- clock input
    rst => stop,               -- reset input
    seed => lfsr_seed,          -- initial seed value
    poly => lfsr_poly,          -- feedback polynomial
    output  => lfsr_out         -- output signal
  );       

gap_width<= CONV_STD_LOGIC_VECTOR(80, 10);
gap_height<= CONV_STD_LOGIC_VECTOR(140, 10);

-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

pipe_on <= '1' WHEN ((pixel_column<=pipe_x_pos)and(pixel_column>= compute1)and ((pipe_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe_y_pos)and pixel_row>=40)))
else '0';

pipe_on_2 <= '1' WHEN ((pixel_column<=pipe2_x_pos)and(pixel_column>= compute2)and ((pipe2_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe2_y_pos)and pixel_row>=40)))
else '0';

pipe_on_3 <= '1' WHEN ((pixel_column<=pipe3_x_pos)and(pixel_column>= compute3)and ((pipe3_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe3_y_pos)and pixel_row>=40)))
else '0';

pipe_on_4 <= '1' WHEN ((pixel_column<=pipe4_x_pos)and(pixel_column>= compute4)and ((pipe4_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe4_y_pos)and pixel_row>=40)))
else '0';

ground_on<= '1' WHEN(pixel_row>=400 and pixel_row<=480 and (pixel_column>= 0 and pixel_column<=640)) else '0';
black_bar<= '1' when((pixel_row>=0 and pixel_row<=40)and (pixel_column>=0 and pixel_column<=640)) else '0';

move_pipe:process(vert_sync)
variable random : integer:=0;
variable calculating1:std_logic_vector(10 downto 0);
variable calculating2:std_logic_vector(10 downto 0);
variable calculating3:std_logic_vector(10 downto 0);
variable calculating4: std_logic_vector(10 downto 0);
begin
if (rising_edge(vert_sync)) then	
	if(reset_behaviour='1') then
	calculating1:=CONV_STD_LOGIC_VECTOR(250,11)-gap_width;
	calculating2:=CONV_STD_LOGIC_VECTOR(430,11)-gap_width;
	calculating3:= CONV_STD_LOGIC_VECTOR(610,11)-gap_width;
	calculating4:= CONV_STD_LOGIC_VECTOR(790,11)-gap_width;
	pipe_x_pos<=CONV_STD_LOGIC_VECTOR(250,11);
	pipe2_x_pos<=CONV_STD_LOGIC_VECTOR(430,11);
	pipe3_x_pos<=CONV_STD_LOGIC_VECTOR(610,11);
	pipe4_x_pos<=CONV_STD_LOGIC_VECTOR(790,11);
	elsif(stop = '0') then
		initial<='0';
		if(pipe_x_pos<=CONV_STD_LOGIC_VECTOR(80,11)) then
		calculating1:=CONV_STD_LOGIC_VECTOR(0,11);
		else
		calculating1:=pipe_x_pos-gap_width;
		end if;
		
		if(pipe2_x_pos<=CONV_STD_LOGIC_VECTOR(80,11)) then
		calculating2:=CONV_STD_LOGIC_VECTOR(0,11);
		else
		calculating2:=pipe2_x_pos-gap_width;
		end if;

		if(pipe3_x_pos<=CONV_STD_LOGIC_VECTOR(80,11)) then
		calculating3:=CONV_STD_LOGIC_VECTOR(0,11);
		else
		calculating3:=pipe3_x_pos-gap_width;
		end if;
			
		if(pipe4_x_pos<=CONV_STD_LOGIC_VECTOR(80,11)) then
		calculating4:=CONV_STD_LOGIC_VECTOR(0,11);
		else
		calculating4:=pipe4_x_pos-gap_width;
		end if;

		if(pipe_x_pos<=CONV_STD_LOGIC_VECTOR(0,11)) then
		pipe_x_pos<= CONV_STD_LOGIC_VECTOR(640,11)+gap_width;
		calculating1:=pipe_x_pos-gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 250)+80;
		pipe_y_pos<= CONV_STD_LOGIC_VECTOR(random, 10);
		else
		pipe_x_pos<= pipe_x_pos+CONV_STD_LOGIC_VECTOR(-1,11);
		end if; 
		
		if(pipe2_x_pos<= CONV_STD_LOGIC_VECTOR(0,11)) then
		pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(640, 11)+gap_width;
		calculating2:=pipe2_x_pos-gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 250)+80;
		pipe2_y_pos<= CONV_STD_LOGIC_VECTOR(random,10);
		else
		pipe2_x_pos<= pipe2_x_pos+CONV_STD_LOGIC_VECTOR(-1,11);
		end if; 

		if(pipe3_x_pos<= CONV_STD_LOGIC_VECTOR(0,11)) then
		pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(640, 11)+gap_width;
		calculating3:=pipe3_x_pos-gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 250)+80;
		pipe3_y_pos<= CONV_STD_LOGIC_VECTOR(random,10);
		else
		pipe3_x_pos<= pipe3_x_pos+CONV_STD_LOGIC_VECTOR(-1,11);
		end if; 

		if(pipe4_x_pos<= CONV_STD_LOGIC_VECTOR(0,11)) then
		pipe4_x_pos <= CONV_STD_LOGIC_VECTOR(640, 11)+gap_width;
		calculating4:=pipe4_x_pos-gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 250)+80;
		pipe4_y_pos<= CONV_STD_LOGIC_VECTOR(random,10);
		else
		pipe4_x_pos<= pipe4_x_pos+CONV_STD_LOGIC_VECTOR(-1,11);
		end if; 
	elsif(stop='1' and initial='1') then
		calculating1:=CONV_STD_LOGIC_VECTOR(250,11)-gap_width;
	calculating2:=CONV_STD_LOGIC_VECTOR(430,11)-gap_width;
	calculating3:= CONV_STD_LOGIC_VECTOR(610,11)-gap_width;
	calculating4:= CONV_STD_LOGIC_VECTOR(790,11)-gap_width;
	pipe_x_pos<=CONV_STD_LOGIC_VECTOR(250,11);
	pipe2_x_pos<=CONV_STD_LOGIC_VECTOR(430,11);
	pipe3_x_pos<=CONV_STD_LOGIC_VECTOR(610,11);
	pipe4_x_pos<=CONV_STD_LOGIC_VECTOR(790,11);
	else
		pipe_x_pos<=pipe_x_pos;
		pipe2_x_pos<=pipe2_x_pos;
		pipe3_x_pos<=pipe3_x_pos;
		pipe4_x_pos<=pipe4_x_pos;
	end if;
end if;
pipe1_pos<= pipe_x_pos;
pipe2_pos<=pipe2_x_pos;
pipe3_pos<=pipe3_x_pos;
pipe4_pos<=pipe4_x_pos;

pipey<= pipe_y_pos;
pipey2<=pipe2_y_pos;
pipey3<=pipe3_y_pos;
pipey4<=pipe4_y_pos;

compute1<=calculating1;
compute2<=calculating2;
compute3<=calculating3;
compute4<=calculating4;
end process move_pipe;


END behavior;