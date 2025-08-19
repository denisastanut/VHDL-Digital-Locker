library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity sevensegment is
	port(clock : in std_logic;
	     c1,c2,c3 : in std_logic_vector(3 downto 0);
	     catod : out std_logic_vector(7 downto 0); 
	     anod : out std_logic_vector(7 downto 0));
end; 

architecture arh_SSD of sevensegment is 

component DCD7SEG is
     Port ( S: in std_logic_vector(3 downto 0);
            Q: out std_logic_vector (7 downto 0));
end component;


signal clkdiv : std_logic_vector(15 downto 0);
signal clk : std_logic;
signal cifra : std_logic_vector(3 downto 0);

begin
	
	convertire : DCD7SEG port map ( cifra, catod );
	
	process(clock)
	begin			
		if(clock'event and clock='1')then
		  clkdiv <= clkdiv+1;
		end if;
	end process;
	clk<=clkdiv(15); 
	
	process(clk)
	variable x: integer:=0;
	begin					
		if(rising_edge(clk)) then
			if (x=0)  then
				anod<="11111011";  
				cifra<=c1;
				x:=x+1;	 
			elsif (x=1)then
				anod<="11111101";  
				cifra<=c2;
				x:=x+1;
			elsif (x=2) then
				anod<="11111110";  
				cifra<=c3;
				x:=0;	
			end if;
		end if;
	end process;
end arh_SSD;