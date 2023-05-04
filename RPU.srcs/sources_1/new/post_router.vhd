----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 07:19:20 PM
-- Design Name: 
-- Module Name: POST_ROUTER - Behavioral
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

entity POST_ROUTER is
generic(REG_WIDTH : integer := 256);
port(
  axis : in AXIS;
  prime_0 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_1 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_2 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_3 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  
  secondary_0 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_1 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_2 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_3 : in std_logic_vector(REG_WIDTH - 1 downto 0);
  
  A : out std_logic_vector(REG_WIDTH - 1 downto 0);
  B : out std_logic_vector(REG_WIDTH - 1 downto 0);
  C : out std_logic_vector(REG_WIDTH - 1 downto 0);
  D : out std_logic_vector(REG_WIDTH - 1 downto 0);
  E : out std_logic_vector(REG_WIDTH - 1 downto 0);
  F : out std_logic_vector(REG_WIDTH - 1 downto 0);
  G : out std_logic_vector(REG_WIDTH - 1 downto 0);
  H : out std_logic_vector(REG_WIDTH - 1 downto 0)
);
end POST_ROUTER;

architecture Behavioral of POST_ROUTER is
  signal axis_i : std_logic_vector(1 downto 0);
begin
  axis_i <= to_vector(axis);

  A_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => prime_1,
      in1 => prime_2,
      in2 => secondary_0,
      sel => axis_i,
      output => A
    );
    
  B_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => prime_3,
      in1 => secondary_2,
      in2 => secondary_1,
      sel => axis_i,
      output => B
    );
    
  C_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => secondary_1,
      in1 => prime_3,
      in2 => secondary_2,
      sel => axis_i,
      output => C
    );
  
  D <= secondary_3;
  
  E <= prime_0;
  
  F_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => prime_2,
      in1 => secondary_0,
      in2 => prime_1,
      sel => axis_i,
      output => F
    );
    
  G_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => secondary_0,
      in1 => prime_1,
      in2 => prime_2,
      sel => axis_i,
      output => G
    );
    
  H_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => secondary_2,
      in1 => secondary_1,
      in2 => prime_3,
      sel => axis_i,
      output => H
    );


end Behavioral;
