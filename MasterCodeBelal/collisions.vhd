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
reset: in std_logic;
death: out std_logic);
--collision_counter: out std_logic_vector(1 downto 0));
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
    variable collision: std_logic:= '0';
    variable flagged1, flagged2, flagged3, flagged4: std_logic:='0'; -- separate flags
    variable counter: std_logic_vector(1 downto 0):= CONV_STD_LOGIC_VECTOR(0,2);
    variable instDie: std_logic:='0';
    
    begin
    if(rising_edge(vert_sync)) then
    if(reset = '1') then
        flagged1:='0';
        flagged2:='0';
        flagged3:='0';
        flagged4:='0';
        counter:=CONV_STD_LOGIC_VECTOR(0,2);
        instDie:= '0';
        collision:='0';
    elsif(enable='1')then
        if( -- Pipe 1
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
            if(flagged1 = '0') then
                collision:='1';
                counter:= counter+CONV_STD_LOGIC_VECTOR(1,2);
                flagged1 := '1';
            end if;
        --signal collision counter
        elsif( -- Pipe 2
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
            if(flagged2 = '0') then
                collision:='1';
                counter:= counter+CONV_STD_LOGIC_VECTOR(1,2);
                flagged2 := '1';
            end if;
        --signal collision counter
         elsif( -- Pipe 3
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
            if(flagged3 = '0') then
                collision:='1';
                counter:= counter+CONV_STD_LOGIC_VECTOR(1,2);
                flagged3 := '1';
            end if;
        --signal collision counter
        elsif( -- Pipe 4
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
            if(flagged4 = '0') then
                collision:='1';
                counter:= counter+CONV_STD_LOGIC_VECTOR(1,2);
                flagged4 := '1';
            end if;
        --signal collision counter
        elsif( --bottom
            (bird_bottom>=floor)
        )then
            instDie:='1';
        else
        collision:='0';
        end if;
    
        if(bird_left>pipe1_right) then
            flagged1 := '0';
            collision:='0';
        elsif(bird_left>pipe2_right) then
            flagged2:='0';
            collision:='0';
        elsif(bird_left>pipe3_right) then
            flagged3:='0';
            collision:='0';
        elsif(bird_left>pipe4_right) then
            flagged4:='0';
            collision:='0';
        end if;
    
        if(instDie = '1') then
            death<='1';
        else
            if(counter=CONV_STD_LOGIC_VECTOR(3,2))then
                death<='1';
            else 
                death<='0';
            end if;
        end if;
    end if;
	 end if;
    end process;

end behaviour;