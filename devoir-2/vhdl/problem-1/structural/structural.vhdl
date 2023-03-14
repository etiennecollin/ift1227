-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY colorM1toM2 IS
    PORT (
        m1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        m2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END colorM1toM2;

ARCHITECTURE structural OF colorM1toM2 IS
    COMPONENT mux8 IS
        PORT (
            sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            mux_out : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL m2b3, m2b2, m2b1, m2b0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    m2b3 <= m1(0) & "00" & m1(0) & "01" & m1(0) & NOT m1(0);
    m2b2 <= m1(0) & NOT m1(0) & NOT m1(0) & m1(0) & m1(0) & NOT m1(0) & NOT m1(0) & '0';
    m2b1 <= m1(0) & m1(0) & m1(0) & m1(0) & m1(0) & "010";
    m2b0 <= m1(0) & m1(0) & NOT m1(0) & NOT m1(0) & "00" & NOT m1(0) & NOT m1(0);

    mux8_3 : mux8 PORT MAP(
        m1(3 DOWNTO 1),
        m2b3,
        m2(3)
    );
    mux8_2 : mux8 PORT MAP(
        m1(3 DOWNTO 1),
        m2b2,
        m2(2)
    );
    mux8_1 : mux8 PORT MAP(
        m1(3 DOWNTO 1),
        m2b1,
        m2(1)
    );
    mux8_0 : mux8 PORT MAP(
        m1(3 DOWNTO 1),
        m2b0,
        m2(0)
    );
END structural;