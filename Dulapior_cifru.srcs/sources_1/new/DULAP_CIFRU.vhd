library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DULAP_CIFRU is
    Port ( clk : in STD_LOGIC;
           btn_up : in STD_LOGIC;
           btn_down : in STD_LOGIC;
           btn_reset : in STD_LOGIC;
           btn_ok : in STD_LOGIC;
           introdu_caractere : out STD_LOGIC;
           liber_ocupat : out STD_LOGIC;
           cat : out STD_LOGIC_VECTOR(7 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0));
end DULAP_CIFRU;

architecture Behavioral of DULAP_CIFRU is

component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component MPG;

component UC_DULAP is
    Port( ok : in STD_LOGIC;
          clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          comp  : in STD_LOGIC;
          liber_ocupat : out STD_LOGIC;
          introdu_caractere : out STD_LOGIC;
          rst_cnt1 : out std_logic;
          en_cnt1 : out STD_LOGIC;
          rst_cnt2 : out std_logic;
          en_cnt2 : out STD_LOGIC;
          rst_cnt3 : out std_logic;
          en_cnt3: out STD_LOGIC;
          en_comp : out std_logic;
          caracter_curent : out integer range 0 to 5;
          write_en : out std_logic
           );
end component;

component UE_DULAP is
    Port( clk : in STD_LOGIC;  
          btn_ok : in STD_LOGIC;
          btn_rst : in STD_LOGIC;
          btn_up : in STD_LOGIC;
          btn_down : in STD_LOGIC;
          write_en : in std_logic;
          comp_in : in std_logic;
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
end component;

signal comp, en_comp : std_logic;
signal ok, rst, up, dn : std_logic;
signal rst1, rst2, rst3 : std_logic;
signal en1, en2, en3 : std_logic;
signal sel : integer range 0 to 5;
signal we : std_logic;

begin
MPG_OK : MPG port map(btn=>btn_ok, clk=>clk, en=>ok);
MPG_UP : MPG port map(btn=>btn_up, clk=>clk, en=>up);
MPG_DN : MPG port map(btn=>btn_down, clk=>clk, en=>dn);
MPG_RST: MPG port map(btn=>btn_reset, clk=>clk, en=>rst);

Unit_Control: UC_DULAP port map (
          ok => ok,
          clk => clk,
          reset => rst,
          comp => comp,
          liber_ocupat => liber_ocupat,
          introdu_caractere => introdu_caractere,
          rst_cnt1 => rst1,
          en_cnt1 => en1,
          rst_cnt2 => rst2,
          en_cnt2 => en2,
          rst_cnt3=> rst3,
          en_cnt3 => en3,    
          en_comp => en_comp,
          caracter_curent => sel,
          write_en => we);

Unit_ex: UE_DULAP port map( 
          clk => clk,  
          btn_ok => ok,
          btn_rst => rst,
          btn_up => up,
          btn_down => dn,
          write_en => we,
          comp_in => en_comp,
          caracter_curent => sel,          
          en_cnt1 => en1,
          en_cnt2 => en2,
          en_cnt3 => en3,
          rst_cnt1 => rst1,
          rst_cnt2 => rst2,
          rst_cnt3 => rst3,          
          comparare_egal => comp,
          catozi => cat,
          anozi => an    );


end Behavioral;