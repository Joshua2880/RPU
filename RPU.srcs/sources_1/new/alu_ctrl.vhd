----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/22/2023 06:05:36 PM
-- Design Name: 
-- Module Name: ALU_CTRL - Behavioral
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

use work.types.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_CTRL is
generic(
  CNTR_WIDTH : integer := 6
);
port(
  axis : in AXIS;
  bit_val : in std_logic;
  cntr : in unsigned(CNTR_WIDTH - 1 downto 0);
  
  op : out std_logic_vector(3 downto 0)
);
end ALU_CTRL;

architecture Behavioral of ALU_CTRL is
begin
  op(1 downto 0) <= "01" when cntr >= 2 and bit_val = '0' else 
                    "10" when cntr >= 2 and bit_val = '1' else 
                    "00";
      
  op(2) <= '1' when (cntr = 1 and bit_val = '1') or (cntr >= 2 and bit_val = '0') else '0';
  op(3) <= '1' when (cntr = 0 and bit_val = '1') or (axis = Z and cntr >= 2 and bit_val = '0') else '0';
end Behavioral;
