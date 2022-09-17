library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ordena is 

port ( 
      clk, reset, a, e, f : in std_logic;
      pass_clr, index_clr, temp_clr: out std_logic;
		pass_ld, index_ld, temp_ld : out std_logic 


      );
end ordena;
+

architecture ordena_arch of ordena is 
type est is (inicio, espera, pass, indexar, trocar );
 signal estado : est;
begin 
 process (clk, reset) 
begin 
   if (reset = '1') then 
	   estado <= inicio;
	elsif (rising_edge(clk)) then 
	   case estado is 
		  when  inicio  =>
		    
		      estado <= espera;
		  when  espera =>
		      if  (a = '1') then  -- pass < N  
			    estado <= pass;
				 else 
				   estado <= inicio; -- pass > n 
				 end if;
			
			when pass  =>
			    
				  -- if ( f = '1') then 
					  estado <= indexar; 
			when indexar => 
			  if ( f = '1') then    -- i < n 
			     if ( e = '1') then   --  m [i] > m(i+1)
				    estado <= trocar; 
					else
					  estado <= indexar; 
					 end if; 
				else 
				   estado <= espera; 
					  
					 
				end if;
			      	    
			   -- estado <= trocar;
			 when trocar =>
			    estado <= indexar;
				 
		    end case;
		 end if;
end process;

pass_clr <= '1' when estado = inicio else '0';
index_clr  <= '1' when estado = inicio else '0';
temp_clr <= '1' when estado = inicio else '0';

index_ld <= '1' when estado = indexar else '0'; 
pass_ld <= '1' when estado = pass else '0';
temp_ld <= '1' when estado = trocar else '0'; 
