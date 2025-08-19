library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ram is
  GENERIC(
    d_width: INTEGER := 4; --3 cuvinte x 4 biti
    size : INTEGER := 6);  
  PORT(
    clk : in std_logic;
    wr_ena : in STD_LOGIC;                           
    addr  : in INTEGER RANGE 0 TO size-1;             
    data_in1 : in STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);
    data_in2 : in STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);
    data_in3 : in STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);
    comp_in : in std_logic;  
    comparare: out std_logic 
    ); 
END ram;

architecture arh_ram OF ram is
  type memory IS ARRAY(size-1 DOWNTO 0) OF STD_LOGIC_VECTOR(d_width-1 DOWNTO 0); 
  signal ram : memory;                                                      
  signal addr_int : INTEGER RANGE 0 TO size-1;                                   
begin

  process(clk, wr_ena)
  begin
    if falling_edge(clk) then
      if(wr_ena = '1') THEN     
        case addr is
            when 0 => ram(0) <= data_in1; --caracterul 1 din cod
            when 1 => ram(1) <= data_in2; --caracterul 2 din cod
            when 2 => ram(2) <= data_in3; --caracterul 3 din cod
            when 3 => ram(3) <= data_in1; --caracterul 1 din introdus
            when 4 => ram(4) <= data_in2; --caracterul 2 din introdus
            when 5 => ram(5) <= data_in3; --caracterul 3 din introdus   
        end case;    
      end if;
      addr_int <= addr;    
    end if;  
    if rising_edge(clk) then
        if comp_in = '1' then
            if (TO_INTEGER(unsigned(ram(0))) = TO_INTEGER(unsigned(ram(3)))) and (TO_INTEGER(unsigned(ram(1))) = TO_INTEGER(unsigned(ram(4)))) 
            and (TO_INTEGER(unsigned(ram(2))) = TO_INTEGER(unsigned(ram(5)))) then
                comparare <= '1';
            else comparare <= '0';
            end if;
        end if;
    end if;
 end process;

END arh_ram;