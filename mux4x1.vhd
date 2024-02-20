library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1 is
    Port ( a, b, c, d : in  STD_LOGIC_VECTOR (7 downto 0);
           s : in  STD_LOGIC_VECTOR(1 downto 0);
           f : out  STD_LOGIC_VECTOR (7 downto 0));
end mux4x1;

architecture Behavioral of mux4x1 is

begin
	with s select f <=  
		a when "00" ,
		b when "01",
		c when "10",
		d when "11";

end Behavioral;
