library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8 is
	port ( 
	input :in  std_logic_vector(7 downto 0) ;
	load: in std_logic;
	reset: in std_logic;
	clk: in std_logic;
	output: out std_logic_vector(7 downto 0)
 );
end register_8;

architecture sim of register_8 is
begin

	process(clk) is
	begin
		if rising_edge(clk) then
			if(load='1') then 
				output <= input;
			elsif(reset='1') then
				output <= "00000000";
			end if;
		end if;
	end process;
	
end sim;