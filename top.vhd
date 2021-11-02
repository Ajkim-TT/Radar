----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:37 10/08/2021 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
	port(
			Clk,echo1,echo2: in std_logic;
			trig1,trig2,serv1,serv2,tx_u: out std_logic
	);
end top;

architecture Behavioral of top is
	--signal habilitador1: std_logic;
	--signal habilitador2: std_logic;
	signal u1: std_logic_vector(7 downto 0);
	signal d1: std_logic_vector(7 downto 0);
	signal u2: std_logic_vector(7 downto 0);
	signal d2: std_logic_vector(7 downto 0);
	signal an1: integer range 0 to 2530;
	signal dato: std_logic_vector(7 downto 0);
	signal transmitiendo: std_logic;
	signal transmitido: std_logic;
	signal transmitir: std_logic;
begin
controlador: entity work.control port map(
	clk => clk,
	tx_done => transmitido,
	tx_stat => transmitiendo,
	uni1 => u1,
	uni2 => u2,
	deca1 => d1,
	deca2 => d2,
	ang1 => an1,
	enviar => dato,
	tx_enable => transmitir
	--ENS1 => habilitador1,
	--ENS2 => habilitador2,
);

sensor1: entity work.ultrasonic port map(
	Clk => clk,
	ECHO => echo1,
	unity => u1,
	deca => d1,
	TRIG => trig1
);
sevo1: entity work.servo port map(
		clk => clk,
		salida1 => serv1,
		salida2 => serv2,
		angular => an1
);
sensor2: entity work.ultrasonic port map(
	Clk => clk,
	ECHO => echo2,
	unity => u2,
	deca => d2,
	TRIG => trig2
);
transmisor: entity work.TX_UART port map(
	Clk  => clk,
    TX_EN   => transmitir,
    TX_Byte => dato,
    TX_Serial=> tx_u,
	 Tx_end => transmitido,
	 Tx_status=> transmitiendo

);
end Behavioral;

