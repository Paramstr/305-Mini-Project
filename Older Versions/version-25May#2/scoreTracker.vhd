library IEEE;
use IEEE.std_logic_1164.all;   
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity scoreTracker is
port(clk, vert_sync: in std_logic;
mouse_clicked: in std_logic;
pipe_x_pos, pipe2_x_pos, pipe3_x_pos, pipe4_x_pos, bird_x_pos: in std_logic_vector(10 downto 0);
reset_behaviour:in std_logic;
second_out: out std_logic_vector(6 downto 0);
tens_out: out std_logic_vector(6 downto 0);
mins_out: out std_logic_vector(6 downto 0));
end entity scoreTracker;


architecture behaviour of scoreTracker is

--component initialisation

component bcd_counter is
Port(Clk, Direction, Enable, init: in std_logic;
Q: out std_logic_vector(3 downto 0));
end component bcd_counter;

component bcd_to_7seg is
port (BCD_digit : in std_logic_vector(3 downto 0);
SevenSeg_out : out std_logic_vector(6 downto 0));
end component bcd_to_7seg;

--signal initialisation--

--signals for seconds, tens of a second and minutes
signal seconds: std_logic_vector(3 downto 0);
signal tens:std_logic_vector(3 downto 0);
signal mins:std_logic_vector(3 downto 0);

--signals for enable on seconds, tens of a second and minutes
signal secs_enable:std_logic;
signal tens_enable:std_logic;
signal mins_enable:std_logic;

--signals on reset for tens of a second and minutes
signal secs_reset:std_logic;
signal tens_reset:std_logic;
signal mins_reset:std_logic;

--temporary signals
signal sec_reset_actual: std_logic;
signal tens_reset_actual: std_logic;
signal mins_reset_actual: std_logic;

--display signals
signal sevenSeg_out_sec: std_logic_vector(6 downto 0);
signal sevenSeg_out_tens: std_logic_vector(6 downto 0);
signal sevenSeg_out_mins: std_logic_vector(6 downto 0);

signal enable1, enable2, enable3: std_logic;

signal passedPipe:std_logic;

begin
--port mapping
counterSec: bcd_counter Port Map(clk=>vert_sync, Direction=>'1', Enable=>enable1, init=>sec_reset_actual, Q=> seconds);
counterTens: bcd_counter Port Map(clk=>vert_sync, Direction=>'1', Enable=>enable2, init=>tens_reset_actual, Q => tens);
counterMins: bcd_counter Port Map(clk=>vert_sync, Direction =>'1', Enable =>enable3, init=>mins_reset_actual, Q=> mins);

display1: BCD_to_7Seg Port Map(BCD_digit=>seconds, SevenSeg_out=>sevenSeg_out_sec);
display2: bcd_to_7seg Port Map(BCD_digit=>tens, SevenSeg_out=>sevenSeg_out_tens);
display3: bcd_to_7seg Port Map(BCD_digit=>mins, SevenSeg_out=>sevenSeg_out_mins);

passedPipe<='1' when pipe_x_pos = bird_x_pos or pipe2_x_pos=bird_x_pos or pipe3_x_pos=bird_x_pos or pipe4_x_pos=bird_x_pos
else '0';

tens_reset_actual <= tens_reset;
mins_reset_actual <= mins_reset;
sec_reset_actual<= secs_reset;

process(vert_sync)
begin

if(reset_behaviour='1')then
tens_reset<='1';
mins_reset<='1';
secs_reset<='1';
secs_enable<='0';
mins_enable<='0';
tens_enable<='0';
else
        if(mouse_clicked ='0') then
        tens_reset<='1';
        mins_reset<='1';
        secs_reset<='1';
        secs_enable<='0';
        mins_enable<='0';
        tens_enable<='0';
        else
        tens_reset<='0';
        mins_reset<='0';
        secs_reset<='0';
        end if;
        if(passedPipe = '1' and mouse_clicked = '1') then
        secs_enable<='1';
                if(seconds = 9) then
                 tens_enable <= '1';
                 secs_reset<='1';
                        if(tens=9) then
                        mins_enable <='1';
                         tens_reset <= '1';
                                if(mins=9) then
                                mins_reset<='1';
                                else
                                 mins_reset<='0';
                                 end if;
                         else
                        tens_reset<='0';
                        mins_enable<='0';
                         end if;
                else
            tens_enable <= '0';
            mins_enable<='0';
                end if;
        else
        secs_enable<='0';
        mins_enable<='0';
        tens_enable<='0';
        end if;
end if;
end process;
enable1<= secs_enable;
enable2<= tens_enable;
enable3<=mins_enable;


second_out<=sevenSeg_out_sec;
tens_out<=sevenSeg_out_tens;
mins_out<=sevenSeg_out_mins;

end architecture behaviour;