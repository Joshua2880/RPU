----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/22/2023 07:50:27 PM
-- Design Name: 
-- Module Name:  - 
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
use IEEE.std_logic_1164.all;

package types is
  type OP_EXTERN is (NOP, BCL, FRAC, DBL, ADD, SUB, MUL, DIV);
  type OP_INTERN is (NOP, BCL, FRAC, DBL, LFT, BLFT);
  type AXIS is (X, Y, Z);
  
  function to_AXIS (
      axis_v : in std_logic_vector(1 downto 0)
    )
    return AXIS;
    
  function to_vector (
      axis_t : in AXIS
    )
    return std_logic_vector;
end package;

package body types is
  function to_AXIS (
      axis_v : in std_logic_vector(1 downto 0)
    )
    return AXIS is
  begin
    case axis_v is 
      when "00" =>
        return X;
      when "01" =>
        return Y;
      when "10" =>
        return Z;
    end case;
  end function;
  
  function to_vector (
      axis_t : in AXIS
    )
    return std_logic_vector is
  begin
    case axis_t is 
      when X =>
        return "00";
      when Y =>
        return "01";
      when Z =>
        return "10";
    end case;
  end function;
end package body;
