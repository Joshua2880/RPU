----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 05/03/2023 06:44:14 PM
-- Design Name: 
-- Module Name: UPDATE_LOOP - Behavioral
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

library work;
use work.types.all;

entity UPDATE_LOOP is
  generic(
    REG_WIDTH : integer := 256;
    CNTR_WIDTH : integer := 6
  );
  port(
    clk : in std_logic;
    rst : in std_logic;
    
    initialized : in std_logic;
  
    axis : in AXIS;
    
    x_cntr : in std_logic_vector(CNTR_WIDTH - 1 downto 0);
    y_cntr : in std_logic_vector(CNTR_WIDTH - 1 downto 0);
    z_cntr : in std_logic_vector(CNTR_WIDTH - 1 downto 0);
    
    x_bit : in std_logic;
    y_bit : in std_logic;
    z_bit : in std_logic;
    
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
    H_out : out std_logic_vector(REG_WIDTH - 1 downto 0);
    
    internal_error : out std_logic
  );
end UPDATE_LOOP;

architecture Behavioral of UPDATE_LOOP is
  signal A_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal B_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal C_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal D_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal E_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal F_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal G_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal H_unnormed : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal A_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal B_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal C_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal D_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal E_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal F_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal G_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal H_normed : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal A : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal B : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal C : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal D : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal E : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal F : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal G : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal H : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal pre_prime_0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_prime_1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_prime_2 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_prime_3 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_secondary_0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_secondary_1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_secondary_2 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal pre_secondary_3 : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal bit_val : std_logic;
  signal axis_cntr : std_logic_vector(CNTR_WIDTH - 1 downto 0);
  signal op : std_logic_vector(3 downto 0);
  
  signal alu_prime_0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_prime_1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_prime_2 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_prime_3 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_secondary_0 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_secondary_1 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_secondary_2 : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal alu_secondary_3 : std_logic_vector(REG_WIDTH - 1 downto 0);
  
  signal post_A : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_B : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_C : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_D : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_E : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_F : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_G : std_logic_vector(REG_WIDTH - 1 downto 0);
  signal post_H : std_logic_vector(REG_WIDTH - 1 downto 0);
  
begin
  A_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => A_in,
      in1 => post_A,
      sel => initialized,
      output => A_unnormed
    );
    
  B_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => B_in,
      in1 => post_B,
      sel => initialized,
      output => B_unnormed
    );
    
  C_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => C_in,
      in1 => post_C,
      sel => initialized,
      output => C_unnormed
    );

  D_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => D_in,
      in1 => post_D,
      sel => initialized,
      output => D_unnormed
    );
    
  E_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => E_in,
      in1 => post_E,
      sel => initialized,
      output => E_unnormed
    );
    
  F_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => F_in,
      in1 => post_F,
      sel => initialized,
      output => F_unnormed
    );
    
  G_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => G_in,
      in1 => post_G,
      sel => initialized,
      output => G_unnormed
    );
    
  H_IN_MUX: entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => REG_WIDTH
    )
    port map(
      in0 => H_in,
      in1 => post_H,
      sel => initialized,
      output => H_unnormed
    );

  NORMALIZER: entity work.NORMALIZER(Behavioral)
    generic map(
      REG_WIDTH => REG_WIDTH
    )
    port map(
      A_in => A_unnormed,
      B_in => B_unnormed,
      C_in => C_unnormed,
      D_in => D_unnormed,
      E_in => E_unnormed,
      F_in => F_unnormed,
      G_in => G_unnormed,
      H_in => H_unnormed,

      A_out => A_normed,
      B_out => B_normed,
      C_out => C_normed,
      D_out => D_normed,
      E_out => E_normed,
      F_out => F_normed,
      G_out => G_normed,
      H_out => H_normed
    );
    
  REG_FILE: entity work.Register_File(A1)
    generic map(
      REGISTER_WIDTH => REG_WIDTH
    )
    port map(
      write_enable => '1',
      rst => rst,
      clk => clk,
    
      A_in => A_normed,
      B_in => B_normed,
      C_in => C_normed,
      D_in => D_normed,
      E_in => E_normed,
      F_in => F_normed,
      G_in => G_normed,
      H_in => H_normed,
      
      A_out => A,
      B_out => B,
      C_out => C,
      D_out => D,
      E_out => E,
      F_out => F,
      G_out => G,
      H_out => H
    );

  PRE_ROUTER: entity work.PRE_ROUTER(Behavioral)
    generic map(
      REG_WIDTH => REG_WIDTH
    )
    port map(
      axis => axis,
      
      A => A,
      B => B,
      C => C,
      D => D,
      E => E,
      F => F,
      G => G,
      H => H,
      
      prime_0 => pre_prime_0,
      prime_1 => pre_prime_1,
      prime_2 => pre_prime_2,
      prime_3 => pre_prime_3,
      secondary_0 => pre_secondary_0,
      secondary_1 => pre_secondary_1,
      secondary_2 => pre_secondary_2,
      secondary_3 => pre_secondary_3
    );
    
  CNTR_MUX: entity work.MUX_3(dataflw)
    generic map(
      DATA_WIDTH => CNTR_WIDTH
    )
    port map(
      in0 => x_cntr,
      in1 => y_cntr,
      in2 => z_cntr,
      
      sel => to_vector(axis),
      
      output => axis_cntr
    );
    
  with axis select bit_val <=
    x_bit when X,
    y_bit when Y,
    z_bit when Z;
    
  ALU_CTRL: entity work.ALU_CTRL(Behavioral)
    generic map(
      CNTR_WIDTH => CNTR_WIDTH
    )
    port map(
      axis => axis,
      bit_val => bit_val,
      cntr => unsigned(axis_cntr),
             
      op => op
    );
  
  ALU_LAYER: entity work.ALU_LAYER(Behavioral)
    generic map(
      REG_WIDTH => REG_WIDTH
    )
    port map(
      prime_0_in => pre_prime_0,
      prime_1_in => pre_prime_1,
      prime_2_in => pre_prime_2,
      prime_3_in => pre_prime_3,
      
      secondary_0_in => pre_secondary_0,
      secondary_1_in => pre_secondary_1,
      secondary_2_in => pre_secondary_2,
      secondary_3_in => pre_secondary_3,
      
      op => op,
      
      prime_0_out => alu_prime_0,
      prime_1_out => alu_prime_1,
      prime_2_out => alu_prime_2,
      prime_3_out => alu_prime_3,
      
      secondary_0_out => alu_secondary_0,
      secondary_1_out => alu_secondary_1,
      secondary_2_out => alu_secondary_2,
      secondary_3_out => alu_secondary_3,
      
      internal_error => internal_error
    );
    
  POST_ROUTER: entity work.POST_ROUTER(Behavioral)
    generic map(
      REG_WIDTH => REG_WIDTH
    )
    port map(
      axis => axis,
      
      prime_0 => alu_prime_0,
      prime_1 => alu_prime_1,
      prime_2 => alu_prime_2,
      prime_3 => alu_prime_3,
      
      secondary_0 => alu_secondary_0, 
      secondary_1 => alu_secondary_1, 
      secondary_2 => alu_secondary_2, 
      secondary_3 => alu_secondary_3, 
      
      A => post_A,
      B => post_B,
      C => post_C,
      D => post_D,
      E => post_E,
      F => post_F,
      G => post_G,
      H => post_H
    );
    
    A_out <= A;
    B_out <= B;
    C_out <= C;
    D_out <= D;
    E_out <= E;
    F_out <= F;
    G_out <= G;
    H_out <= H;
    
end architecture;