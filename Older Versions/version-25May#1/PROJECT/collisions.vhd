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
reset: out std_logic);
end entity collisions;

architecture behaviour of collisions is
signal bird_right: std_logic_vector(10 downto 0);
signal bird_left: std_logic_vector(10 downto 0);
signal bird_top: std_logic_vector(9 downto 0);
signal bird_bottom: std_logic_vector(9 downto 0);
begin



process(vert_sync)
variable reset_behaviour: std_logic;
variable collision: std_logic;
variable counter: integer:=0;
begin
if(rising_edge(vert_sync)) then
	if(
        (bird_right>=(pipe1x-CONV_STD_LOGIC_VECTOR(80,10)))
        and
        (bird_left<=pipe1x)
        and
        (
            (bird_bottom>=pipey+CONV_STD_LOGIC_VECTOR(140,10))
            or
            (bird_top<=pipey)
        )
    ) then
    collision:='1';
    elsif(
        (bird_right>=(pipe2x-CONV_STD_LOGIC_VECTOR(80,10)))
        and
        (bird_left<=pipe2x)
        and
        (
            (bird_bottom>=pipey2+CONV_STD_LOGIC_VECTOR(140,10))
            or
            (bird_top<=pipey2)
        )
    )then
    collision:='1';
     elsif(
        (bird_right>=(pipe3x-CONV_STD_LOGIC_VECTOR(80,10)))
        and
        (bird_left<=pipe3x)
        and
        (
            (bird_bottom>=pipey3+CONV_STD_LOGIC_VECTOR(140,10))
            or
            (bird_top<=pipey3)
        )
    )then
    collision:='1';
    elsif(
        (bird_right>=(pipe4x-CONV_STD_LOGIC_VECTOR(80,10)))
        and
        (bird_left<=pipe4x)
        and
        (
            (bird_bottom>=pipey4+CONV_STD_LOGIC_VECTOR(140,10))
            or
            (bird_top<=pipey4)
        )
    )then
    collision:='1';
    else
    collision:='0';
    end if;

if(collision = '1')then
counter:=counter+1;
else
counter:=0;
end if;

if(counter=3) then
reset_behaviour:='0';
else
reset_behaviour:='1';
end if;

end if;
reset<=reset_behaviour;
end process;

bird_right<= birdx+CONV_STD_LOGIC_VECTOR(8,10);
bird_left<=birdx-CONV_STD_LOGIC_VECTOR(8,10);
bird_top<=birdy-CONV_STD_LOGIC_VECTOR(8,10);
bird_bottom<=birdy+CONV_STD_LOGIC_VECTOR(8,10);
end behaviour;