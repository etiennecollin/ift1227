LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY testbench IS --Tp4
END;

ARCHITECTURE test OF testbench IS
    COMPONENT mips
        PORT (
            clk, reset : IN STD_LOGIC;
            writedata, dataadr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            memwrite : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL writedata, dataadr : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL clk, reset, memwrite : STD_LOGIC;
BEGIN
    -- instantiate device to be tested
    dut : mips PORT MAP(clk, reset, writedata, dataadr, memwrite);
    -- Generate clock with 10 ns period
    PROCESS BEGIN
        -- clk <= '1';
        -- wait for 5 ns;
        -- clk <= '0';
        -- wait for 5 ns;
        FOR ii IN 0 TO 63 LOOP
            clk <= '1';
            WAIT FOR 5 ns;
            clk <= '0';
            WAIT FOR 5 ns;
        END LOOP;
        wait;
    END PROCESS;

    -- Generate reset for first two clock cycles
    PROCESS BEGIN
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT;
    END PROCESS;

    -- autoverification
    PROCESS (clk) BEGIN
        IF (clk'event AND clk = '0' AND memwrite = '1') THEN
                report "dataadr=0x" & to_hstring(dataadr) & "; writedata=0x" & to_hstring(writedata);
                case dataadr is
                    when X"00000050" => if(writedata = X"00000007") then
                                    report "test 1 done";
                            else
                                        report "test 1: error";
                            end if;
                    when X"0000003C" => if(writedata = X"00000007") then
                                    report "test 2 done";
                            else
                                        report "test 2 : error";
                            end if;
                    when others => report "";
                end case;
        END IF;
    END PROCESS;
END;