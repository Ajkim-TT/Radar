----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:59:09 09/20/2021 
-- Design Name: 
-- Module Name:    ultrasonic - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std .all;

entity ultrasonic is
	port(
	Clk, ECHO: in std_logic;
	unity, deca: out std_logic_vector(7 downto 0);
	TRIG: out std_logic
	);
end ultrasonic;

architecture rtl of ultrasonic is
signal u: std_logic_vector(7 downto 0);
signal d: std_logic_vector(7 downto 0);
signal microseconds: std_logic;
signal counter: std_logic_vector(17 downto 0):="000000000000000000";
signal trigger: std_logic;

begin
	
	micro_segundo: process(Clk)
	variable count0: integer range 0 to 7;
	begin
		if rising_edge(Clk) then
			if count0 = 5 then
				count0 := 0;
			else
				count0 := count0 + 1;
			end if;
			if count0 = 0 then
				microseconds <= not microseconds;
			end if;
		end if;
	end process micro_segundo;
	
	ciclo_completo: process(microseconds, ECHO)
	variable count1: integer range 0 to 262143;
	begin
		if rising_edge(microseconds) then
			if count1 = 0 then
				counter <= "000000000000000000";
				trigger <= '0';
			elsif count1 = 10 then
				trigger <= '1';
			end if;
			if ECHO = '1' then
				counter <= counter + 1;
			end if;
			if count1 = 249999 then
				count1 := 0;
			else
				count1 := count1 + 1;
			end if;
		end if;
	end process ciclo_completo;
	
	lectura_completa: process(ECHO)
	begin
		if falling_edge(ECHO) then
			if counter > 1*58 and counter <=2*58 then
				u <= "00110001";
				d <= "00110000";
			elsif counter > 2*58 and counter <=3*58  then
				u <= "00110010";
				d <= "00110000";
			elsif counter > 3*58 and counter <=4*58 then
				u <= "00110011";
				d <= "00110000";
			elsif counter > 4*58 and counter <=5*58 then
				u <= "00110100";
				d <= "00110000";
			elsif counter > 5*58 and counter <=6*58 then
				u <= "00110101";
				d <= "00110000";
			elsif counter > 6*58 and counter <=7*58 then
				u <= "00110110";
				d <= "00110000";
			elsif counter > 7*58 and counter <=8*58  then
				u <= "00110111";
				d <= "00110000";
			elsif counter > 8*58 and counter <=9*58 then
				u <= "00111000";
				d <= "00110000";
			elsif counter > 9*58 and counter <=10*58 then
				u <= "00111001";
				d <= "00110000";
			elsif counter > 10*58 and counter <=11*58 then
				u <= "00110000";
				d <= "00110001";
			elsif counter > 11*58 and counter <=12*58 then
				u <= "00110001";
				d <= "00110001";
			elsif counter > 12*58 and counter <=13*58  then
				u <= "00110010";
				d <= "00110001";
			elsif counter > 13*58 and counter <=14*58 then
				u <= "00110011";
				d <= "00110001";
			elsif counter > 14*58 and counter <=15*58 then
				u <= "00110100";
				d <= "00110001";
			elsif counter > 15*58 and counter <=16*58 then
				u <= "00110101";
				d <= "00110001";
			elsif counter > 16*58 and counter <=17*58 then
				u <= "00110110";
				d <= "00110001";
			elsif counter > 17*58 and counter <=18*58  then
				u <= "00110111";
				d <= "00110001";
			elsif counter > 18*58 and counter <=19*58 then
				u <= "00111000";
				d <= "00110001";
			elsif counter > 19*58 and counter <=20*58 then
				u <= "00111001";
				d <= "00110001";
			elsif counter > 20*58 and counter <=21*58 then
				u <= "00110000";
				d <= "00110010";
			elsif counter > 21*58 and counter <=22*58 then
				u <= "00110001";
				d <= "00110010";
			elsif counter > 22*58 and counter <=23*58  then
				u <= "00110010";
				d <= "00110010";
			elsif counter > 23*58 and counter <=24*58 then
				u <= "00110011";
				d <= "00110010";
			elsif counter > 24*58 and counter <=25*58 then
				u <= "00110100";
				d <= "00110010";
			elsif counter > 25*58 and counter <=26*58 then
				u <= "00110101";
				d <= "00110010";
			elsif counter > 26*58 and counter <=27*58 then
				u <= "00110110";
				d <= "00110010";
			elsif counter > 27*58 and counter <=28*58  then
				u <= "00110111";
				d <= "00110010";
			elsif counter > 28*58 and counter <=29*58 then
				u <= "00111000";
				d <= "00110010";
			elsif counter > 29*58 and counter <=30*58 then
				u <= "00111001";
				d <= "00110010";
			elsif counter > 30*58 and counter <=31*58 then
				u <= "00110000";
				d <= "00110011";
			elsif counter > 31*58 and counter <=32*58 then
				u <= "00110001";
				d <= "00110011";
			elsif counter > 32*58 and counter <=33*58  then
				u <= "00110010";
				d <= "00110011";
			elsif counter > 33*58 and counter <=34*58 then
				u <= "00110011";
				d <= "00110011";
			elsif counter > 34*58 and counter <=35*58 then
				u <= "00110100";
				d <= "00110011";
			elsif counter > 35*58 and counter <=36*58 then
				u <= "00110101";
				d <= "00110011";
			elsif counter > 36*58 and counter <=37*58 then
				u <= "00110110";
				d <= "00110011";
			elsif counter > 37*58 and counter <=38*58  then
				u <= "00110111";
				d <= "00110011";
			elsif counter > 38*58 and counter <=39*58 then
				u <= "00111000";
				d <= "00110011";
			elsif counter > 39*58 and counter <=40*58 then
				u <= "00111001";
				d <= "00110011";
			elsif counter > 40*58 and counter <=41*58 then
				u <= "00110000";
				d <= "00110100";
			else
				u <= "00101111";
				d <= "00101111";
			end if;
		end if;
	end process lectura_completa;
	unity <= u;
	deca <= d;
	TRIG <= trigger;
	
end rtl;
