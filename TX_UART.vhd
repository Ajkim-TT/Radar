-- Create Date:    10:35:43 10/20/2020 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity TX_UART is
  generic ( --Clock/Baudrate (12000000)/(115200) = 217.01 
    CLK_BIT : integer := 1250;     -- -- Solo en el valor 3 se queda estatico.
    DT_BIT : integer := 8					  -- Cantidad de Bits a Transmitir
	 );
  port (
    Clk       : in  std_logic;		-- Reloj de 25 Mz
    TX_EN     : in  std_logic;		-- Habilitar la transmisión
    TX_Byte   : in  std_logic_vector(DT_BIT-1 downto 0); -- Dato a Transmitir.	
    TX_Serial : out std_logic;		-- Salida Serial
	 Tx_end,Tx_status:	out std_logic
    );
end TX_UART;

architecture TX_U of TX_UART is
  type TX_STATES is (IDLE, START_BIT, DATA_BIT, STOP_BIT);
  signal ACTUAL_STATE: TX_STATES := IDLE;			-- Estado principal definido en modo OSCIO.
  signal TX_COUNT: integer range 0 to CLK_BIT-1 := 0;
  signal BIT_INDX: integer range 0 to DT_BIT-1 := 0;  -- Indice de bits transmitidos.
  signal TX_Data:	 std_logic_vector(DT_BIT-1 downto 0) := (others => '0');--Registro para almacenar los bitas 
begin  
  p_UART_TX : process (Clk)
  begin
    if rising_edge(Clk) then        
      case ACTUAL_STATE is-------------------ACTUAL_STATE es el estado actual.
        when IDLE =>	
          TX_Serial <= '1';------------------La linea de transmisión es 1 para el modo oscio.
          TX_COUNT <= 0;
          BIT_INDX <= 0;
			 Tx_end <= '0';
			 Tx_status <= '0';
          if TX_EN = '0' then----------------Si se habilita l a transmisión
            TX_Data <= TX_Byte;--------------Asigna a la señal TX_Data la entrada TX_Byte
            ACTUAL_STATE <= START_BIT;-------Pasa del Modo OSCIO al modo BIT DE INICIO.
          else
            ACTUAL_STATE <= IDLE;------------Se mantiene en el modo OSCIO.
          end if;----------------------------------------------------------------------------------------------------
        when START_BIT =>--------------------Envía un bit de inicio. BIT DE INICIO = 0
			 Tx_status <= '1';
          TX_Serial <= '0';------------------Salida serial de bits es 0. El bit de inicio.       
          if TX_COUNT < CLK_BIT-1 then-------Espera CLK_BIT-1 ciclos de relok para que el bit de inicio finalice.
            TX_COUNT <= TX_COUNT + 1;--------Aumenta el conteo de reloj.
            ACTUAL_STATE   <= START_BIT;-----Se mantiene en modo BIT DE INICIO.
          else
            TX_COUNT <= 0;-------------------Reinicia el conteo.
            ACTUAL_STATE <= DATA_BIT;--------Cambia al modo TRANSMITIR BIT DE DATOS.
          end if;  -------------------------------------------------------------------------------------------------------   
        when DATA_BIT =>---------------------Espera CLK_BIT-1 ciclos de reloj para que cada bit de datos finalice.
          TX_Serial <= TX_Data(BIT_INDX);--- Manda por la salida serial el bit dentro de TX_Data en la posición BIT_INDX 															
          if TX_COUNT < CLK_BIT-1 then-------Cuenta un ciclo de reloj de uart para mandar el siguiente bit de datos.  
            TX_COUNT <= TX_COUNT + 1;		
            ACTUAL_STATE   <= DATA_BIT;------Se mantiene en el estado TRANSMITIR BIT DE DATOS
          else
            TX_COUNT <= 0;-------------------Reinicia el conteo del reloj de UART
            if BIT_INDX < DT_BIT-1 then------Verificar si ya enviamos todos los bits de datos.
              BIT_INDX <= BIT_INDX + 1;------Aumenta el conteo del indice de bits.
              ACTUAL_STATE   <= DATA_BIT;----Se mantiene en el modo TRANSMITIR BIT DE DATOS.
            else
              BIT_INDX <= 0;-----------------Reinicia el indice de bits
              ACTUAL_STATE   <= STOP_BIT;----Cambia al modo BIT DE PARADA.
            end if;
          end if;  --------------------------------------------------------------------------------------------------------
        when STOP_BIT =>---------------------Enviar el bit de parada.  Bit de parada = 1
          TX_Serial <= '1';------------------Bit de parada por la salida serial
			 if TX_COUNT < CLK_BIT-1 then-------Esperar g_CLKS_PER_BIT-1 ciclos de reloj para que el Bit de Parada finalice.
            TX_COUNT <= TX_COUNT + 1;--------Aumenta el conteo del reloj del uart.
            ACTUAL_STATE   <= STOP_BIT;------Se mantiene en el modo BIT DE PARADA
          else
            Tx_end <= '1';----------------Indica que ha culminado con la transmision
				TX_COUNT <= 0;-------------------Reinicia el contador del reloj UART
            ACTUAL_STATE <= IDLE;------------Cambia al modo LIMPIEZA
          end if;     --------------------------------------------------------------------------------------------------    
        when others =>
          ACTUAL_STATE <= IDLE;---------------Se mantiene en IDLE
      end case;
    end if;
  end process p_UART_TX;
end TX_U;
