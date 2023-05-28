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
		  count: in integer;
		  pipe_on, pipe_on_2, pipe_on_3, pipe_on_4, ground_on, blackbar: OUT std_logic;
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
SIGNAL pipe_y_pos :std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(140,10);
SIGNAL pipe2_y_pos: std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(200,10);
SIGNAL pipe3_y_pos: std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(60,10);
SIGNAL pipe4_y_pos: std_logic_vector(9 downto 0):=CONV_STD_LOGIC_VECTOR(250,10);
signal prevCount: integer;

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

pipe_on <= '1' WHEN ((pixel_column<=pipe_x_pos)and(pixel_column+gap_width>= pipe_x_pos)and ((pipe_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe_y_pos)and pixel_row>=40)))
else '0';

pipe_on_2 <= '1' WHEN ((pixel_column<=pipe2_x_pos)and(pixel_column+gap_width>= pipe2_x_pos)and ((pipe2_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe2_y_pos)and pixel_row>=40)))
else '0';

pipe_on_3 <= '1' WHEN ((pixel_column<=pipe3_x_pos)and(pixel_column+gap_width>= pipe3_x_pos)and ((pipe3_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe3_y_pos)and pixel_row>=40)))
else '0';

pipe_on_4 <= '1' WHEN ((pixel_column<=pipe4_x_pos)and(pixel_column+gap_width>= pipe4_x_pos)and ((pipe4_y_pos+gap_height<=pixel_row and pixel_row<400)or((pixel_row<=pipe4_y_pos)and pixel_row>=40)))
else '0';
--Below is the SQUARES FOR MAINSCREEN
--mainscreen_red1 <= '1' WHEN (pixel_row >= 270 and pixel_row < 324 and pixel_column >= 251 and pixel_column < 389) ELSE '0';
--mainscreen_red2 <= '1' WHEN (pixel_row >= 340 and pixel_row < 390 and pixel_column >= 251 and pixel_column < 389) ELSE '0';

--ground
ground_on<= '1' WHEN((pixel_row>=400 and pixel_row<=480) and (pixel_column>= 0 and pixel_column<=640)) else '0';

blackbar<= '1' WHEN(pixel_row>=0 and pixel_row<=40 and (pixel_column>= 0 and pixel_column<=640)) else '0';

	
  

move_pipe:process(vert_sync)
variable random : integer:=0;
variable speed: std_logic_vector(10 downto 0):=CONV_STD_LOGIC_VECTOR(0,11);
begin
if (rising_edge(vert_sync)) then	
if(prevCount/=count) then
	if((count mod 10)=0)then
	if(speed=CONV_STD_LOGIC_VECTOR(5,11))then
	speed:=CONV_STD_LOGIC_VECTOR(5,11);
	else
	speed:= speed+CONV_STD_LOGIC_VECTOR(1,11);
	end if;
	else
	speed:=speed;
	end if;
else
	if(count=0)then
	speed:=CONV_STD_LOGIC_VECTOR(1,11);
	end if;
	speed:=speed;
end if;
prevCount<=count;
	if(reset_behaviour='1') then
	pipe_x_pos<=CONV_STD_LOGIC_VECTOR(250,11);
	pipe2_x_pos<=CONV_STD_LOGIC_VECTOR(430,11);
	pipe3_x_pos<=CONV_STD_LOGIC_VECTOR(610,11);
	pipe4_x_pos<=CONV_STD_LOGIC_VECTOR(790,11);
	speed:=CONV_STD_LOGIC_VECTOR(0,11);
	elsif(stop = '0') then
		initial<='0';
		if(pipe_x_pos>=CONV_STD_LOGIC_VECTOR(1000,11)) then
		pipe_x_pos<= CONV_STD_LOGIC_VECTOR(640,11)+gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 180)+80;
		pipe_y_pos<= CONV_STD_LOGIC_VECTOR(random, 10);
		else
		pipe_x_pos<= pipe_x_pos-speed;
		end if; 
		
		if(pipe2_x_pos>= CONV_STD_LOGIC_VECTOR(1000,11)) then
		pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(640, 11)+gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 180)+80;
		pipe2_y_pos<= CONV_STD_LOGIC_VECTOR(random,10);
		else
		pipe2_x_pos<= pipe2_x_pos-speed;
		end if; 

		if(pipe3_x_pos>= CONV_STD_LOGIC_VECTOR(1000,11)) then
		pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(640, 11)+gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 180)+80;
		pipe3_y_pos<= CONV_STD_LOGIC_VECTOR(random,10);
		else
		pipe3_x_pos<= pipe3_x_pos-speed;
		end if; 

		if(pipe4_x_pos>= CONV_STD_LOGIC_VECTOR(1000,11)) then
		pipe4_x_pos <= CONV_STD_LOGIC_VECTOR(640, 11)+gap_width;
		random := (to_integer(IEEE.numeric_std.unsigned(lfsr_out)) mod 180)+80;
		pipe4_y_pos<= CONV_STD_LOGIC_VECTOR(random,10);
		else
		pipe4_x_pos<= pipe4_x_pos-speed;
		end if; 
	elsif(stop='1' and initial='1') then
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
end process move_pipe;
pipe1_pos<= pipe_x_pos;
pipe2_pos<=pipe2_x_pos;
pipe3_pos<=pipe3_x_pos;
pipe4_pos<=pipe4_x_pos;

pipey<= pipe_y_pos;
pipey2<=pipe2_y_pos;
pipey3<=pipe3_y_pos;
pipey4<=pipe4_y_pos;


END behavior;