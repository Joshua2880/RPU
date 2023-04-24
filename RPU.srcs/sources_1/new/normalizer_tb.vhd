----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/21/2023 03:16:02 PM
-- Design Name: 
-- Module Name: NORMALIZER_TB - Behavioral
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

entity NORMALIZER_TB is
end NORMALIZER_TB;

architecture Behavioral of NORMALIZER_TB is
  constant WIDTH : integer := 256;
  
  type test_vals is 
  record 
    A_in : std_logic_vector(WIDTH - 1 downto 0);
    B_in : std_logic_vector(WIDTH - 1 downto 0);
    C_in : std_logic_vector(WIDTH - 1 downto 0);
    D_in : std_logic_vector(WIDTH - 1 downto 0);
    E_in : std_logic_vector(WIDTH - 1 downto 0);
    F_in : std_logic_vector(WIDTH - 1 downto 0);
    G_in : std_logic_vector(WIDTH - 1 downto 0);
    H_in : std_logic_vector(WIDTH - 1 downto 0);
  
    A_out : std_logic_vector(WIDTH - 1 downto 0);
    B_out : std_logic_vector(WIDTH - 1 downto 0);
    C_out : std_logic_vector(WIDTH - 1 downto 0);
    D_out : std_logic_vector(WIDTH - 1 downto 0);
    E_out : std_logic_vector(WIDTH - 1 downto 0);
    F_out : std_logic_vector(WIDTH - 1 downto 0);
    G_out : std_logic_vector(WIDTH - 1 downto 0);
    H_out : std_logic_vector(WIDTH - 1 downto 0);
  end record;
    
  type test_vals_array is array (natural range <>) of test_vals;
  
  constant tests : test_vals_array := (
    (
      x"0000000000000000000000000000000000000000000000000000000084000000", x"00000000000000000000000000000000000000000000000000000000eab00000", x"00000000000000000000000000000000000000000000000000000000c9230000", x"000000000000000000000000000000000000000000000000000000008ab70000",
      x"00000000000000000000000000000000000000000000000000000000ad700000", x"00000000000000000000000000000000000000000000000000000000c8760000", x"0000000000000000000000000000000000000000000000000000000098b63700", x"00000000000000000000000000000000000000000000000000000000e88e9000",
      
      x"0000000000000000000000000000000000000000000000000000000000840000", x"0000000000000000000000000000000000000000000000000000000000eab000", x"0000000000000000000000000000000000000000000000000000000000c92300", x"00000000000000000000000000000000000000000000000000000000008ab700",
      x"0000000000000000000000000000000000000000000000000000000000ad7000", x"0000000000000000000000000000000000000000000000000000000000c87600", x"000000000000000000000000000000000000000000000000000000000098b637", x"0000000000000000000000000000000000000000000000000000000000e88e90"
    ),
    (
      x"000000000000000000000000000000000000000000000000000000002876f000", x"00000000000000000000000000000000000000000000000000000000d9000000", x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffff73ef0000", x"00000000000000000000000000000000000000000000000000000000c6000000",
      x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffff73a7b800", x"0000000000000000000000000000000000000000000000000000000002ed0000", x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffff4f000000", x"00000000000000000000000000000000000000000000000000000000a7000000",
      
      x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffaf122", x"ffffffffffffffffffffffffffffffffffffffffffff0fffffffffffffe4e000", x"0000000000000000000000000000000000000000000000000000000000118220", x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe74000",
      x"0000000000000000000000000000000000000000000000000000000000118b09", x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa260", x"0000000000000000000000000000000000000000000000000000000000162000", x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeb2000"
    )
  );
  
  signal A_in : std_logic_vector(WIDTH - 1 downto 0);
  signal B_in : std_logic_vector(WIDTH - 1 downto 0);
  signal C_in : std_logic_vector(WIDTH - 1 downto 0);
  signal D_in : std_logic_vector(WIDTH - 1 downto 0);
  signal E_in : std_logic_vector(WIDTH - 1 downto 0);
  signal F_in : std_logic_vector(WIDTH - 1 downto 0);
  signal G_in : std_logic_vector(WIDTH - 1 downto 0);
  signal H_in : std_logic_vector(WIDTH - 1 downto 0);

  signal A_out : std_logic_vector(WIDTH - 1 downto 0);
  signal B_out : std_logic_vector(WIDTH - 1 downto 0);
  signal C_out : std_logic_vector(WIDTH - 1 downto 0);
  signal D_out : std_logic_vector(WIDTH - 1 downto 0);
  signal E_out : std_logic_vector(WIDTH - 1 downto 0);
  signal F_out : std_logic_vector(WIDTH - 1 downto 0);
  signal G_out : std_logic_vector(WIDTH - 1 downto 0);
  signal H_out : std_logic_vector(WIDTH - 1 downto 0);
  
begin
  BIT_POS: entity work.NORMALIZER(Behavioral)
    generic map(
      REG_WIDTH => WIDTH
    )
    port map(
      A_in => A_in,
      B_in => B_in,
      C_in => C_in,
      D_in => D_in,
      E_in => E_in,
      F_in => F_in,
      G_in => G_in,
      H_in => H_in,

      A_out => A_out,
      B_out => B_out,
      C_out => C_out,
      D_out => D_out,
      E_out => E_out,
      F_out => F_out,
      G_out => G_out,
      H_out => H_out
    );

  process is
    constant period : time := 10 ns;
    variable vals : test_vals;
  begin
    for i in tests'range loop
      vals := tests(i);
      A_in <= vals.A_in;
      B_in <= vals.B_in;
      C_in <= vals.C_in;
      D_in <= vals.D_in;
      E_in <= vals.E_in;
      F_in <= vals.F_in;
      G_in <= vals.G_in;
      H_in <= vals.H_in;
      wait for period;
      assert A_out = vals.A_out
        report "A result from was " & to_hstring(A_out) &
               ". Expected value " & to_hstring(vals.A_out)
        severity error;
      assert B_out = vals.B_out
        report "B result from was " & to_hstring(B_out) &
               ". Expected value " & to_hstring(vals.B_out)
        severity error;
      assert C_out = vals.C_out
        report "C result from was " & to_hstring(C_out) &
               ". Expected value " & to_hstring(vals.C_out)
        severity error;
      assert D_out = vals.D_out
        report "D result from was " & to_hstring(D_out) &
               ". Expected value " & to_hstring(vals.D_out)
        severity error;
      assert E_out = vals.E_out
        report "E result from was " & to_hstring(E_out) &
               ". Expected value " & to_hstring(vals.E_out)
        severity error;
      assert F_out = vals.F_out
        report "F result from was " & to_hstring(F_out) &
               ". Expected value " & to_hstring(vals.F_out)
        severity error;
      assert G_out = vals.G_out
        report "G result from was " & to_hstring(G_out) &
               ". Expected value " & to_hstring(vals.G_out)
        severity error;
      assert H_out = vals.H_out
        report "H result from was " & to_hstring(H_out) &
               ". Expected value " & to_hstring(vals.H_out)
        severity error;
    end loop;
    wait;
  end process;
end Behavioral;
