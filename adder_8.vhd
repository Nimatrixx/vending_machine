library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_8 is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
				  b : in  STD_LOGIC_VECTOR (7 downto 0);
				  c_in : in STD_LOGIC;
				  s : out  STD_LOGIC_VECTOR (7 downto 0);
				  c_out : out  STD_LOGIC);
end adder_8;

architecture Behavioral of adder_8 is

	component full_adder is
    Port ( A , B , Cin: in  STD_LOGIC;
           Sum , Cout : out  STD_LOGIC);
	end component;
	
	signal c  : STD_LOGIC_VECTOR(7 downto 0);
	
begin
	
	FA1 : full_adder port map(A(0) , B(0) , c_in , S(0) , c(0) );
	FA2: full_adder port map(A(1) , B(1) , c(0) , S(1) , c(1) );
	FA3: full_adder port map(A(2) , B(2) , c(1) , S(2) , c(2) );
	FA4: full_adder port map(A(3) , B(3) , c(2) , S(3) , c(3) );
	FA5: full_adder port map(A(4) , B(4) , c(3) , S(4) , c(4) );
	FA6: full_adder port map(A(5) , B(5) , c(4) , S(5) , c(5) );
	FA7: full_adder port map(A(6) , B(6) , c(5) , S(6) , c(6) );
	FA8: full_adder port map(A(7) , B(7) , c(6) , S(7) , c(7) );
	
	c_out <= c(7) xor c(6);
	
end Behavioral;
