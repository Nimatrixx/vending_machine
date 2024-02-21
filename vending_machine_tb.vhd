LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY vending_machine_tb IS
END vending_machine_tb;
 
ARCHITECTURE behavior OF vending_machine_tb IS 
  
    COMPONENT vending_machine
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         ticket_sensor0 : IN  std_logic;
         ticket_sensor1 : IN  std_logic;
         ticket_sensor2 : IN  std_logic;
         coin5_sensor : IN  std_logic;
         coin10_sensor : IN  std_logic;
			finish : IN std_logic;
         publish_ticket0 : OUT  std_logic;
         publish_ticket1 : OUT  std_logic;
         publish_ticket2 : OUT  std_logic;
         return_coin5 : OUT  std_logic;
         return_coin10 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal ticket_sensor0 : std_logic := '0';
   signal ticket_sensor1 : std_logic := '0';
   signal ticket_sensor2 : std_logic := '0';
   signal coin5_sensor : std_logic := '0';
   signal coin10_sensor : std_logic := '0';
	signal finish : std_logic := '0';

 	--Outputs
   signal publish_ticket0 : std_logic;
   signal publish_ticket1 : std_logic;
   signal publish_ticket2 : std_logic;
   signal return_coin5 : std_logic;
   signal return_coin10 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vending_machine PORT MAP (
          clk => clk,
          reset => reset,
          ticket_sensor0 => ticket_sensor0,
          ticket_sensor1 => ticket_sensor1,
          ticket_sensor2 => ticket_sensor2,
          coin5_sensor => coin5_sensor,
          coin10_sensor => coin10_sensor,
			 finish => finish,
          publish_ticket0 => publish_ticket0,
          publish_ticket1 => publish_ticket1,
          publish_ticket2 => publish_ticket2,
          return_coin5 => return_coin5,
          return_coin10 => return_coin10
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      -- insert stimulus here 
--		coin5_sensor <= '1' after 100 ns,
--		'0' after 140 ns,
--		'1' after 160 ns,
--		'0' after 190 ns;
		
		coin10_sensor <= '1' after 100 ns,
		'0' after 110 ns,
		'1' after 200 ns,
		'0' after 210 ns,
		'1' after 300 ns,
		'0' after 305 ns,
		'1' after 455 ns,
		'0' after 465 ns,
		
		'1' after 700 ns,
		'0' after 710 ns,
		'1' after 750 ns,
		'0' after 760 ns;
		'1' after 780 ns,
		'0' after 790 ns,
		'1' after 800 ns,
		'0' after 810 ns;
		
		coin5_sensor <= '1' after 730 ns,
		'0' after 740 ns;
		
		ticket_sensor0 <= '1' after 500 ns,
		'0' after 515 ns;
		ticket_sensor1 <= '1' after 550 ns,
		'0' after 565 ns;
		ticket_sensor2 <= '1' after 650 ns,
		'0' after 665 ns,
		'1' after 800 ns,
		'0' after 820 ns;
		
		finish <= '1' after 900 ns,
		'0' after 915 ns;
      wait;
   end process;

END;
