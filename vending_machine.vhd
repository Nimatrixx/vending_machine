library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vending_machine is
	port( clk : in std_logic;
		reset : in std_logic;
		ticket_sensor0, ticket_sensor1, ticket_sensor2 : in std_logic;
		coin5_sensor, coin10_sensor : in std_logic;
		finish : in std_logic;
		publish_ticket0, publish_ticket1, publish_ticket2 : out std_logic;
		return_coin5, return_coin10 : out std_logic
		);
end vending_machine;

architecture Behavioral of vending_machine is
	
	
begin
	
end Behavioral;

