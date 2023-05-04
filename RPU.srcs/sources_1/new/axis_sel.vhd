----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2023 03:23:33 PM
-- Design Name: 
-- Module Name: AXIS_SEL - Behavioral
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

use work.types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AXIS_SEL is
  generic(
    CNTR_WIDTH : integer := 6
  );
  port(
    op : in OP_INTERN;
    emit_ready : in std_logic;
    x_cntr : in std_logic_vector(CNTR_WIDTH - 1 downto 0);
    y_cntr : in std_logic_vector(CNTR_WIDTH - 1 downto 0);
    
    axis : out AXIS
  );
end AXIS_SEL;

architecture Behavioral of AXIS_SEL is
begin
  axis <= Y when x_cntr > y_cntr and op = BLFT else
          Z when emit_ready = '1' else
          X;
          

end Behavioral;
