library ieee; 
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity deco is 


port (  
      sel : in std_logic_vector ( 1 downto 0);
		y : out std_logic_vector ( 3 downto 0); 
      en, clr : in std_logic

     ); -- aa
end deco; 


architecture deco_arch of deco is 
begin 

   process (clr, en, sel)
	  begin 
	  
     if (clr = '1') then 
	      y <= "0000";
	  elsif (en = '1') then 
	      case (sel) is 
			     when "00" => y <= "0000" ;
				  when "01" => y <= "0001";
				  when "10" => y <= "0010"; 
				  when others => y <= "1111";
				  
			end case; 
			
		end if;
	end process; 
	    
	   

end deco_arch; 
