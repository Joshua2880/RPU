----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/22/2023 06:05:36 PM
-- Design Name: 
-- Module Name: BLFT_CTRL - Behavioral
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

entity BLFT_CTRL is
generic(
  CNTR_WIDTH : integer := 7
);
port(
  clk : in std_logic;

  emmit_ready : in std_logic;
  bit_val : in std_logic;
  cntr : in std_logic_vector(CNTR_WIDTH - 1 downto 0);
  
  axis : out std_logic_vector(1 downto 0);
  op : out std_logic_vector(3 downto 0)
);
end BLFT_CTRL;

architecture Behavioral of BLFT_CTRL is
begin
  process(clk) is
    variable axis_tmp : std_logic_vector(1 downto 0) := "--";
  begin
    if rising_edge(clk) then
      axis_tmp := "10" when emmit_ready = '0' else
                  "00" when cntr(0) = '0' else
                  "01" when cntr(0) = '1' else
                  "--";
      op(1 downto 0) <= "01" when unsigned(cntr(CNTR_WIDTH - 1 downto 1)) >= 2 and bit_val = '0' else 
                        "10" when unsigned(cntr(CNTR_WIDTH - 1 downto 1)) >= 2 and bit_val = '1' else 
                        "00";
      op(2) <= '1' when (unsigned(cntr(CNTR_WIDTH - 1 downto 1)) = 1 and bit_val = '1') or (unsigned(cntr(CNTR_WIDTH - 1 downto 1)) >= 2 and bit_val = '0') else '0';
      op(3) <= '1' when (unsigned(cntr(CNTR_WIDTH - 1 downto 1)) = 0 and bit_val = '1') or (axis_tmp = "10" and unsigned(cntr(CNTR_WIDTH - 1 downto 1)) >= 2 and bit_val = '0') else '0';
      axis <= axis_tmp;
    end if;
  end process;
end Behavioral;
