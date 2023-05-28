library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity collisions is
PORT(vert_sync: in std_logic;
pipe1x, pipe2x, pipe3x, pipe4x: in std_logic_vector(10 downto 0);
pipey, pipey2, pipey3, pipey4: in std_logic_vector(9 downto 0);
birdy: in std_logic_vector(9 downto 0);
birdx: in std_logic_vector(10 downto 0);
enable: in std_logic;
reset: out std_logic;
death: out std_logic);
end entity collisions;

architecture behaviour of collisions is
signal bird_right:std_logic_vector(10 downto 0);
signal bird_left:std_logic_vector(10 downto 0);
signal bird_top:std_logic_vector(9 downto 0);
signal bird_bottom:std_logic_vector(9 downto 0);

signal pipe1_right:std_logic_vector(10 downto 0);
signal pipe1_left:std_logic_vector(10 downto 0);
signal pipe1_top:std_logic_vector(9 downto 0);
signal pipe1_bottom:std_logic_vector(9 downto 0);

signal pipe2_right:std_logic_vector(10 downto 0);
signal pipe2_left:std_logic_vector(10 downto 0);
signal pipe2_top:std_logic_vector(9 downto 0);
signal pipe2_bottom:std_logic_vector(9 downto 0);

signal pipe3_right:std_logic_vector(10 downto 0);
signal pipe3_left:std_logic_vector(10 downto 0);
signal pipe3_top:std_logic_vector(9 downto 0);
signal pipe3_bottom:std_logic_vector(9 downto 0);

signal pipe4_right:std_logic_vector(10 downto 0);
signal pipe4_left:std_logic_vector(10 downto 0);
signal pipe4_top:std_logic_vector(9 downto 0);
signal pipe4_bottom:std_logic_vector(9 downto 0);

signal floor: std_logic_vector(9 downto 0);

begin

bird_right<= birdx+CONV_STD_LOGIC_VECTOR(8,11);
bird_left<=birdx-CONV_STD_LOGIC_VECTOR(8,11);
bird_top<=birdy-CONV_STD_LOGIC_VECTOR(8,10);
bird_bottom<=birdy+CONV_STD_LOGIC_VECTOR(8,10);

pipe1_right<=pipe1x;
pipe1_left<=pipe1x-CONV_STD_LOGIC_VECTOR(88,11);
pipe1_top<=pipey+CONV_STD_LOGIC_VECTOR(8,10);
pipe1_bottom<=pipey+CONV_STD_LOGIC_VECTOR(132,10);

pipe2_right<=pipe2x;
pipe2_left<=pipe2x-CONV_STD_LOGIC_VECTOR(88,11);
pipe2_top<=pipey2+CONV_STD_LOGIC_VECTOR(8,10);
pipe2_bottom<=pipey2+CONV_STD_LOGIC_VECTOR(132,10);

pipe3_right<=pipe3x;
pipe3_left<=pipe3x-CONV_STD_LOGIC_VECTOR(88,11);
pipe3_top<=pipey3+CONV_STD_LOGIC_VECTOR(8,10);
pipe3_bottom<=pipey3+CONV_STD_LOGIC_VECTOR(132,10);

pipe4_right<=pipe4x;
pipe4_left<=pipe4x-CONV_STD_LOGIC_VECTOR(88,11);
pipe4_top<=pipey4+CONV_STD_LOGIC_VECTOR(8,10);
pipe4_bottom<=pipey4+CONV_STD_LOGIC_VECTOR(132,10);

floor<= CONV_STD_LOGIC_VECTOR(392,10);

process(vert_sync)
variable reset_behaviour: std_logic:='1';
variable collision: std_logic;
begin
if(rising_edge(vert_sync)) then
if(enable='1')then
	if(
        (bird_right>=pipe1_left)
        and
        (bird_left<=pipe1_right)
        and
        (
            (bird_bottom>=pipe1_bottom)
            or
            (bird_top<=pipe1_top)
        )
    ) then
    collision:='1';
    elsif(
        (bird_right>=pipe2_left)
        and
        (bird_left<=pipe2_right)
        and
        (
            (bird_bottom>=pipe2_bottom)
            or
            (bird_top<=pipe2_top)
        )
    )then
    collision:='1';
     elsif(
       (bird_right>=pipe3_left)
        and
        (bird_left<=pipe3_right)
        and
        (
            (bird_bottom>=pipe3_bottom)
            or
            (bird_top<=pipe3_top)
        )
    )then
    collision:='1';
    elsif(
       (bird_right>=pipe4_left)
        and
        (bird_left<=pipe4_right)
        and
        (
            (bird_bottom>=pipe4_bottom)
            or
            (bird_top<=pipe4_top)
        )
    )then
    collision:='1';
    elsif(
        (bird_bottom>=floor)
    )then
    collision:='1';
    else
    collision:='0';
    end if;

    if(collision = '1')then
    reset_behaviour:='0';
	 death<= '1';
    else
    reset_behaviour:='1';
	 death<='0';
    end if;
end if;
end if;
reset<=reset_behaviour;
end process;

end behaviour;