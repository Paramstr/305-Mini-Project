library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


ENTITY flappy_bird IS
	PORT
		( pb1, pb2, pause_button, clk, vert_sync, mouse_click: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  reset_button: in std_logic;
		 ball_on, stop_signal, mouse_clicked: OUT std_logic;
		bird_x_pos: OUT std_logic_vector(10 downto 0);
		Legit_reset: out std_logic);
END flappy_bird;

architecture behavior of flappy_bird is

--Signals for the ball
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(180,10);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_y_motion				: std_logic_vector(9 downto 0);
--signals for the pipe
--signals for mouse input(needed for ball movement)
SIGNAL prevMouse: std_logic;
signal stopMoving: std_logic;
signal gamePause: std_logic:= '0';
signal reset_behaviour: std_logic:='1';
BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(128,11);

ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


bird_x_pos<= ball_x_pos-size;



game_start: process(clk)
begin
if(rising_edge(clk)) then
	if(mouse_click='1') then
	gamePause<='1';
	end if;

	if(pause_button='0')then
	gamePause<='0';
	end if;
	
	if(reset_button='0') then
	gamePause<='0';
	reset_behaviour<='1';
	else
	reset_behaviour<='0';
	end if;

end if;
end process;



move_bird: process (vert_sync)  
variable bird_y_pos: std_logic_vector(9 downto 0):= "0011110000";  
begin
    -- Move ball once every vertical sync
if (rising_edge(vert_sync)) then
	if(reset_behaviour='1') then
		bird_y_pos:=CONV_STD_LOGIC_VECTOR(240,10);
	else
	if(gamePause = '1') then
		if(prevMouse /= Mouse_click) then
			if(mouse_click = '1') then
				mouse_clicked<='1';
				ball_y_motion<=CONV_STD_LOGIC_VECTOR(-10,10);
			else
				if(ball_y_motion=CONV_STD_LOGIC_VECTOR(6,10)) then
					ball_y_motion<=CONV_STD_LOGIC_VECTOR(6,10);
				else
					ball_y_motion<=ball_y_motion+CONV_STD_LOGIC_VECTOR(1,10);
				end if;
			end if;
		else
			if(ball_y_motion=CONV_STD_LOGIC_VECTOR(6,10)) then
				ball_y_motion<=CONV_STD_LOGIC_VECTOR(6,10);
			else
				ball_y_motion<=ball_y_motion+CONV_STD_LOGIC_VECTOR(1,10);
			end if;
		end if;
		bird_y_pos := bird_y_pos + ball_y_motion;
		if(bird_y_pos>CONV_STD_LOGIC_VECTOR(399,10)-size) then
			bird_y_pos:=CONV_STD_LOGIC_VECTOR(399,10)-size;
		elsif(bird_y_pos<CONV_STD_LOGIC_VECTOR(41,10)+size) then
			bird_y_pos:=CONV_STD_LOGIC_VECTOR(41,10)+size;
		end if;
		prevMouse <= Mouse_click;
	else
		bird_y_pos:=bird_y_pos;
		ball_y_motion<=CONV_STD_LOGIC_VECTOR(0,10);
	end if;
	end if;
end if;
ball_y_pos<=bird_y_pos;
end process move_bird;
stop_signal<=not gamePause;
Legit_reset<= reset_behaviour;
END behavior;

