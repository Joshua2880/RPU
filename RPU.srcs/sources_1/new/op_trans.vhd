----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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
  process(clk) is
  begin
    if rising_edge(clk) then
      if op_in = NOP then 
        op_out <= NOP;                
                                                         
        A <= std_logic_vector(to_signed(0, REG_WIDTH));
        B <= std_logic_vector(to_signed(0, REG_WIDTH));
        C <= std_logic_vector(to_signed(0, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(0, REG_WIDTH));
        H <= std_logic_vector(to_signed(0, REG_WIDTH));
        
      elsif op_in = BCL then
        op_out <= BCL;
                                                         
        A <= std_logic_vector(to_signed(0, REG_WIDTH));
        B <= std_logic_vector(to_signed(0, REG_WIDTH));
        C <= std_logic_vector(to_signed(0, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(0, REG_WIDTH));
        H <= std_logic_vector(to_signed(0, REG_WIDTH));
        
      elsif op_in = FRAC then
        op_out <= FRAC;
                                                         
        A <= std_logic_vector(to_signed(1, REG_WIDTH));
        B <= std_logic_vector(to_signed(0, REG_WIDTH));
        C <= std_logic_vector(to_signed(0, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(1, REG_WIDTH));
        H <= std_logic_vector(to_signed(0, REG_WIDTH));
        
      elsif op_in = DBL then
        op_out <= DBL;
                                                         
        A <= std_logic_vector(to_signed(1, REG_WIDTH));
        B <= std_logic_vector(to_signed(0, REG_WIDTH));
        C <= std_logic_vector(to_signed(0, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(1, REG_WIDTH));
        H <= std_logic_vector(to_signed(0, REG_WIDTH));
        
      elsif op_in = ADD then
        op_out <= BLFT;
                                                         
        A <= std_logic_vector(to_signed(0, REG_WIDTH));
        B <= std_logic_vector(to_signed(1, REG_WIDTH));
        C <= std_logic_vector(to_signed(1, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(0, REG_WIDTH));
        H <= std_logic_vector(to_signed(1, REG_WIDTH));
        
      elsif op_in = SUB then
        op_out <= BLFT;
                                                         
        A <= std_logic_vector(to_signed(0, REG_WIDTH));
        B <= std_logic_vector(to_signed(1, REG_WIDTH));
        C <= std_logic_vector(to_signed(-1, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(0, REG_WIDTH));
        H <= std_logic_vector(to_signed(1, REG_WIDTH));
        
      elsif op_in = MUL then
        op_out <= BLFT;
                                                         
        A <= std_logic_vector(to_signed(1, REG_WIDTH));
        B <= std_logic_vector(to_signed(0, REG_WIDTH));
        C <= std_logic_vector(to_signed(0, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(0, REG_WIDTH));
        H <= std_logic_vector(to_signed(1, REG_WIDTH));
        
      elsif op_in = ADD then
        op_out <= BLFT;
                                                         
        A <= std_logic_vector(to_signed(0, REG_WIDTH));
        B <= std_logic_vector(to_signed(1, REG_WIDTH));
        C <= std_logic_vector(to_signed(0, REG_WIDTH));
        D <= std_logic_vector(to_signed(0, REG_WIDTH));
        E <= std_logic_vector(to_signed(0, REG_WIDTH));
        F <= std_logic_vector(to_signed(0, REG_WIDTH));
        G <= std_logic_vector(to_signed(1, REG_WIDTH));
        H <= std_logic_vector(to_signed(0, REG_WIDTH));
      end if;
    end if;
  end process;
end Behavioral;
