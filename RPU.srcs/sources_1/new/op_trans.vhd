----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/22/2023 07:57:15 PM
-- Design Name: 
-- Module Name: OP_TRANS - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OP_TRANS is
generic(
  REG_WIDTH : integer := 256
);
port(
  clk : in std_logic;

  op_in : in OP_EXTERN;
  
  op_out : out OP_INTERN;
  
  A : out std_logic_vector(REG_WIDTH - 1 downto 0);
  B : out std_logic_vector(REG_WIDTH - 1 downto 0);
  C : out std_logic_vector(REG_WIDTH - 1 downto 0);
  D : out std_logic_vector(REG_WIDTH - 1 downto 0);
  E : out std_logic_vector(REG_WIDTH - 1 downto 0);
  F : out std_logic_vector(REG_WIDTH - 1 downto 0);
  G : out std_logic_vector(REG_WIDTH - 1 downto 0);
  H : out std_logic_vector(REG_WIDTH - 1 downto 0)
);
end OP_TRANS;

architecture Behavioral of OP_TRANS is
begin
  with op_in select op_out <=
    NOP when NOP,
    BCL when BCL,
    FRAC when FRAC,
    DBL when DBL,
    BLFT when ADD,
    BLFT when SUB,
    BLFT when MUL,
    BLFT when DIV;
    
  with op_in select A <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(1, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(0, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(1, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DIV;

  with op_in select B <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(1, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(0, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when DIV;
    
  with op_in select C <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(-1, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(0, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DIV;
    
  with op_in select D <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(0, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(0, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DIV;
    
  with op_in select E <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(0, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(0, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DIV;

  with op_in select F <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(0, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(0, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DIV;
    
  with op_in select G <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(1, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(0, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(0, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when DIV;
    
  with op_in select H <=
    std_logic_vector(to_signed(0, REG_WIDTH)) when NOP,
    std_logic_vector(to_signed(0, REG_WIDTH)) when BCL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when FRAC,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DBL,
    std_logic_vector(to_signed(1, REG_WIDTH)) when ADD,
    std_logic_vector(to_signed(1, REG_WIDTH)) when SUB,
    std_logic_vector(to_signed(1, REG_WIDTH)) when MUL,
    std_logic_vector(to_signed(0, REG_WIDTH)) when DIV;
    
end Behavioral;
