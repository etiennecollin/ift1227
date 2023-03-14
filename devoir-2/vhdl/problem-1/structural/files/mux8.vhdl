-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux8 IS
    PORT (
        sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        mux_out : OUT STD_LOGIC);
END mux8;

ARCHITECTURE behavioral OF mux8 IS
BEGIN
    PROCESS (sel, data)
    BEGIN
        CASE sel IS
            WHEN "000" => mux_out <= data(7);
            WHEN "001" => mux_out <= data(6);
            WHEN "010" => mux_out <= data(5);
            WHEN "011" => mux_out <= data(4);
            WHEN "100" => mux_out <= data(3);
            WHEN "101" => mux_out <= data(2);
            WHEN "110" => mux_out <= data(1);
            WHEN "111" => mux_out <= data(0);
            WHEN OTHERS => mux_out <= 'X';
        END CASE;
    END PROCESS;
END behavioral;