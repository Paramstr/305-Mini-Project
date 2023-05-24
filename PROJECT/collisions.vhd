library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity collisions is
PORT(vert_sync, pipe1, pipe2, pipe3, pipe4, black_bar, floor, bird: in std_logic;
reset: out std_logic);
end entity collisions;

architecture behaviour of collisions is

begin

process(vert_sync)
variable reset_behaviour: std_logic;
begin
if(rising_edge(vert_sync)) then

if(bird = pipe1) then
reset_behaviour:='1';
elsif(bird=pipe2) then
reset_behaviour:='1';
elsif(bird=pipe3) then
reset_behaviour:='1';
elsif(bird = pipe4) then
reset_behaviour:='1';
elsif(bird = black_bar) then
reset_behaviour:='1';
elsif(bird=floor) then
reset_behaviour:='1';
else
reset_behaviour:='0';
end if;

end if;
reset<=reset_behaviour;
end process;
end behaviour;