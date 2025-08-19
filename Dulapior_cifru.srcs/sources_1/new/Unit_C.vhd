library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC_DULAP is
    Port( ok : in STD_LOGIC;
          clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          comp : in STD_LOGIC;
          liber_ocupat : out STD_LOGIC;
          introdu_caractere : out STD_LOGIC;
          rst_cnt1 : out std_logic;
          en_cnt1 : out STD_LOGIC;
          rst_cnt2 : out std_logic;
          en_cnt2 : out STD_LOGIC;
          rst_cnt3 : out std_logic;
          en_cnt3 : out STD_LOGIC;
          en_comp : out std_logic;
          caracter_curent : out integer range 0 to 5;
          write_en : out std_logic);
end UC_DULAP;

architecture arh_UC of UC_DULAP is
    type state_type is (
        INIT,START, LED_OFF, INTRODU, C1, C2, C3, 
        COMPARARE, BLOCARE, DEBLOCARE, INTRODU_D,
		C1_D, C2_D, C3_D);
    signal stare : state_type;

begin 

    process(clk, reset)
    begin
        if reset = '1' then
            stare <= INIT;
            liber_ocupat <= '0';
            introdu_caractere <= '0';
            en_cnt1 <= '0';
            rst_cnt1 <= '1';
            en_cnt2 <= '0';
            rst_cnt2 <= '1';
            en_cnt3 <= '0';
            rst_cnt3 <= '1';  
            write_en <= '0';
            en_comp <= '0';
            stare <= INIT;
		elsif rising_edge(clk) then
			case stare is
                when INIT =>
                    stare <= START;
                    liber_ocupat <= '0';
                    introdu_caractere <= '0';
                    caracter_curent <= 0;
                    en_cnt1 <= '0';
                    rst_cnt1 <= '1';
                    en_cnt2 <= '0';
                    rst_cnt2 <= '1';
                    en_cnt3 <= '0';
                    rst_cnt3  <= '1'; 
                    en_comp <= '0';
                    
                when START =>
                    liber_ocupat <= '0';
                    write_en <= '0';
                    rst_cnt1  <= '0';
                    rst_cnt2 <= '0';
                    rst_cnt3 <= '0';
                    
                    if ok = '1' then
                        stare <= INTRODU;
                        introdu_caractere <= '1';
                    else 
                    end if;
                
                when INTRODU =>
                    introdu_caractere <= '1';
                    if ok = '1' then
                        stare <= C1;
                    end if;
                
                when C1 =>
                    write_en <= '0';
                    en_cnt1 <= '1'; 
                    caracter_curent <= 0;
           
                    if ok = '1' then
                        en_cnt1 <= '0';
                        write_en <= '1'; 
                        stare <= C2;
                    end if;
                
                when C2 =>
                    write_en <= '0';
                    en_cnt2 <= '1';
                    caracter_curent <= 1;

                    if ok = '1' then
                        en_cnt2 <= '0'; 
                        write_en <= '1';
                        stare <= C3;
                    end if;
                
                when C3 =>
                    write_en <= '0';
                    en_cnt3 <= '1'; 
                    caracter_curent <= 2;
                    
                    if ok = '1' then
                        en_cnt3 <= '0'; 
                        write_en <= '1';
                        stare <= BLOCARE;
                    end if;
					
				when BLOCARE =>
                    write_en <= '0';    
                    rst_cnt1 <= '0';
                    rst_cnt2 <= '0';
                    rst_cnt3 <= '0';
                    liber_ocupat<='1';
                    
                    if ok = '1' then
                        stare <= INTRODU_D;
                        introdu_caractere <= '1';
                    end if;	
					
                when INTRODU_D =>
                    write_en <= '0';
                    rst_cnt1  <= '1';
                    rst_cnt2 <= '1';
                    rst_cnt3  <= '1'; 
                    introdu_caractere <= '1';
                    
                    if ok = '1' then
                        rst_cnt1 <= '0';
                        rst_cnt2 <= '0';
                        rst_cnt3  <= '0'; 
                        stare <= C1_D;
                    end if;

                when C1_D =>
                    write_en <= '0';
                    en_cnt1 <= '1'; 
                    caracter_curent <= 3;
           
                    if ok = '1' then
                        en_cnt1 <= '0';
                        write_en <= '1'; 
                        stare <= C2_D;
                    end if;
                
                when C2_D =>
                    write_en <= '0';
                    en_cnt2 <= '1'; 
                    caracter_curent <= 4;
           
                    if ok = '1' then
                        en_cnt2  <= '0';
                        write_en <= '1'; 
                        stare <= C3_D;
                    end if;                
                
                when C3_D =>
                    write_en <= '0';
                    en_cnt3 <= '1'; 
                    caracter_curent <= 5;
           
                    if ok = '1' then
                        en_cnt3 <= '0';
                        write_en <= '1'; 
                        stare <= COMPARARE;
                        en_comp <= '1';
                    end if;
					
				when COMPARARE =>
				    en_comp <= '1';
                    write_en <= '0';
                    rst_cnt1 <= '1';
                    rst_cnt2 <= '1';
                    rst_cnt3 <= '1';
                    if comp = '1' then
                        en_comp <= '0';
                        stare <= DEBLOCARE;
                        liber_ocupat <= '0';
                    else
                        en_comp <= '0';
                        stare <= BLOCARE;
                        liber_ocupat <= '1';
                    end if;
                
                when DEBLOCARE =>
                    rst_cnt1 <= '0';
                    rst_cnt2 <= '0';
                    rst_cnt3 <= '0';
                    liber_ocupat <= '0';  
					stare <= START;
                
                when others =>
                    stare <= START;
            end case;
        end if;
    end process;

end arh_UC;