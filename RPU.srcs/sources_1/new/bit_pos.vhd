----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 10:57:06 PM
-- Design Name: 
-- Module Name: BIT_POS - Behavioral
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
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BIT_POS is
generic(
  DATA_WIDTH : integer := 256;
  OUTPUT_WIDTH : integer := 8
);
port(
  mask : in std_logic_vector(DATA_WIDTH - 1 downto 0);
  
  pos : out std_logic_vector(OUTPUT_WIDTH - 1 downto 0)
);
end BIT_POS;

architecture Behavioral of BIT_POS is
  component BIT_POS is
    generic(
      DATA_WIDTH : integer;
      OUTPUT_WIDTH : integer
    );
    port(
      mask : in std_logic_vector(DATA_WIDTH - 1 downto 0);
  
      pos : out std_logic_vector(OUTPUT_WIDTH - 1 downto 0)
    );
  end component;
  
  signal sel_high : std_logic;
  signal internal_in : std_logic_vector(DATA_WIDTH / 2 - 1 downto 0);
  signal internal_pos : std_logic_vector(OUTPUT_WIDTH - 2 downto 0);
begin
  sel_high <= or_reduce(mask(DATA_WIDTH - 1 downto DATA_WIDTH / 2));

  MUX : entity work.MUX_2(dataflw)
    generic map(
      DATA_WIDTH => DATA_WIDTH / 2
    )
    port map(
      in0 => mask(DATA_WIDTH / 2 - 1 downto 0),
      in1 => mask(DATA_WIDTH - 1 downto DATA_WIDTH / 2),
      sel => sel_high,
      output => internal_in
    );

  RECURSIVE_MAP: if OUTPUT_WIDTH > 2 generate
    INTERNAL: BIT_POS
      generic map(
        DATA_WIDTH => DATA_WIDTH / 2,
        OUTPUT_WIDTH => OUTPUT_WIDTH - 1
      )
      port map (
        mask => internal_in,
        pos => internal_pos
      );
    pos <= sel_high & internal_pos;
  else generate
    pos <= sel_high & internal_in(1);
  end generate;

end Behavioral;
