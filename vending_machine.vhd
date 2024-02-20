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
	
	component register_8 is
		port ( input :in  std_logic_vector(7 downto 0) ;
			load: in std_logic;
			reset: in std_logic;
			clk: in std_logic;
			output: out std_logic_vector(7 downto 0)
	 );
	end component;

	component mux4x1 is
		 Port ( a, b, c, d : in  STD_LOGIC_VECTOR (7 downto 0);
				  s : in  STD_LOGIC_VECTOR(1 downto 0);
				  f : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component adder_subtractor_8 is
		 Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
				  B : in  STD_LOGIC_VECTOR (7 downto 0);
				  OP : in STD_LOGIC;
				  S : out  STD_LOGIC_VECTOR (7 downto 0);
				  overflow : out  STD_LOGIC);
	end component;

	component subtractor_8 is
		 Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
					  b : in  STD_LOGIC_VECTOR (7 downto 0);
					  s : out  STD_LOGIC_VECTOR (7 downto 0);
					  c_out : out  STD_LOGIC);
	end component;
	
	signal addsub_coin1_out, addsub_coin2_out, sub_cost : STD_LOGIC_VECTOR(7 downto 0);
	signal reg_in, balance : STD_LOGIC_VECTOR(7 downto 0);
	signal cost  : STD_LOGIC_VECTOR(7 downto 0);
	signal selected_ticket, s  : STD_LOGIC_VECTOR(1 downto 0);
	
begin

	coin1_addsub : adder_subtractor_8 port map("00000101", balance, addsub_coin1_out);
	coin2_addsub : adder_subtractor_8 port map("00001010", balance, addsub_coin2_out);
	cost_mux : mux4x1 port map("00000101", "00001111", "00101000", "00000000", selected_ticket, cost);
	cost_subtractor : subtractor_8 port map(balance, cost, sub_cost);
	reg_mux : mux4x1 port map(balance, addsub_coin1_out, addsub_coin2_out, sub_cost, s, reg_in);
	reg : register_8 port map(reg_in, '1', reset_balance, clk, balance);
	
end Behavioral;

