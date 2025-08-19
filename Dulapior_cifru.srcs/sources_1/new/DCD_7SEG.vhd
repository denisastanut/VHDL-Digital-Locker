library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCD7SEG is
     Port ( S: in std_logic_vector(3 downto 0);
            Q: out std_logic_vector (7 downto 0));
end DCD7SEG;

architecture arh_DCD of DCD7SEG is

begin
with S select
    Q <= "11000000" when "0000",--0
         "11111001" when "0001",--1
         "10100100" when "0010",--2
         "10110000" when "0011",--3
         "10011001" when "0100",--4
         "10010010" when "0101",--5
         "10000010" when "0110",--6
         "11111000" when "0111",--7
         "10000000" when "1000",--8
         "10010000" when "1001",--9
         "10001000" when "1010",--A
         "10000011" when "1011",--b
         "11000110" when "1100",--C
         "10100001" when "1101",--d
         "10000110" when "1110",--E
         "10001110" when "1111",--F
         "11111111" when others;--OFF
end arh_DCD;