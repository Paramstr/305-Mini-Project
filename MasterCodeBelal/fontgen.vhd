library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity fontgen is
PORT(
    clk: in std_logic;
    pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);

    currentMode: IN std_logic_vector(1 downto 0);
    gameOn: IN std_logic;
    --Score Tracking
    ones_in: IN std_logic_vector(3 downto 0);
    tens_in: IN std_logic_vector(3 downto 0);
    hundreds_in: in std_logic_vector(3 downto 0);
    --char_rom outputs
    char_address_score : OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
    char_address_scoreval : OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
    char_address_mode : OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
    char_address_heart	: OUT	STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
    --hearts_on, score_on: out std_logic);

end entity fontgen;


architecture behaviour of fontgen is

    SIGNAL font_row, font_col	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL A: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000001";
    SIGNAL B: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
    SIGNAL C: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";
    SIGNAL D: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";
    SIGNAL E: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";
    SIGNAL F: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000110";
    SIGNAL G: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000111";
    SIGNAL H: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
    SIGNAL I: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";
    SIGNAL J: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001010";
    SIGNAL K: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001011";
    SIGNAL L: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001100";
    SIGNAL M: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001101";
    SIGNAL N: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001110";
    SIGNAL O: STD_LOGIC_VECTOR(5 DOWNTO 0) := "001111";
    SIGNAL P: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010000";
    SIGNAL Q: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010001";
    SIGNAL R: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010010";
    SIGNAL S: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010011";
    SIGNAL T: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010100";
    SIGNAL U: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010101";
    SIGNAL V: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010110";
    SIGNAL W: STD_LOGIC_VECTOR(5 DOWNTO 0) := "010111";
    SIGNAL X: STD_LOGIC_VECTOR(5 DOWNTO 0) := "011000";
    SIGNAL Y: STD_LOGIC_VECTOR(5 DOWNTO 0) := "011001";
    SIGNAL Z: STD_LOGIC_VECTOR(5 DOWNTO 0) := "011010";
    SIGNAL ARROWRIGHT: STD_LOGIC_VECTOR(5 DOWNTO 0) := "011111"; --31
    SIGNAL SPACE: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100000"; --32
    SIGNAL SEMICOLON: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100001"; -- 33
    SIGNAL QUOTATIONMARK: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100010";
    SIGNAL HASHTAG: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100011";
    SIGNAL DOLAR: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100100";
    SIGNAL PERCENT: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100101";
    SIGNAL ANDSIGN: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100110";
    SIGNAL HEARTSIGN: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100111";
    SIGNAL BRACKET_OPEN: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101000";
    SIGNAL BRACKET_CLOSED: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101001";
    SIGNAL ASTERISK: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101010";
    SIGNAL PLUS_SING: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";
    SIGNAL COMMA: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101100";
    SIGNAL DASH: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101101";
    SIGNAL FULLSTOP: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101110";
    SIGNAL SLASH: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101111";
    SIGNAL ZERO: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110000";
    SIGNAL ONE: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110001";
    SIGNAL TWO: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110010";
    SIGNAL THREE: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110011";
    SIGNAL FOUR: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110100";
    SIGNAL FIVE: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110101";
    SIGNAL SIX: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110110";
    SIGNAL SEVEN: STD_LOGIC_VECTOR(5 DOWNTO 0) := "110111";
    SIGNAL EIGHT: STD_LOGIC_VECTOR(5 DOWNTO 0) := "111000";
    SIGNAL NINE: STD_LOGIC_VECTOR(5 DOWNTO 0) := "111001";
	 
	 signal Heart_top_left: STD_LOGIC_VECTOR(5 downto 0):="111010";
	 signal Heart_top_right: STD_LOGIC_VECTOR(5 downto 0):="111011";
	 signal Heart_bot_left: STD_LOGIC_VECTOR(5 downto 0):="111100";
	 signal Heart_bot_right: STD_LOGIC_VECTOR(5 downto 0):="111101";

   signal temp_scoreval : 	STD_LOGIC_VECTOR(5 DOWNTO 0);
   signal temp_score	: 	STD_LOGIC_VECTOR(5 DOWNTO 0);
   signal temp_mode : 	STD_LOGIC_VECTOR(5 DOWNTO 0);
   signal temp_heart : 	STD_LOGIC_VECTOR(5 DOWNTO 0);



begin

show_score:process(clk)
begin
if(rising_edge(clk)) then

		if(currentMode = "01" and gameOn = '1') then --############### 'TRAINING' ###############
      -- score    
        if((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 0 and pixel_column < 16)) then
          temp_score <= S;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 16 and pixel_column < 32)) then
          temp_score <= C;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 32 and pixel_column < 48)) then
          temp_score <= O;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 48 and pixel_column < 64)) then
          temp_score <= R;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 64 and pixel_column < 80)) then
          temp_score <= E;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 80 and pixel_column < 96)) then
          temp_score <= SEMICOLON;

      -- score value
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 96 and pixel_column < 112)) then
          temp_scoreval <= ZERO + hundreds_in;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 112 and pixel_column < 128)) then
          temp_scoreval <= ZERO + tens_in;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 128 and pixel_column < 144)) then
          temp_scoreval <= ZERO + ones_in;
			
      -- show 'TRAINING'
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 256 and pixel_column < 272)) then
          temp_mode <= T;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 272 and pixel_column < 288)) then
          temp_mode <= R;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 288 and pixel_column < 304)) then
          temp_mode <= A;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 304 and pixel_column < 320)) then
          temp_mode <= I;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 320 and pixel_column < 336)) then
          temp_mode <= N;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 336 and pixel_column < 352)) then
          temp_mode <= I;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 352 and pixel_column < 368)) then
          temp_mode <= N;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 368 and pixel_column < 384)) then
          temp_mode <= G;
      -- hearts  
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 512 and pixel_column < 528)) then --Heart 1
          temp_heart <= HEARTSIGN; 
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 528 and pixel_column < 544)) then --Heart 2
          temp_heart <= SPACE; 
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 544 and pixel_column < 560)) then --Heart 3
          temp_heart <= HEARTSIGN;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 560 and pixel_column < 576)) then --Heart 4
          temp_heart <= SPACE; 
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 576 and pixel_column < 592)) then --Heart 5
          temp_heart <= HEARTSIGN; 
			 else 
        temp_score <= SPACE;
        temp_scoreval <= SPACE;
        temp_mode <= SPACE;
        temp_heart <= SPACE;
       end if;
          
		elsif(currentMode = "10" and gameOn = '1') then -- ############### 'mode: Game' ###############
      -- score
			  if((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 0 and pixel_column < 16)) then
          temp_score <= S;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 16 and pixel_column < 32)) then
          temp_score <= C;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 32 and pixel_column < 48)) then
          temp_score <= O;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 48 and pixel_column < 64)) then
          temp_score <= R;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 64 and pixel_column < 80)) then
          temp_score <= E;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 80 and pixel_column < 96)) then
          temp_score <= SEMICOLON;

      --score value
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 96 and pixel_column < 112)) then
          temp_scoreval <= ZERO + hundreds_in;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 112 and pixel_column < 128)) then
          temp_scoreval <= ZERO + tens_in;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 128 and pixel_column < 144)) then
          temp_scoreval <= ZERO + ones_in;

      -- show 'GAME'
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 256 and pixel_column < 272)) then --GAME
          temp_mode <= G;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 272 and pixel_column < 288)) then
          temp_mode <= A;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 288 and pixel_column < 304)) then
          temp_mode <= M;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 304 and pixel_column < 320)) then
          temp_mode <= E;

      -- hearts
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 514 and pixel_column < 530)) then --Heart 1 (shifted by 2)
          temp_heart <= HEARTSIGN; 
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 530 and pixel_column < 546)) then --Heart 2 (shifted by 2)
          temp_heart <= SPACE; 
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 546 and pixel_column < 562)) then --Heart 3 (shifted by 2)
          temp_heart <= HEARTSIGN;
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 562 and pixel_column < 578)) then --Heart 4 (shifted by 2)
          temp_heart <= SPACE; 
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 578 and pixel_column < 594)) then --Heart 5 (shifted by 2)
          temp_heart <= HEARTSIGN; 
    

			 else 
			  temp_score <= SPACE;
        temp_scoreval <= SPACE;
        temp_mode <= SPACE;
        temp_heart <= SPACE;
		    end if;

		elsif(currentMode = "00" and gameOn='0') then -- ############### SHOW 'mode: MAINSCREEN' ###############
      -- FlAPPY BIRD
        if((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 224 and pixel_column < 240)) then
          temp_mode <= F;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 240 and pixel_column < 256)) then
          temp_mode <= L;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 256 and pixel_column < 272)) then
          temp_mode <= A;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 272 and pixel_column < 288)) then
          temp_mode <= P;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 288 and pixel_column < 304)) then
          temp_mode <= P;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 304 and pixel_column < 320)) then
          temp_mode <= Y;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 320 and pixel_column < 336)) then
          temp_mode <= SPACE;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 336 and pixel_column < 352)) then
          temp_mode <= B;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 352 and pixel_column < 368)) then
          temp_mode <= I;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 368 and pixel_column < 384)) then
          temp_mode <= R;
        elsif((pixel_row >= 176 and pixel_row < 192) and (pixel_column >= 384 and pixel_column < 400)) then
          temp_mode <= D;
          --line under flappy bird
        elsif((pixel_row >= 224 and pixel_row < 240) and (pixel_column >= 100 and pixel_column < 540)) then
          temp_mode <= DASH;
      -- TRAINING
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 222 and pixel_column < 238)) then
          temp_mode <= ARROWRIGHT;  
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 240 and pixel_column < 256)) then
          temp_mode <= SPACE;
        --- main screen: Training
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 256 and pixel_column < 272)) then
          temp_mode <= T;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 272 and pixel_column < 288)) then
          temp_mode <= R;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 288 and pixel_column < 304)) then
          temp_mode <= A;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 304 and pixel_column < 320)) then
          temp_mode <= I;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 320 and pixel_column < 336)) then
          temp_mode <= N;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 336 and pixel_column < 352)) then
          temp_mode <= I;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 352 and pixel_column < 368)) then
          temp_mode <= N;
        elsif((pixel_row >= 288 and pixel_row < 304) and (pixel_column >= 368 and pixel_column < 384)) then
          temp_mode <= G;
        
        
      
      --- Game
        elsif((pixel_row >= 352 and pixel_row < 368) and (pixel_column >= 256 and pixel_column < 272)) then
          temp_mode <= G;
        elsif((pixel_row >= 352 and pixel_row < 368) and (pixel_column >= 272 and pixel_column < 288)) then
          temp_mode <= A;
        elsif((pixel_row >= 352 and pixel_row < 368) and (pixel_column >= 288 and pixel_column < 304)) then
          temp_mode <= M;
        elsif((pixel_row >= 352 and pixel_row < 368) and (pixel_column >= 304 and pixel_column < 320)) then
          temp_mode <= E;
			else
			temp_score <= SPACE;
      temp_scoreval <= SPACE;
      temp_mode <= SPACE;
      temp_heart <= SPACE;
      
			end if;
		 
		 
      

          
          

      -- ##########################################
		end if;
 end if;
end process show_score;


-- show_score_val:process(clk)
-- begin

-- end process show_score_val;
char_address_score <= temp_score;
char_address_scoreval <= temp_scoreval;
char_address_mode <= temp_mode;
char_address_heart <= temp_heart;


end architecture behaviour;