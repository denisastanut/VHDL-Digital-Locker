library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity NUMARATOR_DULAP is
    Port ( up : in STD_LOGIC;
           down : in STD_LOGIC;
           clk: in STD_LOGIC;
           en : in std_logic; 
           reset: in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR(3 downto 0));
end NUMARATOR_DULAP;

architecture arh_numarator of NUMARATOR_DULAP is

signal c: std_logic_vector(3 downto 0) :=(others => '0');

begin

process(clk,en,reset)
begin
    if reset = '1' then 
        c <= (others => '0');
    elsif en = '1' then  
         if rising_edge(clk) then
             if up= '1' and down='0' then c <= c + 1;
             elsif down = '1'and up='0' then c <= c - 1;
            end if;
       end if;
    end if;
end process;

cout <= c;

end arh_numarator;