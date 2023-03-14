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

ARCHITECTURE structural OF mux8 IS
    COMPONENT mux4 IS
        PORT (
            sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            mux_out : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT mux2 IS
        PORT (
            sel : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            mux_out : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL mux1and2_out : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    mux4_0 : mux4 PORT MAP(
        sel(1 DOWNTO 0),
        data(7 DOWNTO 4),
        mux1and2_out(1)
    );
    mux4_1 : mux4 PORT MAP(
        sel(1 DOWNTO 0),
        data(3 DOWNTO 0),
        mux1and2_out(0)
    );
    -- select the output of the two muxes
    mux2_0 : mux2 PORT MAP(
        sel(2),
        mux1and2_out,
        mux_out
    );
END structural;