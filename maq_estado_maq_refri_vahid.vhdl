library ieee;
use ieee.numeric_std.all;
--use ieee.unsigned.all; 
use ieee.std_logic_1164.all; 

entity fsm  is port
( 
op : in std_logic_vector(3 downto 0);
PC_clr, I_rd, PC_inc, IR_ld : out bit; 
clk_ext,rst: in std_logic;
RF_Rp_zero: out std_logic;
ledinicio, ledbusca,leddecodificacao, ledcarregar, ledarmazenar, ledsomar,ledcarregarcte,ledsubtrair,ledsaltarsezero, ledlatar : out bit

);

end fsm;


architecture fsm_arch of fsm is 
type state_type is (inicio, busca,decodificacao,carregar,armazenar,somar,carregarcte,subtrair,saltarsezero,saltar);
signal state: state_type;
signal clk: std_logic; 

component divisor is
port ( 
		reset:			in			std_logic;
		clk:			in			std_logic;
		clock:			out			std_logic
		);
end component;
begin 

div: divisor port map ( reset => rst, clk => clk_ext, clock => clk ); 
process (clk,rst)
begin
 if (rst = '1') then 
   state <= inicio;
   elsif (rising_edge(clk)) then
      case state is 
	       when inicio => 	
		    state <= busca;	
	       when busca => 
			 state <= decodificacao;
		    when decodificacao => 
			   if (op = "0000") then 
				   state <= carregar;
				elsif (op = "0001" ) then 
				    state <= armazenar;
				elsif (op = "0010") then 
				    state <= somar;
				elsif (op = "0011")then 
				    state <= carregarcte;
				elsif (op = "0100")then 
				    state <= subtrair;
				elsif (op = "0101")then 
				    state <= saltarsezero;
				else 
				state <= busca; 
				end if;
			when carregar =>
			state <= busca;
			when armazenar => 
			state <= busca;
			when somar => 
			state <= busca;
			when carregarcte => 
			state <= busca;
			when subtrair => 
			state <= busca;
			when saltarsezero =>
			if (op(3 downto 0)= "1111") then
       RF_Rp_zero <= '0';
	     state <= busca;

elsif(op(3 downto 0)= "0000") then  -- REPRESENTA A OPERAÇÃO SALTAR SE ZERO
      RF_Rp_zero <= '1';
	state <= saltar;
end if;
			when saltar =>
			   state <= busca;
			end case; 
end if; 
 end process; 
 
 process (state)
 begin
 if (state = inicio ) then  
	ledinicio <= '1'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';	
 elsif (state = busca) then 
   ledinicio <= '0'; ledbusca <= '1'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';
 elsif (state = decodificacao)then
 ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '1'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';	
 elsif (state = carregar)then 
ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '1'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';	 
 elsif (state = armazenar)then 
   ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '1'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';	
 elsif (state = somar)then 
    ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '1';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';	
  elsif (state = carregarcte)then 
  ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '1';
	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '0';	
	elsif (state = subtrair) then 
	ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '1'; ledsaltarsezero <= '0'; ledlatar <= '0';	
	elsif (state = saltarsezero) then 
	ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
	ledsubtrair <= '0'; ledsaltarsezero <= '1'; ledlatar <= '0';
   elsif (state = saltar) then 
   ledinicio <= '0'; ledbusca <= '0'; leddecodificacao <= '0'; ledcarregar <= '0'; ledarmazenar <= '0'; ledsomar <= '0';ledcarregarcte <= '0';
  	ledsubtrair <= '0'; ledsaltarsezero <= '0'; ledlatar <= '1';	
end if; 
end process; 	

end fsm_arch; 
