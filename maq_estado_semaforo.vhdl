library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity SEMAFORO IS 
port (  
      
  clk, reset,  x : in std_logic


     );
end SEMAFORO; 

ARCHITECTURE SEMAFORO_ARCH OF SEMAFORO IS 
type est is (inicio, esperar, verde, amarelo, vermelho);
signal estado : est;

begin 

process (clk, reset, x)
begin 

if (reset = '1') then 
    estado <= inicio; 
elsif (rising_edge(clk)) then 
   case estado is 
     when inicio => 
	    --  x  <= '0';
		   estado <= esperar;	
		when esperar =>
		   estado <= verde ;
		when verde =>
		    if (x = '0') or ( x = '1') then 
			    estado <= amarelo;
			 else 
			     estado <= verde;
			  end if;
		when amarelo =>
		      if ( x = '1') then 
				  estado <= amarelo ;
				 elsif ( x = '0') then 
				   estado <= vermelho;
		       end if; 
				    
		when vermelho => 
		    if ( x = '0')then 
			    estado <= verde;
			 elsif ( x = '1') then 
			    estado <= amarelo;
			  end if; 
		end case;
end if; 
end process;

end SEMAFORO_ARCH;
