library ieee;    -- Bibliotecas
use ieee.std_logic_1164.all;   -- BIBLIOTECAS PADRÃO
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 

entity ula is port                 -- ENTRADAS E SAÍDAS DA ULA
(
--A, B : in unsigned (15 downto 0); -- NECESSÁRIO PARA SIMULAR NA PRÁTICA
S : out unsigned (15 downto 0);
s1, s0: in bit;
zero : out bit);
end ula; 

Architecture ula_arch of ula is 

SIGNAL A : unsigned (15 downto 0);  -- CONSTANTES PARA SIMULAR NA PRÁTICA
SIGNAL B : unsigned (15 downto 0);
begin
A <= "0000000000000000";
B <= "0000000000000000";

process (s1, s0, A, B)     -- PROCESSO PARA SIMULAÇÃO DA ULA
begin

if ((s1 = '0') and (s0 = '0')) then  -- SE O SINAL DE CONTROLE FOR "00", A SAÍDA S RECEBE A ENTRADA "A".
   S <= A;
 elsif ((s1= '0')and (s0 = '1')) then -- SE NÃO, SE O SINAL DE CONTROLE FOR "01", A SAÍDA S RECEBE A ENTRADA "A + B".
  
      S <= A + B; 
  elsif ((s1= '1')and (s0 = '0')) then  -- SE NÃO, SE O SINAL DE CONTROLE FOR "10", A SAÍDA S RECEBE A ENTRADA "A - B".
        S <= A - B; 
else 
   S <= "ZZZZZZZZZZZZZZZZ"; -- SE NÃO,  A SAÍDA S RECEBE A ENTRADA ALTA IMPEDÂNCIA.
end if; 

end process; 

process (A)   -- PROCESSO PARA O DETECTOR DE ZERO
begin 
if (A = "0000000000000000")then -- SE "A" FOR IGUAL A ZERO, A SAÍDA ZERO RECEBE 1 
  zero <= '1';
else            -- SE NÃO, A SAÍDA ZERO RECEBE 0
zero <= '0';

end if; 

end process;

end ula_arch; 
