----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/21/2023 02:20:57 PM
-- Design Name: 
-- Module Name: BIT_POS_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BIT_POS_TB is
end BIT_POS_TB;

architecture Behavioral of BIT_POS_TB is
  constant IN_WIDTH : integer := 64;
  constant OUT_WIDTH : integer := 6;

  type test_vals is 
    record 
      in0: std_logic_vector(IN_WIDTH - 1 downto 0);
      result : std_logic_vector(OUT_WIDTH - 1 downto 0);
    end record;
    
  type test_vals_array is array (natural range <>) of test_vals;
  
  constant tests : test_vals_array := (
    (x"8000000000000000", 6x"3F"),
    (x"4000000000000000", 6x"3E"),
    (x"2000000000000000", 6x"3D"),
    (x"1000000000000000", 6x"3C"),
    (x"0800000000000000", 6x"3B"),
    (x"0400000000000000", 6x"3A"),
    (x"0200000000000000", 6x"39"),
    (x"0100000000000000", 6x"38"),
    (x"0080000000000000", 6x"37"),
    (x"0040000000000000", 6x"36"),
    (x"0020000000000000", 6x"35"),
    (x"0010000000000000", 6x"34"),
    (x"0008000000000000", 6x"33"),
    (x"0004000000000000", 6x"32"),
    (x"0002000000000000", 6x"31"),
    (x"0001000000000000", 6x"30"),
    (x"0000800000000000", 6x"2F"),
    (x"0000400000000000", 6x"2E"),
    (x"0000200000000000", 6x"2D"),
    (x"0000100000000000", 6x"2C"),
    (x"0000080000000000", 6x"2B"),
    (x"0000040000000000", 6x"2A"),
    (x"0000020000000000", 6x"29"),
    (x"0000010000000000", 6x"28"),
    (x"0000008000000000", 6x"27"),
    (x"0000004000000000", 6x"26"),
    (x"0000002000000000", 6x"25"),
    (x"0000001000000000", 6x"24"),
    (x"0000000800000000", 6x"23"),
    (x"0000000400000000", 6x"22"),
    (x"0000000200000000", 6x"21"),
    (x"0000000100000000", 6x"20"),
    (x"0000000080000000", 6x"1F"),
    (x"0000000040000000", 6x"1E"),
    (x"0000000020000000", 6x"1D"),
    (x"0000000010000000", 6x"1C"),
    (x"0000000008000000", 6x"1B"),
    (x"0000000004000000", 6x"1A"),
    (x"0000000002000000", 6x"19"),
    (x"0000000001000000", 6x"18"),
    (x"0000000000800000", 6x"17"),
    (x"0000000000400000", 6x"16"),
    (x"0000000000200000", 6x"15"),
    (x"0000000000100000", 6x"14"),
    (x"0000000000080000", 6x"13"),
    (x"0000000000040000", 6x"12"),
    (x"0000000000020000", 6x"11"),
    (x"0000000000010000", 6x"10"),
    (x"0000000000008000", 6x"0F"),
    (x"0000000000004000", 6x"0E"),
    (x"0000000000002000", 6x"0D"),
    (x"0000000000001000", 6x"0C"),
    (x"0000000000000800", 6x"0B"),
    (x"0000000000000400", 6x"0A"),
    (x"0000000000000200", 6x"09"),
    (x"0000000000000100", 6x"08"),
    (x"0000000000000080", 6x"07"),
    (x"0000000000000040", 6x"06"),
    (x"0000000000000020", 6x"05"),
    (x"0000000000000010", 6x"04"),
    (x"0000000000000008", 6x"03"),
    (x"0000000000000004", 6x"02"),
    (x"0000000000000002", 6x"01"),
    (x"0000000000000001", 6x"00"),
    (x"0000000000000000", 6x"00")
  );

  signal in0 : std_logic_vector(IN_WIDTH - 1 downto 0);
  signal output : std_logic_vector(OUT_WIDTH - 1 downto 0);
begin
  BIT_POS: entity work.BIT_POS(Behavioral)
    generic map(
      DATA_WIDTH => IN_WIDTH,
      OUTPUT_WIDTH => OUT_WIDTH
    )
    port map(
      mask => in0,
      pos => output
    );

  process is
    constant period : time := 10 ns;
    variable vals : test_vals;
  begin
    for i in tests'range loop
      vals := tests(i);
      in0 <= vals.in0;
      wait for period;
      assert output = vals.result
        report "Result from " & to_hstring(vals.in0) & " was " & to_hstring(output) &
               ". Expected value " & to_hstring(vals.result)
        severity error;
    end loop;
    wait;
  end process;
end architecture;
