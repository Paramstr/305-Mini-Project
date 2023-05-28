library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity fontgen is
PORT(
    clk: in std_logic;
    pixel_row, pixel_column: IN std_logic_vector(9 DOWNTO 0);
    character_address	: OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
    hearts_on, score_on: out std_logic);

end entity fontgen;


architecture behaviour of fontgen is

    SIGNAL font_row, font_col	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL xx,yy: STD_LOGIC_VECTOR(2 downto 0);
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
	 
	 signal temp_char_address: std_logic_vector(5 downto 0);



begin

character_score:process(clk)
begin
    if(rising_edge(clk)) then
            
        if((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 0 and pixel_column < 16)) then
            temp_char_address <= S;
            score_on<='1';
				hearts_on<='0';
        -- xx<= pixel_row - '01111';
        -- font_row<= xx(2 downto 0);
        --   yy<= pixel_column -'01111'; 
        --   font_col<= yy(2 downto 0);

        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 16 and pixel_column < 32)) then
            temp_char_address <= C;
            score_on<='1';
				hearts_on<='0';
        -- xx<= pixel_row - '01111';
        -- font_row<= xx(2 downto 0);
        --   yy<= pixel_column -'01111'; 
        --   font_col<= yy(2 downto 0);

        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 32 and pixel_column < 48)) then
            temp_char_address <= O;
            score_on<='1';
				hearts_on<='0';
        -- xx<= pixel_row - '01111';
        -- font_row<= xx(2 downto 0);
        --   yy<= pixel_column -'01111'; 
        --   font_col<= yy(2 downto 0);

        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 48 and pixel_column < 64)) then
            temp_char_address <= R;
            score_on<='1';
				hearts_on<='0';
        -- xx<= pixel_row - '01111';
        -- font_row<= xx(2 downto 0);
        --   yy<= pixel_column -'01111'; 
        --   font_col<= yy(2 downto 0);
        


        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 64 and pixel_column < 80)) then
            temp_char_address <= E;
            score_on<='1';
				hearts_on<='0';
        -- xx<= pixel_row - '01111';
        -- font_row<= xx(2 downto 0);
        --   yy<= pixel_column -'01111'; 
        --   font_col<= yy(2 downto 0);

        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 80 and pixel_column < 96)) then
            temp_char_address <= SEMICOLON;
            score_on<='1';
				hearts_on<='0';
        -- xx<= pixel_row - '01111';
        -- font_row<= xx(2 downto 0);
        --   yy<= pixel_column -'01111'; 
        --   font_col<= yy(2 downto 0);
		   elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 96 and pixel_column < 112)) then
            temp_char_address <= ZERO;
            score_on<='1';
				hearts_on<='0';
        
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 112 and pixel_column < 128)) then
            temp_char_address <= ZERO;
            score_on<='1';
				hearts_on<='0';
            
        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 128 and pixel_column < 144)) then
            temp_char_address <= ZERO; 
            score_on<='1';
				hearts_on<='0';

        elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 512 and pixel_column < 528)) then
            temp_char_address <= HEARTSIGN; 
            hearts_on<='1';
				score_on<='0';
			elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 528 and pixel_column < 544)) then
            temp_char_address <= HEARTSIGN; 
         hearts_on<='1';
			score_on<='0';
			elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 544 and pixel_column < 560)) then
            temp_char_address <= HEARTSIGN; 
            hearts_on<='1';
				score_on<='0';

        -- elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 512 and pixel_column < 528)) then
        --         temp_char_address <= Heart_top_left;
        --         hearts_on<='1';

        -- elsif((pixel_row >= 16 and pixel_row < 32) and (pixel_column >= 528 and pixel_column < 544)) then
        --         temp_char_address <= Heart_top_right;
        --         hearts_on<='1';

    
        -- elsif((pixel_row >= 32 and pixel_row < 48) and (pixel_column >= 512 and pixel_column < 528)) then
        --         temp_char_address <= Heart_bot_left;
        --         hearts_on<='1';

    
        -- elsif((pixel_row >= 32 and pixel_row < 48) and (pixel_column >= 528 and pixel_column < 544)) then
        --         temp_char_address <= Heart_bot_right;
        --         hearts_on<='1';

        else
        temp_char_address <= SPACE;
		  score_on<='0';
		  hearts_on<='0';
        end if;
    end if;
end process character_score;

character_address<=temp_char_address;

end architecture behaviour;