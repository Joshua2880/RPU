----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 10:35:24 PM
-- Design Name: 
-- Module Name: NORMALIZER - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NORMALIZER is
generic(REG_WIDTH : integer := 256);
port(
  A_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  B_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  C_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  D_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  E_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  F_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  G_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  H_in : in std_logic_vector(REG_WIDTH - 1 downto 0);

  A_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  B_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  C_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  D_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  E_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  F_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  G_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  H_out : out std_logic_vector(REG_WIDTH - 1 downto 0)
);
end NORMALIZER;

architecture Behavioral of NORMALIZER is
  signal negate : std_logic;
  
  signal A_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal B_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal C_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal D_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal E_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal F_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal G_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal H_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal set_cols : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal lowest_mask : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal lowest_pos : std_logic_vector(7 downto 0);
begin
  negate <= E_in(REG_WIDTH - 1);
  
  A_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => A_in,
      in1 => std_logic_vector(-signed(A_in)),
      sel => negate,
      output => A_neg
    );
    
  B_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => B_in,
      in1 => std_logic_vector(-signed(B_in)),
      sel => negate,
      output => B_neg
    );
    
  C_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => C_in,
      in1 => std_logic_vector(-signed(C_in)),
      sel => negate,
      output => C_neg
    );
    
  D_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => D_in,
      in1 => std_logic_vector(-signed(D_in)),
      sel => negate,
      output => D_neg
    );
    
  E_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => E_in,
      in1 => std_logic_vector(-signed(E_in)),
      sel => negate,
      output => E_neg
    );
  
  F_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => F_in,
      in1 => std_logic_vector(-signed(F_in)),
      sel => negate,
      output => F_neg
    );
    
  G_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => G_in,
      in1 => std_logic_vector(-signed(G_in)),
      sel => negate,
      output => G_neg
    );
    
  H_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => H_in,
      in1 => std_logic_vector(-signed(H_in)),
      sel => negate,
      output => H_neg
    );
    
  set_cols <= A_in or B_in or C_in or D_in or E_in or F_in or G_in or H_in;
    
  lowest_mask <= set_cols and std_logic_vector(unsigned(not set_cols) + 1);

  FIND_LOW_BIT: entity work.BIT_POS(Behavioral)
    generic map(
      DATA_WIDTH => REG_WIDTH,
      OUTPUT_WIDTH => 8
    )
    port map(
      mask => lowest_mask,
      pos => lowest_pos
    );
    
  A_out <= std_logic_vector(signed(A_neg) sra to_integer(unsigned(lowest_pos)));
  B_out <= std_logic_vector(signed(B_neg) sra to_integer(unsigned(lowest_pos)));
  C_out <= std_logic_vector(signed(C_neg) sra to_integer(unsigned(lowest_pos)));
  D_out <= std_logic_vector(signed(D_neg) sra to_integer(unsigned(lowest_pos)));
  E_out <= std_logic_vector(signed(E_neg) sra to_integer(unsigned(lowest_pos)));
  F_out <= std_logic_vector(signed(F_neg) sra to_integer(unsigned(lowest_pos)));
  G_out <= std_logic_vector(signed(G_neg) sra to_integer(unsigned(lowest_pos)));
  H_out <= std_logic_vector(signed(H_neg) sra to_integer(unsigned(lowest_pos)));
end Behavioral;
