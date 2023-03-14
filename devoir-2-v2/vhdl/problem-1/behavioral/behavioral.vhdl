-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY colorM1toM2 IS
    PORT (
        b3m1 : IN STD_LOGIC;
        b2m1 : IN STD_LOGIC;
        b1m1 : IN STD_LOGIC;
        b0m1 : IN STD_LOGIC;
        b3m2 : OUT STD_LOGIC;
        b2m2 : OUT STD_LOGIC;
        b1m2 : OUT STD_LOGIC;
        b0m2 : OUT STD_LOGIC);
END colorM1toM2;

ARCHITECTURE behavioral OF colorM1toM2 IS
BEGIN
    PROCESS (b3m1, b2m1, b1m1, b0m1)
        -- Create a 4-bit vector from the 4 inputs for convenience in testing
        VARIABLE m1, m2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    BEGIN
        m1 := b3m1 & b2m1 & b1m1 & b0m1;
        CASE m1 IS
            WHEN "0000" => m2 := "0000";
            WHEN "0001" => m2 := "1111";
            WHEN "0010" => m2 := "0100";
            WHEN "0011" => m2 := "0011";
            WHEN "0100" => m2 := "0101";
            WHEN "0101" => m2 := "0010";
            WHEN "0110" => m2 := "0001";
            WHEN "0111" => m2 := "1110";
            WHEN "1000" => m2 := "0000"; -- Don't care
            WHEN "1001" => m2 := "0110";
            WHEN "1010" => m2 := "1100";
            WHEN "1011" => m2 := "1000";
            WHEN "1100" => m2 := "0111";
            WHEN "1101" => m2 := "1010";
            WHEN "1110" => m2 := "1001";
            WHEN "1111" => m2 := "0000"; --Don't care
            WHEN OTHERS => m2 := "XXXX";
        END CASE;
        -- Split the 4-bit vector into the 4 outputs
        b3m2 <= m2(3);
        b2m2 <= m2(2);
        b1m2 <= m2(1);
        b0m2 <= m2(0);
    END PROCESS;
END behavioral;