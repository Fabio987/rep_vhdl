library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity cod is 

port (  
      y1, y2, y3,y4 : in std_logic; 
		sai : out std_logic_vector ( 1 downto 0)
		
	 
	 
	   ); 
end cod; 

architecture cod_arch of cod is 

begin 

  sai <= "01" when y1 = '1' else 
         "10" when y2 = '1' else 
			"11" when y3 = '1' else 
			"00" ;
			

end cod_arch; 
