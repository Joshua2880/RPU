----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 08:36:06 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity ALU is
generic(DATA_WIDTH : integer := 256);
port(
     in0       : in     STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
     in1       : in     STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
     operation : in     STD_LOGIC_VECTOR(1 downto 0);
     result    : buffer STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
     overflow  : buffer STD_LOGIC
    );
end ALU;

architecture structural of ALU is
  signal interm : std_logic_vector(DATA_WIDTH - 1 downto 0);
begin
  
  interm <= in0 when operation = 2x"0" else
            in0 + in1  when operation = 2x"1" else
            in0 sll 1 when operation = 2x"2"  else
            (others => '-');
  
  result <= interm;
  
  overflow <= not (in0(DATA_WIDTH - 1) xor in1(DATA_WIDTH - 1)) and (in0(DATA_WIDTH - 1) xor interm(DATA_WIDTH - 1)) and (in1(DATA_WIDTH - 1) xor interm(DATA_WIDTH - 1)) when operation = 2x"1" else
              in0(DATA_WIDTH - 1) xor in0(DATA_WIDTH - 2) when operation = 2x"2" else
              '0';
end architecture;
