library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity soma_vetor is 
port (  
     clear_s, clear_i, tot_s, tot_i  : out std_logic; 
	   clk, reset: in std_logic;
     n, i: in  std_logic_vector ( 3 downto 0)


     );
end soma_vetor; 

architecture soma_vetor_arch of soma_vetor is 
type est is (inicio, esperar, somar, incrementar, resultado);
signal estado: est; 

begin
  process ( clk, reset)
begin 
  if ( reset = '1') then 
     estado <= inicio;
	elsif ( rising_edge(clk)) then
	   case (estado) is 
		   when inicio =>
			  estado <= esperar;
			 when esperar => 
			   
				if ( i  = '1') then  -- i < N
				  estado <= somar;
				 else 
				   estado <= resultado; 
				end if;
			 when somar =>
			   estado <= incrementar; 
				  
			  when incrementar =>
			   estado <= esperar;
				when resultado =>
				  estado <= inicio;
				
				
			end case;
	 end if; 
 end process; 
 
  clear_s <= '1' when  estado = inicio  else '0';
  clear_i <= '1' when estado = inicio else '0';
  tot_s <= '1' when estado = somar else '0';
  tot_i <= '1' when estado = incrementar else '0'; 










end soma_vetor_arch;
