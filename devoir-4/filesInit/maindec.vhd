library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
	port (op: in STD_LOGIC_VECTOR (5 downto 0);
			memtoreg, memwrite: out STD_LOGIC;
			branch, alusrc: out STD_LOGIC;
			regdst: out STD_LOGIC_VECTOR(1 downto 0);
            regwrite: out STD_LOGIC;
			jump: out STD_LOGIC;
            jal: out STD_LOGIC;
			aluop: out STD_LOGIC_VECTOR (1 downto 0));
end;

architecture behave of maindec is
	signal controls: STD_LOGIC_VECTOR(10 downto 0);
begin
process(op) begin
	case op is
		when "000000" => controls <= "10100000010"; -- Rtyp
		when "100011" => controls <= "10010010000"; -- LW
		when "101011" => controls <= "00010100000"; -- SW
		when "000100" => controls <= "00001000001"; -- BEQ
		when "000010" => controls <= "00000001000"; -- J
		when "000011" => controls <= "11000001100"; -- JAL
		when "001000" => controls <= "10010000000"; -- ADDI
		when others => controls <= "-----------"; -- illegal op
	end case;
end process;

	regwrite <= controls(10);
	regdst <= controls(9 downto 8);
	alusrc <= controls(7);
	branch <= controls(6);
	memwrite <= controls(5);
	memtoreg <= controls(4);
	jump <= controls(3);
    jal <= controls(2);
	aluop <= controls(1 downto 0);
end;