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
	
	component encoder4x2 is
		 port(a : in STD_LOGIC_VECTOR(3 downto 0);
		 b : out STD_LOGIC_VECTOR(1 downto 0));
	end component;
	
	signal addsub_coin1_out, addsub_coin2_out, sub_cost : STD_LOGIC_VECTOR(7 downto 0);
	signal op : STD_LOGIC:='0';
	signal reg_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');	
	signal balance : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

	signal reset_balance : STD_LOGIC:='1';
	signal cost  : STD_LOGIC_VECTOR(7 downto 0);
	signal selected_ticket, s  : STD_LOGIC_VECTOR(1 downto 0) := "00";
	
	type fsm is (INIT, CHECK_OUT, RETURN_COIN, DELAY);
	signal c_state, n_state : fsm;
	
	signal ticket_pressed : STD_LOGIC :='0';
begin
	
	ticket_pressed <= ticket_sensor0 or ticket_sensor1 or ticket_sensor2;
	
	state_registration : process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset = '1') then
				c_state <= INIT;
			else
				c_state <= n_state;
			end if;
		end if;
	end process;
	
	state_management : process (clk)
	begin
	if(falling_edge(clk)) then
		reset_balance <= '0';
		s <= "00";
		op <= '0';
		case (c_state) is
			when INIT =>
				
				return_coin10 <= '0';
				return_coin5 <= '0';
		
				publish_ticket0 <= '0';
				publish_ticket1 <= '0';
				publish_ticket2 <= '0';

				if(finish = '1') then
					n_state <= RETURN_COIN;
				elsif(ticket_pressed = '1') then
					n_state <= CHECK_OUT;
				end if;
				
			when CHECK_OUT =>
			
				if(balance > cost or balance = cost) then
					-- check out
					s <= "11";
					-- publish ticket
						if(ticket_sensor0 = '1') then
							publish_ticket0 <= '1';
						elsif(ticket_sensor1 = '1') then
							publish_ticket1 <= '1';
						elsif(ticket_sensor2 = '1') then
							publish_ticket2 <= '1';
						else
							-- cancel the check out operation
							s <= "00";
					end if;
					-- back to init
					if(finish = '1') then
						n_state <= RETURN_COIN;
					else
						n_state <= INIT;
					end if;
					
				end if;
				
			when RETURN_COIN =>
				
				if(balance > "00000101") then
					return_coin10 <= '1';
					s <= "10";
					op <= '1';
					n_state <= DELAY;
				elsif(balance = "00000101") then
					return_coin5 <= '1';
					s <= "01";
					op <= '1';
					n_state <= DELAY;
				else
					n_state <= INIT;
				end if;
				
			When DELAY =>
			
				return_coin10 <= '0';
				return_coin5 <= '0';
				n_state <= RETURN_COIN;
				
		end case;
		
		if(coin5_sensor = '1') then
			s <= "01";
			op <= '0';
		elsif(coin10_sensor = '1') then
			s <= "10";
			op <= '0';
		end if;
		
	end if;
	end process;
	
	coin1_addsub : adder_subtractor_8 port map(balance, "00000101", op, addsub_coin1_out);
	coin2_addsub : adder_subtractor_8 port map(balance, "00001010", op, addsub_coin2_out);
	cost_mux : mux4x1 port map("00000000", "00000101", "00001111", "00101000", selected_ticket, cost);
	cost_subtractor : subtractor_8 port map(balance, cost, sub_cost);
	reg_mux : mux4x1 port map(balance, addsub_coin1_out, addsub_coin2_out, sub_cost, s, reg_in);
	reg : register_8 port map(reg_in, '1', reset_balance, clk, balance);
	encoder : encoder4x2 port map(('0', ticket_sensor0, ticket_sensor1, ticket_sensor2), selected_ticket);
	
end Behavioral;

