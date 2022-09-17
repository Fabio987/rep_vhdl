library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity maq is

port (
  clk, reset,c : in std_logic;
  a, s : in std_logic_vector (7 downto 0);
  d : out std_logic

     );

end maq;

architecture maq_arch of maq is

component up is

port (
       a, s : in std_logic_vector ( 7 downto 0);
                clk, tot_clr, tot_ld : in std_logic;
                 tot_it_s: out std_logic



     );
end component up;

component uc is


port (
     clk, reset, c, tot_it_s : in std_logic;
       d, tot_ld, tot_clr : out std_logic

    );
end  component uc;

signal tot_clr, tot_ld, tot_it_s: std_logic;
begin

up_inst: up port map (a,s,clk,tot_clr,tot_ld,tot_it_s);
uc_inst: uc port map (clk,reset,c,tot_it_s,d,tot_ld,tot_clr);

end maq_arch;

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
--e ieee.unsigned.all;

entity uc is


port (
     clk, reset, c, tot_it_s : in std_logic;
                d, tot_ld, tot_clr : out std_logic

    );
end uc;

architecture uc_arch of uc is
type tipo_estado is (inicio, esperar, somar, fornecer);
signal estado: tipo_estado;

begin

process(clk, reset,tot_it_s,c)
 begin
 if (reset = '0') then
     estado <= inicio;
          d <= '0';
        --       tot_clr <= '1';
        --        tot_ld <= '0';
 elsif (rising_edge(clk)) then
    case (estado) is
           when inicio =>
                  d <= '0';
--  tot_clr <= '1';
                --  tot_ld <= '0';
                  estado <= esperar;
                 when esperar =>
                 --   tot_clr <= '0';
                --       tot_ld <= '0';

                    -- tot_clr <= '0';
                    if (c = '1') then
                          estado <= somar;
                         else

          if (tot_it_s = '1') then
                           estado <= fornecer;
                        elsif  (tot_it_s = '0')then
                          estado <= esperar;

                end if;
                end if;
                 --  tot_clr <= '0';

                   when somar =>
                        --  tot_clr <= '0';
                        --  tot_ld <= '1';
                          estado <= esperar;
                         when fornecer =>
                           d <= '1';
                         estado <= inicio;
                         end case;
                end if;
                end process;
tot_clr <= '1' when estado = inicio else '0';
tot_ld <= '1' when estado = somar else '0';


                                end uc_arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity up is

port (
        a, s : in std_logic_vector ( 7 downto 0);
                clk, tot_clr, tot_ld : in std_logic;
                 tot_it_s: out std_logic



     );
end up;

architecture up_arch of up is


component somador is

port (
       A, B : in std_logic_vector (7 downto 0);
                 o : out std_logic_vector(7 downto 0));

end component somador;



component registrador is

port (
       clk, tot_clr, tot_ld : in std_logic;
tot_in : in std_logic_vector (7 downto 0);
                 tot_out: out std_logic_vector (7 downto 0)
     );
end  component registrador;


component comparador is

port (
     X, Y : in std_logic_vector( 7 downto 0);
           tot_it_s : out std_logic

          );
end  component comparador;

signal A_signal: std_logic_vector( 7 downto 0);
signal tot_in: std_logic_vector ( 7 downto 0);

begin

som: somador port map (A_signal,a, tot_in);
reg: registrador port map (clk, tot_clr,tot_ld,tot_in, A_signal);
comp : comparador port map (A_signal,s,tot_it_s);

end up_arch;
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity registrador is

port (
       clk, tot_clr, tot_ld : in std_logic;
       tot_in : in std_logic_vector (7 downto 0);
                 tot_out: out std_logic_vector (7 downto 0)
     );
end registrador;

architecture registrador_arch of registrador is
begin

        process (clk,tot_clr,tot_ld,tot_in)
begin
    if ( tot_clr = '1')  then
             tot_out <= "00000000";
           elsif (rising_edge(clk)) then
                 if (tot_ld = '1') then
                    tot_out <= tot_in ;
                        end if;
        end if;
end process;

end     registrador_arch;
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;


entity somador is

port (
       A, B : in std_logic_vector (7 downto 0);
                 o : out std_logic_vector(7 downto 0));

 end somador;

 architecture somador_arch of somador is
 begin

          o <= std_logic_vector (unsigned (A) + unsigned (B));

  end somador_arch;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.std_logic_unsigned.all;

entity comparador is

port (
     X, Y : in std_logic_vector( 7 downto 0);
           tot_it_s : out std_logic

          );
end comparador;

architecture comparador_arch of comparador is

begin

process(X,Y)
begin

 if ( (unsigned(X)) >= (unsigned(Y))) then
    tot_it_s <= '1';
 else
    tot_it_s <= '0';
end if;

end process;
end comparador_arch;
