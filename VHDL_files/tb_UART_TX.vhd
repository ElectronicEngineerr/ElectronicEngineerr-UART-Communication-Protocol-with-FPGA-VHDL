library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_UART_TX is

			generic (
						c_clock_freq : integer := 100_000_000;
						c_baud_rate  : integer := 5_000_000;
						c_stop_bit   : integer := 2
			);

end tb_UART_TX;

architecture Behavioral of tb_UART_TX is

COMPONENT UART_TX is
		generic (
						c_clock_freq : integer := 100_000_000;
						c_baud_rate  : integer := 115_200;
						c_stop_bit   : integer := 2
		);		
		port (			-- INPUTS
						clk          	: in std_logic; -- 100 MHz
						tx_start_bit    : in std_logic;
						tx_data_in   	: in std_logic_Vector(7 downto 0); 
						-- OUTPUTS
						tx_data_output	: out std_logic; -- tx output wire
						tx_done_tick  	: out std_logic  -- Is comm done ?					
		);
end COMPONENT;

signal clk          	: std_logic := '0';
signal tx_start_bit 	: std_logic := '0';
signal tx_data_in   	: std_logic_Vector(7 downto 0) := (others => '0');
signal tx_data_output  	: std_logic;
signal tx_done_tick     : std_logic;

signal clock_period     : time := 10 ns;

begin


DUT : UART_TX

	generic map (
						c_clock_freq => c_clock_freq,
						c_baud_rate  => c_baud_rate,
						c_stop_bit   => c_stop_bit
	)
	port    map(
						clk 			=> clk,
						tx_start_bit 	=> tx_start_bit,
						tx_data_in   	=> tx_data_in,
						tx_data_output 	=> tx_data_output,
						tx_done_tick 	=> tx_done_tick
	);


CLOCK_GENERATOR : process
	begin	
			clk <= '1';
			wait for clock_period/2;
			clk <= '0';
			wait for clock_period/2;
end process CLOCK_GENERATOR;

P_STIMULI : process
	begin
		
			wait for 100 ns;
			tx_start_bit <= '1';
			tx_data_in <= x"CB";
			wait for 200 ns;
			tx_start_bit <= '0';
			
			

			
			
end process;

end Behavioral;
