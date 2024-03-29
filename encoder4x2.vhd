library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder4x2 is
	 port(a : in STD_LOGIC_VECTOR(3 downto 0);
	 b : out STD_LOGIC_VECTOR(1 downto 0));
end encoder4x2;

architecture Behavioral of encoder4x2 is

begin
 
	process(a)
	begin
		 case a is
		 when "1000" => b <= "00";
		 when "0100" => b <= "01";
		 when "0010" => b <= "10";
		 when "0001" => b <= "11";
		 when others => b <= "ZZ";
		 end case;
	end process;


end Behavioral;

