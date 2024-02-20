library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtractor_8 is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
				  b : in  STD_LOGIC_VECTOR (7 downto 0);
				  s : out  STD_LOGIC_VECTOR (7 downto 0);
				  c_out : out  STD_LOGIC);
end subtractor_8;

architecture Behavioral of subtractor_8 is
	
	component adder_8 is
		 Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
					  b : in  STD_LOGIC_VECTOR (7 downto 0);
					  c_in : in STD_LOGIC;
					  s : out  STD_LOGIC_VECTOR (7 downto 0);
					  c_out : out  STD_LOGIC);
	end component;
	
	signal not_b :  STD_LOGIC_VECTOR (7 downto 0);
begin

	not_b <= (not b);
	
	adder : adder_8 port map(a, not_b, '1', s, c_out);
	
end Behavioral;
