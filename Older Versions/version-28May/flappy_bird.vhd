library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


ENTITY flappy_bird IS
	PORT
		( pause_button, clk, vert_sync, mouse_click: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  reset_button: in std_logic;
		 ball_on, stop_signal, mouse_clicked: OUT std_logic;
		bird_x_pos: OUT std_logic_vector(10 downto 0);
		Legit_reset: out std_logic;
		birdy: out std_logic_vector(9 downto 0));
END flappy_bird;

architecture behavior of flappy_bird is

--Signals for the ball
SIGNAL ball_y_motion				: std_logic_vector(9 downto 0);
--signals for the pipe
--signals for mouse input(needed for ball movement)
SIGNAL prevMouse: std_logic;
signal stopMoving: std_logic;
signal gamePause: std_logic:= '0';
signal reset_behaviour: std_logic:='1';

--
SIGNAL size                      : std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				 : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(180,10);
SiGNAL ball_x_pos			     : std_logic_vector(9 DOWNTO 0);

--Head 
SIGNAL Head_xPos              : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(134,10);
SIGNAL Head_yPos              : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(236,10);
SIGNAL length_6                  : std_logic_vector(9 DOWNTO 0);
SIGNAL length_4                  : std_logic_vector(9 DOWNTO 0);  

-- Feet
SIGNAL FootLeft_xPos              : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(129,10);
SIGNAL FootLeft_yPos              : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(248,10);
SIGNAL FootRight_xPos              : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(133,10);
SIGNAL FootRight_yPos              : std_logic_vector(9 DOWNTO 0):=CONV_STD_LOGIC_VECTOR(248,10);

SIGNAL length_2                  : std_logic_vector(9 DOWNTO 0);


BEGIN           


size <= CONV_STD_LOGIC_VECTOR(8,10); -- Size of the main body
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(128,10);


-- Head Sizing
length_6 <= CONV_STD_LOGIC_VECTOR(6,10);
length_4 <= CONV_STD_LOGIC_VECTOR(4,10);
length_2 <= CONV_STD_LOGIC_VECTOR(2,10);





-- ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
-- 					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
-- 			'0';

ball_on <= '1' when 
(
    ( --head
        ('0' & Head_xPos <= pixel_column) and 
        ('0' & pixel_column < Head_xPos + length_6) and 
        ('0' & Head_yPos <= pixel_row) and 
        ('0' & pixel_row < Head_yPos + length_4)
    ) or

	( --Left Foot
		('0' & FootLeft_xPos <= pixel_column) and 
		('0' & pixel_column < FootLeft_xPos + length_2) and 
		('0' & FootLeft_yPos <= pixel_row) and 
		('0' & pixel_row < FootLeft_yPos + length_2)
	) or

	( --Right Foot
		('0' & FootRight_xPos <= pixel_column) and 
		('0' & pixel_column < FootRight_xPos + length_2) and 
		('0' & FootRight_yPos <= pixel_row) and 
		('0' & pixel_row < FootRight_yPos + length_2)
	) or
	--main body/ball
    (
        ('0' & ball_x_pos <= pixel_column) and 
        ('0' & pixel_column < ball_x_pos + size) and 
        ('0' & ball_y_pos <= pixel_row) and 
        ('0' & pixel_row < ball_y_pos + size)
    )

)
else '0';
	
bird_x_pos <= '0' & ball_x_pos - size; 



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
variable bird_y_pos: std_logic_vector(9 downto 0)		   := "0011110000";
variable birdHead_y_pos: std_logic_vector(9 downto 0)      := "0011101100";  
variable birdFoot_y_pos: std_logic_vector(9 downto 0)  := "0011111000";  

begin
    -- Move ball once every vertical sync
if (rising_edge(vert_sync)) then
	if(reset_behaviour='1') then
		bird_y_pos:=CONV_STD_LOGIC_VECTOR(240,10);
		birdHead_y_pos:=CONV_STD_LOGIC_VECTOR(236,10);
		birdFoot_y_pos:=CONV_STD_LOGIC_VECTOR(248,10);

		
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
		birdHead_y_pos := birdHead_y_pos + ball_y_motion;
		birdFoot_y_pos := birdFoot_y_pos + ball_y_motion;

		if(bird_y_pos>CONV_STD_LOGIC_VECTOR(398,10)-size) then
			bird_y_pos:=CONV_STD_LOGIC_VECTOR(398,10)-size;
			birdHead_y_pos:=CONV_STD_LOGIC_VECTOR(390,10)-length_4;
			birdFoot_y_pos:=CONV_STD_LOGIC_VECTOR(400,10)-length_2;

		elsif(bird_y_pos<CONV_STD_LOGIC_VECTOR(37,10)+size) then
			bird_y_pos:=CONV_STD_LOGIC_VECTOR(37,10)+size;
			birdHead_y_pos:=CONV_STD_LOGIC_VECTOR(37,10)+length_4;
			birdFoot_y_pos:=CONV_STD_LOGIC_VECTOR(51,10)+length_2;

		end if;
		prevMouse <= Mouse_click;
	else
		bird_y_pos:=bird_y_pos;
		birdHead_y_pos:=birdHead_y_pos;
		birdFoot_y_pos:=birdFoot_y_pos;

		ball_y_motion<=CONV_STD_LOGIC_VECTOR(0,10);
	end if;
	end if;
end if;
ball_y_pos<=bird_y_pos;
Head_yPos <= birdHead_y_pos;
FootLeft_yPos <= birdFoot_y_pos;
FootRight_yPos <= birdFoot_y_pos;

birdy<=bird_y_pos;
end process move_bird;
stop_signal<=not gamePause;
Legit_reset<= reset_behaviour;
END behavior;

