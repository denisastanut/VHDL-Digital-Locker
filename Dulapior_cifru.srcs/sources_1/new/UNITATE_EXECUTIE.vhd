library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UE_DULAP is
    Port( 
          clk : in STD_LOGIC;  
          btn_ok : in STD_LOGIC;
          btn_rst : in STD_LOGIC;
          btn_up : in STD_LOGIC;
          btn_down : in STD_LOGIC;
          write_en : in std_logic;
          comp_in  : in std_logic;
          caracter_curent : in integer range 0 to 5;
          en_cnt1 : in std_logic;
          en_cnt2 : in std_logic;
          en_cnt3 : in std_logic;
          rst_cnt1 : in std_logic;
          rst_cnt2 : in std_logic;
          rst_cnt3 : in std_logic;
          comparare_egal : out STD_LOGIC;
          catozi: out STD_LOGIC_VECTOR(7 DOWNTO 0);
          anozi: out STD_LOGIC_VECTOR(7 DOWNTO 0) );
end UE_DULAP;

architecture arh_UE of UE_DULAP is

--NUMARATOR
component NUMARATOR_DULAP is
    Port ( up : in STD_LOGIC;
           down : in STD_LOGIC;
           clk: in STD_LOGIC;
           en : in std_logic; 
           reset: in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR(3 downto 0));
end component;

--SSD
component sevensegment is
	port(clock : in std_logic;
	     c1,c2,c3 : in std_logic_vector(3 downto 0);
	     catod : out std_logic_vector(7 downto 0); 
	     anod : out std_logic_vector(7 downto 0)
	     );
end component; 

--Memorie Ram + Comparator
component ram IS
  GENERIC(
    d_width : INTEGER := 4; --3 cuvinte x 4 biti
    size : INTEGER := 6);  
  PORT(
    clk : in   std_logic;
    wr_ena : IN   STD_LOGIC;                             --write enable
    addr : IN   INTEGER RANGE 0 TO size-1;             --addresa write/read(nr la caracter)
    data_in1 : IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);
    data_in2 : IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);
    data_in3 : IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);
    comp_in : in std_logic;  
    comparare: out  std_logic -- 1 = codul este bun, 0 = codul nu este bun 
    ); 
end component;

signal  nr_introdus1, nr_introdus2, nr_introdus3: std_logic_vector(3 downto 0):= (others=>'0');

begin
CAR1 : NUMARATOR_DULAP port map(up => btn_up, down => btn_down, reset => rst_cnt1, clk => clk, en => en_cnt1, cout => nr_introdus1);
CAR2 : NUMARATOR_DULAP port map(up => btn_up, down => btn_down, reset => rst_cnt2, clk => clk, en => en_cnt2, cout => nr_introdus2);
CAR3 : NUMARATOR_DULAP port map(up => btn_up, down => btn_down, reset => rst_cnt3, clk => clk, en => en_cnt3, cout => nr_introdus3);

MEMORIE : ram port map(
    clk  => clk,
    wr_ena => write_en,
    addr => caracter_curent,
    data_in1 => nr_introdus1,
    data_in2 => nr_introdus2,
    data_in3 => nr_introdus3,
    comp_in => comp_in,
    comparare=> comparare_egal
    ); 

AFIS : sevensegment port map(clock=>clk,c1=>nr_introdus1,c2=>nr_introdus2, c3=>nr_introdus3, catod=>catozi,anod=>anozi);

end arh_UE;