----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/21/2023 05:53:21 PM
-- Design Name: 
-- Module Name: BLFT_TB - Behavioral
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

entity BLFT_TB is
--  Port ( );
end BLFT_TB;

architecture Behavioral of BLFT_TB is
  constant WIDTH : integer := 256;

  signal axis : std_logic_vector(1 downto 0);
  
  signal A_in : std_logic_vector(WIDTH - 1 downto 0);
  signal B_in : std_logic_vector(WIDTH - 1 downto 0);
  signal C_in : std_logic_vector(WIDTH - 1 downto 0);
  signal D_in : std_logic_vector(WIDTH - 1 downto 0);
  signal E_in : std_logic_vector(WIDTH - 1 downto 0);
  signal F_in : std_logic_vector(WIDTH - 1 downto 0);
  signal G_in : std_logic_vector(WIDTH - 1 downto 0);
  signal H_in : std_logic_vector(WIDTH - 1 downto 0);
  
  signal pre_prime_0 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_prime_1 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_prime_2 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_prime_3 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_secondary_0 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_secondary_1 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_secondary_2 : std_logic_vector(WIDTH - 1 downto 0);
  signal pre_secondary_3 : std_logic_vector(WIDTH - 1 downto 0);
  
  signal post_prime_0 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_prime_1 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_prime_2 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_prime_3 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_secondary_0 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_secondary_1 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_secondary_2 : std_logic_vector(WIDTH - 1 downto 0);
  signal post_secondary_3 : std_logic_vector(WIDTH - 1 downto 0);
  
  signal A_out : std_logic_vector(WIDTH - 1 downto 0);
  signal B_out : std_logic_vector(WIDTH - 1 downto 0);
  signal C_out : std_logic_vector(WIDTH - 1 downto 0);
  signal D_out : std_logic_vector(WIDTH - 1 downto 0);
  signal E_out : std_logic_vector(WIDTH - 1 downto 0);
  signal F_out : std_logic_vector(WIDTH - 1 downto 0);
  signal G_out : std_logic_vector(WIDTH - 1 downto 0);
  signal H_out : std_logic_vector(WIDTH - 1 downto 0);
begin
  PRE_ROUTER: entity work.PRE_ROUTER(Behavioral)
    generic map(
      REG_WIDTH => WIDTH
    )
    port map(
      axis => axis,
      
      A => A_in,
      B => B_in,
      C => C_in,
      D => D_in,
      E => E_in,
      F => F_in,
      G => G_in,
      H => H_in,
      
      prime_0 => pre_prime_0,
      prime_1 => pre_prime_1,
      prime_2 => pre_prime_2,
      prime_3 => pre_prime_3,
      secondary_0 => pre_secondary_0,
      secondary_1 => pre_secondary_1,
      secondary_2 => pre_secondary_2,
      secondary_3 => pre_secondary_3
    );
  
  ALU_LAYER: entity work.ALU_LAYER(Behavioral)
    generic map(
      REG_WIDTH => WIDTH
    )

end Behavioral;
