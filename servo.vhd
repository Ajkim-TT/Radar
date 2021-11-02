----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:10:05 08/29/2021 
-- Design Name: 
-- Module Name:    servo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std .all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity servo is
	port(
		clk: in std_logic;
		salida1: out std_logic;
		salida2: out std_logic;
 		angular: out integer range 0 to 2500
	);
end servo;

architecture Behavioral of servo is
	signal angulo: integer range 0 to 2530:=450;
	signal aumento: integer:=20;
	--signal direc: std_logic:='1';
begin
	
	ciclo_completo: process(clk, angulo)
	variable count1: integer range 0 to 240000;
	begin
		angular <= angulo;
			if rising_edge(clk) then
				if count1 = 0 then
						salida1 <= '1';
						salida2 <= '1';
						angulo <= angulo + aumento;

				if angulo > 2500 then 
					aumento <= -20;
				end if;
				if angulo <= 450 then
					aumento <= 20;
				end if;
					
				elsif count1 = angulo*10 then
					salida1 <= '0';
					salida2 <= '0';
				end if;
				
				if count1 = 239999 then
					count1 := 0;
				else
					count1 := count1 + 1;
				end if;	
			end if;
		end process ciclo_completo;
	
end Behavioral;

