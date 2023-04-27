library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbench is --Tp4
end;

architecture test of testbench is
	component mips
		port(	clk, reset: in STD_LOGIC;
				writedata, dataadr: out STD_LOGIC_VECTOR(31 downto 0);
				memwrite: out STD_LOGIC);
	end component;
	signal writedata, dataadr: STD_LOGIC_VECTOR(31 downto 0);
	signal clk, reset, memwrite: STD_LOGIC;
begin
-- instantiate device to be tested
	dut: mips port map (clk, reset, writedata, dataadr, memwrite);
-- Generate clock with 10 ns period
process begin
    FOR ii IN 0 TO 63 LOOP
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    END LOOP;
    wait;
end process;

-- Generate reset for first two clock cycles
process begin
	reset <= '1';
	wait for 20 ns;
	reset <= '0';
	wait;
end process;

-- autoverification
process (clk) begin
	if (clk'event and clk = '0' and memwrite = '1') then
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
            when X"00000028" => if(writedata = X"0000004C") then
                            report "test 3 done";
                    else
                            report "test 3 : error";
                    end if;
            when X"00000014" => if(writedata = X"00000011") then
                            report "test 4 done";
                    else
                            report "test 4 : error";
                    end if;
            when others => report "";
	    end case;
	end if;
end process;
end;