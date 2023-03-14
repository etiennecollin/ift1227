-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS
    PORT (
        sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        mux_out : OUT STD_LOGIC);
END mux4;

ARCHITECTURE behavioral OF mux4 IS
BEGIN
    PROCESS (sel, data)
    BEGIN
        CASE sel IS
            WHEN "00" => mux_out <= data(3);
            WHEN "01" => mux_out <= data(2);
            WHEN "10" => mux_out <= data(1);
            WHEN "11" => mux_out <= data(0);
            WHEN OTHERS => mux_out <= '0';
        END CASE;
    END PROCESS;
END behavioral;