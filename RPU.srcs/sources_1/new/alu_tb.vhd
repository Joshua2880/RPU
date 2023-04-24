----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/24/2023 12:15:33 PM
-- Design Name: 
-- Module Name: ALU_TB - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_TB is
end entity;

architecture alu_tb of ALU_TB is
  constant WIDTH : integer := 8;

  type test_vals is 
    record 
      operation : std_logic_vector(1 downto 0);
      in0, in1, result : std_logic_vector(WIDTH - 1 downto 0);
      overflow : std_logic;
    end record;
    
  type test_vals_array is array (natural range <>) of test_vals;
  
  constant tests : test_vals_array := (
    (2x"0", x"b2", x"73", x"b2", '0'),
    (2x"0", x"ff", x"13", x"ff", '0'),
    (2x"1", x"e4", x"13", x"f7", '0'),
    (2x"1", x"14", x"d3", x"e7", '0'),
    (2x"1", x"95", x"eb", x"80", '0'),
    (2x"1", x"14", x"6b", x"7f", '0'),
    (2x"1", x"80", x"ff", x"7f", '1'),
    (2x"1", x"9f", x"d3", x"72", '1'),
    (2x"1", x"64", x"20", x"84", '1'),
    (2x"1", x"64", x"1c", x"80", '1'),
    (2x"2", x"36", x"f3", x"6c", '0'),
    (2x"2", x"01", x"02", x"02", '0'),
    (2x"2", x"ff", x"f3", x"fe", '0'),
    (2x"2", x"d7", x"ac", x"ae", '0'),
    (2x"2", x"39", x"9d", x"72", '0'),
    (2x"2", x"ae", x"f3", x"5c", '1'),
    (2x"2", x"40", x"f3", x"80", '1'),
    (2x"2", x"56", x"6c", x"ac", '1')
  );
  
  signal operation : std_logic_vector(1 downto 0) := (others => '0');
  signal in0, in1, output : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
  signal overflow : std_logic := '0';
begin
  ALU_INST: entity work.ALU(structural)
  generic map(
    DATA_WIDTH => WIDTH
  )
  port map(
    in0 => in0, 
    in1 => in1, 
    operation => operation, 
    result => output, 
    overflow => overflow
  );
  
  process is
    constant period : time := 10 ns;
    variable vals : test_vals;
  begin
    for i in tests'range loop
      vals := tests(i);
      operation <= vals.operation;
      in0 <= vals.in0;
      in1 <= vals.in1;
      wait for period;
      assert output = vals.result
        report "Result from " & to_hstring(vals.in0) & " " & 
               to_hstring(vals.operation) & " " & to_hstring(vals.in1) & " was " & 
               to_hstring(output) & ". Expected value " & 
               to_hstring(vals.result)
        severity error;
      assert std_match(overflow, vals.overflow)
        report "Overflow from " & std_logic'image(vals.overflow) & " " & 
               to_hstring(vals.operation) & " " & to_hstring(vals.in1) & " was " & 
               std_logic'image(overflow) & ". Expected value " & std_logic'image(vals.overflow)
        severity error;
    end loop;
    wait;
  end process;
end architecture;
