library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_subtractor_8 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
			  OP : in STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           overflow : out  STD_LOGIC);
end adder_subtractor_8;

architecture Behavioral of adder_subtractor_8 is

	component full_adder is
    Port ( A , B , Cin: in  STD_LOGIC;
           Sum , Cout : out  STD_LOGIC);
	end component;
	
	signal c , t : STD_LOGIC_VECTOR(7 downto 0);
	
begin
	t(0) <= B(0) xor OP;
	t(1) <= B(1) xor OP;
	t(2) <= B(2) xor OP;
	t(3) <= B(3) xor OP;
	t(4) <= B(4) xor OP;
	t(5) <= B(5) xor OP;
	t(6) <= B(6) xor OP;
	t(7) <= B(7) xor OP;
	
	FA1 : full_adder port map(A(0) , t(0) , OP , S(0) , c(0) );
	FA2: full_adder port map(A(1) , t(1) , c(0) , S(1) , c(1) );
	FA3: full_adder port map(A(2) , t(2) , c(1) , S(2) , c(2) );
	FA4: full_adder port map(A(3) , t(3) , c(2) , S(3) , c(3) );
	FA5 : full_adder port map(A(4) , t(4) , c(3) , S(4) , c(4) );
	FA6: full_adder port map(A(5) , t(5) , c(4) , S(5) , c(5) );
	FA7: full_adder port map(A(6) , t(6) , c(5) , S(6) , c(6) );
	FA8: full_adder port map(A(7) , t(7) , c(6) , S(7) , c(7) );
	
	overflow <= c(7) xor c(6);
	
end Behavioral;