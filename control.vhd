----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:36 10/08/2021 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
	port(
			clk, tx_done,tx_stat: in std_logic;
			uni1,uni2,deca1,deca2: in std_logic_vector(7 downto 0);
			ang1: in integer range 0 to 2530;
			enviar: out std_logic_vector(7 downto 0);
			tx_enable: out std_logic
			--ENS1,ENS2: out std_logic
	);
end control;

architecture Behavioral of control is
		signal contador: integer range 0 to 19:=0;
		signal segundero: integer range 0 to 9600000:=0;
		signal angleS: std_logic:='0';
		signal angleD: std_logic_vector(7 downto 0):="00110000";
		signal angleU: std_logic_vector(7 downto 0):="00110000";
begin
	main: process(clk,tx_done)
	begin

		if rising_edge(clk) then
			if segundero = 9599999 then
				segundero <= 0;
				if tx_stat = '0' then
						tx_enable <= '0';
						contador <= contador + 1;
				end if;
			else
				segundero <= segundero +1;
			end if;
			
			if tx_done = '1' then					
				if contador < 18 then
					contador <= contador + 1;
				else
					contador <= 0;
					tx_enable <= '1';
				end if;
			end if;
			
			case contador is
						when 1 => enviar <= "00110001";
						when 2 => enviar <= "00101100";
						when 3 => 
								if angleS = '0' then
									enviar <= "00101101";
								else
									enviar <= "00101011";
								end if;
						when 4 => enviar <= angleD;
						when 5 => enviar <= angleU;
						when 6 => enviar <= "00101100";
						when 7 => enviar <= deca1;
						when 8 => enviar <= uni1;
						when 9 => enviar <= "00111011";
						when 10 => enviar <= "00110010";
						when 11 => enviar <= "00101100";
						when 12 =>
								if angleS = '0' then
									enviar <= "00101101";
								else
									enviar <= "00101011";
								end if;
						when 13 => enviar <= angleD;
						when 14 => enviar <= angleU;
						when 15 => enviar <= "00101100";
						when 16 => enviar <=  deca2;
						when 17 => enviar <= uni2;
						when 18 => enviar <= "00111011";
						when others  => enviar <= "00111011";
			  end case;
		end if;
	end process main;
	
	conv_deg: process(clk, ang1)
	begin
		
		if rising_edge(clk) then
					
			if ang1 < 1480 then
				angleS <= '1';
			else
				angleS <= '0';
			end if;
			if ang1 = 470 or ang1 = 2470 then
				angleD <= "00111001";
				angleU <= "00110000";
			elsif ang1 = 530 or ang1 = 2410 then
				angleD <= "00111000";
				angleU <= "00110101";
			elsif ang1 = 590 or ang1 = 2370 then
				angleD <= "00111000";
				angleU <= "00110000";
			elsif ang1 = 650 or ang1 = 2310 then
				angleD <= "00110111";
				angleU <= "00110101";
			elsif ang1 = 710 or ang1 = 2250 then
				angleD <= "00110111";
				angleU <= "00110000";
			elsif ang1 = 770 or ang1 = 2190  then
				angleD <= "00110110";
				angleU <= "00110101";
			elsif ang1 = 830 or ang1 = 2130 then
				angleD <= "00110110";
				angleU <= "00110000";
			elsif ang1 = 890 or ang1 = 2070 then
				angleD <= "00110101";
				angleU <= "00110101";
			elsif ang1 = 950 or ang1 = 2010 then
				angleD <= "00110101";
				angleU <= "00110000";
			elsif ang1 = 1010 or ang1 = 1950 then
				angleD <= "00110100";
				angleU <= "00110101";
			elsif ang1 = 1070 or ang1 = 1890 then
				angleD <= "00110100";
				angleU <= "00110000";
			elsif ang1 = 1130 or ang1 = 1830 then
				angleD <= "00110011";
				angleU <= "00110101";
			elsif ang1 = 1190 or ang1 = 1770 then
				angleD <= "00110010";
				angleU <= "00110101";
			elsif ang1 = 1250 or ang1 = 1710 then
				angleD <= "00110010";
				angleU <= "00110000";
			elsif ang1 = 1310 or ang1 = 1650  then
				angleD <= "00110001";
				angleU <= "00110101";
			elsif ang1 = 1370 or ang1 = 1590  then
				angleD <= "00110001";
				angleU <= "00110000";
			elsif ang1 = 1430 or ang1 = 1530  then
				angleD <= "00110000";
				angleU <= "00110101";
			elsif ang1 = 1470 or ang1 = 1490  then
				angleD <= "00110000";
				angleU <= "00110000";
			end if;
		end if;
	end process conv_deg;
end Behavioral;

