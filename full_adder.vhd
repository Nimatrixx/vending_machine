library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( A , B , Cin: in  STD_LOGIC;
           Sum , Cout : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is
begin

	Sum <= Cin xor A xor B;
	Cout <= (A and B) or ((A xor B) and Cin);
	
end Behavioral;