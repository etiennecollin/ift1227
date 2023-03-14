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

ARCHITECTURE structural OF colorM1toM2 IS
    COMPONENT mux8 IS
        PORT (
            sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            mux_out : OUT STD_LOGIC);
    END COMPONENT;
    -- Create the selection vector for the 8-to-1 muxes
    SIGNAL sel : STD_LOGIC_VECTOR(2 DOWNTO 0);
    -- Create the data vectors for each of the 8-to-1 muxes
    SIGNAL data3, data2, data1, data0 : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    -- Assign the data vectors for each of the 8-to-1 muxes according to the output bit
    data3 <= b0m1 & "00" & b0m1 & "01" & b0m1 & NOT b0m1;
    data2 <= b0m1 & NOT b0m1 & NOT b0m1 & b0m1 & b0m1 & NOT b0m1 & NOT b0m1 & '0';
    data1 <= b0m1 & b0m1 & b0m1 & b0m1 & b0m1 & "010";
    data0 <= b0m1 & b0m1 & NOT b0m1 & NOT b0m1 & "00" & NOT b0m1 & NOT b0m1;

    -- Assign the selector using the input bits
    sel <= b3m1 & b2m1 & b1m1;

    mux8_3 : mux8 PORT MAP(
        sel,
        data3,
        b3m2
    );
    mux8_2 : mux8 PORT MAP(
        sel,
        data2,
        b2m2
    );
    mux8_1 : mux8 PORT MAP(
        sel,
        data1,
        b1m2
    );
    mux8_0 : mux8 PORT MAP(
        sel,
        data0,
        b0m2
    );
END structural;