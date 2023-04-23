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


package types is
  type OP_EXTERN is (NOP, BCL, FRAC, DBL, ADD, SUB, MUL, DIV);
  type OP_INTERN is (NOP, BCL, FRAC, DBL, LFT, BLFT);
end package;