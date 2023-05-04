----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 07:19:20 PM
-- Design Name: 
-- Module Name: PRE_ROUTER - Behavioral
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

library work;
use work.types.all;

entity PRE_ROUTER is
generic(REG_WIDTH : integer := 256);
port(
  axis : in AXIS;
  A : in std_logic_vector(REG_WIDTH - 1 downto 0);
  B : in std_logic_vector(REG_WIDTH - 1 downto 0);
  C : in std_logic_vector(REG_WIDTH - 1 downto 0);
  D : in std_logic_vector(REG_WIDTH - 1 downto 0);
  E : in std_logic_vector(REG_WIDTH - 1 downto 0);
  F : in std_logic_vector(REG_WIDTH - 1 downto 0);
  G : in std_logic_vector(REG_WIDTH - 1 downto 0);
  H : in std_logic_vector(REG_WIDTH - 1 downto 0);
  
  prime_0 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_1 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_2 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_3 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  
  secondary_0 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_1 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_2 : out std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_3 : out std_logic_vector(REG_WIDTH - 1 downto 0)
);
end PRE_ROUTER;

architecture Behavioral of PRE_ROUTER is
  signal axis_i : std_logic_vector(1 downto 0);
begin
  axis_i <= to_vector(axis);

  prime_0 <= E;
  
  PRIME_MUX_1: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => A,
      in1 => G,
      in2 => F,
      sel => axis_i,
      output => prime_1
    );

  PRIME_MUX_2: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => F,
      in1 => A,
      in2 => G,
      sel => axis_i,
      output => prime_2
    );
    
  PRIME_MUX_3: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => B,
      in1 => C,
      in2 => H,
      sel => axis_i,
      output => prime_3
    );
  
  SECONDARY_MUX_0: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => G,
      in1 => F,
      in2 => A,
      sel => axis_i,
      output => secondary_0
    );

  SECONDARY_MUX_1: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => C,
      in1 => H,
      in2 => B,
      sel => axis_i,
      output => secondary_1
    );
    
  SECONDARY_MUX_2: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => H,
      in1 => B,
      in2 => C,
      sel => axis_i,
      output => secondary_2
    );
    
  secondary_3 <= D;
end Behavioral;
