----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:52 10/23/2020 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM is
port (CLK  : in   std_logic;  
		ADDR : in  integer range 0 to 12;
      DATA : out STD_LOGIC_VECTOR(7 downto 0)
		);
end ROM;

architecture arqui of ROM is
----------------------------------------------------------------------------
-----------------------Código ASCII
----------------------------------------------------------------------------
    type rom_type1 is array (12 downto 0) of STD_LOGIC_VECTOR(7 downto 0);                 
    constant ROM_1 : rom_type1:= (
								"00110000",  --0
								"00110001",   --1   
								"00110000",  --2
								"00110001",   --3
								"00110000",  --4
								"00110001",   --5   
								"00110000",  --6
								"00110001",   --7
								"00110000",  --8
								"00110001",   --9
								"00101111",	 --/								
								"01000001",  --A
								"01000100"   --D

);								
begin
    process (ADDR)
    begin
				DATA <= ROM_1(ADDR);			
    end process;

end arqui;
