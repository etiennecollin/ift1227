-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux8_tb IS
END mux8_tb;

ARCHITECTURE Behavioral OF mux8_tb IS
    COMPONENT mux8 IS
        PORT (
            sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            mux_out : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL sel : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL mux_out : STD_LOGIC;

BEGIN
    DUT : mux8
    PORT MAP(
        sel => sel,
        data => data,
        mux_out => mux_out);

    PROCESS
    BEGIN
        data <= "11010110";

        sel <= "000";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(7)) REPORT "Test case 0 failed" SEVERITY error;

        sel <= "001";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(6)) REPORT "Test case 1 failed" SEVERITY error;

        sel <= "010";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(5)) REPORT "Test case 2 failed" SEVERITY error;

        sel <= "011";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(4)) REPORT "Test case 3 failed" SEVERITY error;

        sel <= "100";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(3)) REPORT "Test case 4 failed" SEVERITY error;

        sel <= "101";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(2)) REPORT "Test case 5 failed" SEVERITY error;

        sel <= "110";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(1)) REPORT "Test case 6 failed" SEVERITY error;

        sel <= "111";
        WAIT FOR 10 ns;
        ASSERT (mux_out = data(0)) REPORT "Test case 7 failed" SEVERITY error;

        WAIT;
    END PROCESS;
END Behavioral;