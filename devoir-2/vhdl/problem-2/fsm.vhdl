-- Etienne Collin | 20237904
-- Ange Lilian Tchomtchoua Tokam | 20230129
-- Justin Villeneuve | 20132792

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY detectMotif IS
    PORT (
        clk, reset : IN STD_LOGIC;
        E : IN STD_LOGIC;
        M : OUT STD_LOGIC);
END detectMotif;

ARCHITECTURE behavioral OF detectMotif IS
    TYPE statetype IS (S0, S1, S2, S3, S4);
    SIGNAL state, nextState : stateType;
BEGIN
    PROCESS (clk, reset) BEGIN
        IF reset = '0' THEN
            state <= S0;
        ELSIF clk'EVENT AND clk = '1' THEN
            state <= nextState;
        END IF;
    END PROCESS;

    PROCESS (state, E) BEGIN
        CASE state IS
            WHEN S0 =>
                IF E = '1' THEN
                    nextState <= S2;
                ELSE
                    nextState <= S1;
                END IF;
            WHEN S1 =>
                IF E = '1' THEN
                    nextState <= S2;
                ELSE
                    nextState <= S3;
                END IF;
            WHEN S2 =>
                IF E = '1' THEN
                    nextState <= S4;
                ELSE
                    nextState <= S1;
                END IF;
            WHEN S3 =>
                IF E = '1' THEN
                    nextState <= S2;
                ELSE
                    nextState <= S1;
                END IF;
            WHEN S4 =>
                IF E = '1' THEN
                    nextState <= S2;
                ELSE
                    nextState <= S1;
                END IF;
            WHEN OTHERS => nextState <= S0;
        END CASE;
    END PROCESS;
    M <= '1' WHEN (state = S3 OR state = S4) ELSE
        '0';
END behavioral;