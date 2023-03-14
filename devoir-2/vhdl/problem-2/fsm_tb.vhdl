-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY detectMotif_tb IS
END detectMotif_tb;

ARCHITECTURE behavioral OF detectMotif_tb IS
    COMPONENT detectMotif
        PORT (
            clk, reset : IN STD_LOGIC;
            E : IN STD_LOGIC;
            M : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL E : STD_LOGIC := '0';
    SIGNAL M : STD_LOGIC;
    SIGNAL DONE : STD_LOGIC := '0';

BEGIN

    DUT : detectMotif
    PORT MAP(
        clk => clk,
        reset => reset,
        E => E,
        M => M);

    PROCESS
    BEGIN
        reset <= '1';
        E <= '0';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 1 failed" SEVERITY error;

        E <= '1';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 2 failed" SEVERITY error;

        E <= '1';
        WAIT FOR 10 ns;
        ASSERT (M = '1') REPORT "Test case 3 failed" SEVERITY error;

        E <= '1';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 4 failed" SEVERITY error;

        E <= '1';
        WAIT FOR 10 ns;
        ASSERT (M = '1') REPORT "Test case 5 failed" SEVERITY error;

        E <= '0';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 6 failed" SEVERITY error;

        E <= '0';
        WAIT FOR 10 ns;
        ASSERT (M = '1') REPORT "Test case 7 failed" SEVERITY error;

        E <= '0';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 8 failed" SEVERITY error;

        E <= '0';
        WAIT FOR 10 ns;
        ASSERT (M = '1') REPORT "Test case 9 failed" SEVERITY error;

        E <= '1';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 10 failed" SEVERITY error;

        E <= '0';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 11 failed" SEVERITY error;

        E <= '1';
        WAIT FOR 10 ns;
        ASSERT (M = '0') REPORT "Test case 12 failed" SEVERITY error;

        DONE <= '1';
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;

    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
        WAIT;
    END PROCESS;
END behavioral;