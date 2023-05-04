----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 07:19:20 PM
-- Design Name: 
-- Module Name: ALU_LAYER - Behavioral
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

entity ALU_LAYER is
generic(REG_WIDTH : integer := 256);
port(
  prime_0_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_1_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_2_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_3_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  
  secondary_0_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_1_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_2_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_3_in : in std_logic_vector(REG_WIDTH - 1 downto 0);
  
  op : in std_logic_vector(3 downto 0);
  
  prime_0_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_1_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_2_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  prime_3_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  
  secondary_0_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_1_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_2_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  secondary_3_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
  
  internal_error : out std_logic
);
end ALU_LAYER;

architecture Behavioral of ALU_LAYER is
  signal prime_neg : std_logic;
  signal swap : std_logic;
  signal alu_op : std_logic_vector(1 downto 0);

  signal prime_0_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal prime_1_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal prime_2_neg : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal prime_3_neg : std_logic_vector(REG_WIDTH - 1 downto 0);

  signal alu_0_in0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_1_in0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_2_in0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_3_in0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal alu_0_in1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_1_in1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_2_in1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_3_in1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal alu_0_error : std_logic;
  signal alu_1_error : std_logic;
  signal alu_2_error : std_logic;
  signal alu_3_error : std_logic;
begin
  prime_neg <= op(3);
  swap <= op(2);
  alu_op <= op(1 downto 0);

  PRIME_NEG_MUX_0: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_0_in,
      in1 => std_logic_vector(-signed(prime_0_in)),
      sel => prime_neg,
      output => prime_0_neg
    );
    
  PRIME_NEG_MUX_1: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_1_in,
      in1 => std_logic_vector(-signed(prime_1_in)),
      sel => prime_neg,
      output => prime_1_neg
    );
    
  PRIME_NEG_MUX_2: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_2_in,
      in1 => std_logic_vector(-signed(prime_2_in)),
      sel => prime_neg,
      output => prime_2_neg
    );
    
  PRIME_NEG_MUX_3: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_3_in,
      in1 => std_logic_vector(-signed(prime_3_in)),
      sel => prime_neg,
      output => prime_3_neg
    );

  ALU_PRIME_MUX_0: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_0_neg,
      in1 => secondary_0_in,
      sel => swap,
      output => alu_0_in0
    );
    
  ALU_PRIME_MUX_1: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_1_neg,
      in1 => secondary_1_in,
      sel => swap,
      output => alu_1_in0
    );
    
  ALU_PRIME_MUX_2: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_2_neg,
      in1 => secondary_2_in,
      sel => swap,
      output => alu_2_in0
    );
    
  ALU_PRIME_MUX_3: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => prime_3_neg,
      in1 => secondary_3_in,
      sel => swap,
      output => alu_3_in0
    );

  ALU_SECONDARY_MUX_0: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_0_in,
      in1 => prime_0_neg,
      sel => swap,
      output => alu_0_in1
    );
    
  ALU_SECONDARY_MUX_1: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_1_in,
      in1 => prime_1_neg,
      sel => swap,
      output => alu_1_in1
    );
    
  ALU_SECONDARY_MUX_2: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_2_in,
      in1 => prime_2_neg,
      sel => swap,
      output => alu_2_in1
    );
    
  ALU_SECONDARY_MUX_3: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_3_in,
      in1 => prime_3_neg,
      sel => swap,
      output => alu_3_in1
    );

  ALU_0: entity work.ALU(structural)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => alu_0_in0,
      in1 => alu_0_in1,
      operation => alu_op,
      result => prime_0_out,
      overflow => alu_0_error
    );
    
  ALU_1: entity work.ALU(structural)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => alu_1_in0,
      in1 => alu_1_in1,
      operation => alu_op,
      result => prime_1_out,
      overflow => alu_1_error
    );
    
  ALU_2: entity work.ALU(structural)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => alu_2_in0,
      in1 => alu_2_in1,
      operation => alu_op,
      result => prime_2_out,
      overflow => alu_2_error
    );
    
  ALU_3: entity work.ALU(structural)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => alu_3_in0,
      in1 => alu_3_in1,
      operation => alu_op,
      result => prime_3_out,
      overflow => alu_3_error
    );
    
  internal_error <= alu_0_error or alu_1_error or alu_2_error or alu_3_error;
  
  SECONDARY_MUX_0: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_0_in,
      in1 => prime_0_in,
      sel => swap,
      output => secondary_0_out
    );
    
  SECONDARY_MUX_1: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_1_in,
      in1 => prime_1_in,
      sel => swap,
      output => secondary_1_out
    );
    
  SECONDARY_MUX_2: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_2_in,
      in1 => prime_2_in,
      sel => swap,
      output => secondary_2_out
    );
    
  SECONDARY_MUX_3: entity work.MUX_2(dataflw)
    generic map(DATA_WIDTH => REG_WIDTH)
    port map(
      in0 => secondary_3_in,
      in1 => prime_3_in,
      sel => swap,
      output => secondary_3_out
    );

end Behavioral;
