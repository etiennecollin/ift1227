-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY colorM1toM2_tb IS
END colorM1toM2_tb;

ARCHITECTURE behavioral OF colorM1toM2_tb IS
    COMPONENT colorM1toM2 IS
        PORT (
            b3m1 : IN STD_LOGIC;
            b2m1 : IN STD_LOGIC;
            b1m1 : IN STD_LOGIC;
            b0m1 : IN STD_LOGIC;
            b3m2 : OUT STD_LOGIC;
            b2m2 : OUT STD_LOGIC;
            b1m2 : OUT STD_LOGIC;
            b0m2 : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL m1, m2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    DUT : colorM1toM2
    PORT MAP(
        b3m1 => m1(3),
        b2m1 => m1(2),
        b1m1 => m1(1),
        b0m1 => m1(0),
        b3m2 => m2(3),
        b2m2 => m2(2),
        b1m2 => m2(1),
        b0m2 => m2(0));

    PROCESS
    BEGIN
        m1 <= "0000";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0000") REPORT "Test case 0 failed" SEVERITY error;

        m1 <= "0001";
        WAIT FOR 10 ns;
        ASSERT (m2 = "1111") REPORT "Test case 1 failed" SEVERITY error;

        m1 <= "0010";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0100") REPORT "Test case 2 failed" SEVERITY error;

        m1 <= "0011";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0011") REPORT "Test case 3 failed" SEVERITY error;

        m1 <= "0100";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0101") REPORT "Test case 4 failed" SEVERITY error;

        m1 <= "0101";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0010") REPORT "Test case 5 failed" SEVERITY error;

        m1 <= "0110";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0001") REPORT "Test case 6 failed" SEVERITY error;

        m1 <= "0111";
        WAIT FOR 10 ns;
        ASSERT (m2 = "1110") REPORT "Test case 7 failed" SEVERITY error;

        m1 <= "1000";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0000") REPORT "Test case 8 failed" SEVERITY error;

        m1 <= "1001";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0110") REPORT "Test case 9 failed" SEVERITY error;

        m1 <= "1010";
        WAIT FOR 10 ns;
        ASSERT (m2 = "1100") REPORT "Test case 10 failed" SEVERITY error;

        m1 <= "1011";
        WAIT FOR 10 ns;
        ASSERT (m2 = "1000") REPORT "Test case 11 failed" SEVERITY error;

        m1 <= "1100";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0111") REPORT "Test case 12 failed" SEVERITY error;

        m1 <= "1101";
        WAIT FOR 10 ns;
        ASSERT (m2 = "1010") REPORT "Test case 13 failed" SEVERITY error;

        m1 <= "1110";
        WAIT FOR 10 ns;
        ASSERT (m2 = "1001") REPORT "Test case 14 failed" SEVERITY error;

        m1 <= "1111";
        WAIT FOR 10 ns;
        ASSERT (m2 = "0000") REPORT "Test case 15 failed" SEVERITY error;

        WAIT;
    END PROCESS;
END behavioral;