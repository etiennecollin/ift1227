LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS
    generic (width: integer);
	port (d0, d1, d2, d3: in STD_LOGIC_VECTOR(width-1 downto 0);
			s: in STD_LOGIC_VECTOR(1 downto 0);
			y: out STD_LOGIC_VECTOR(width-1 downto 0));
END mux4;

ARCHITECTURE behavioral OF mux4 IS
BEGIN
    PROCESS (s, d0, d1, d2, d3)
    BEGIN
        CASE s IS
            WHEN "00" => y <= d0;
            WHEN "01" => y <= d1;
            WHEN "10" => y <= d2;
            WHEN "11" => y <= d3;
            WHEN OTHERS => y <= d3;
        END CASE;
    END PROCESS;
END behavioral;