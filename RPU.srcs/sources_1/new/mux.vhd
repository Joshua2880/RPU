----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Williams
-- 
-- Create Date: 04/20/2023 08:36:06 PM
-- Design Name: 
-- Module Name: MUX - dataflw
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

library ieee;
use ieee.std_logic_1164.all;

entity MUX_2 is
generic(DATA_WIDTH : integer := 64);
port(
    in0    : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- sel == 0
    in1    : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- sel == 1
    sel    : in std_logic;
    output : out std_logic_vector(DATA_WIDTH - 1 downto 0)
);
end entity;

architecture dataflw of MUX_2 is
begin
  output <= in0 when sel = '0' else 
            in1 when sel = '1' else
            (others => '-');
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_3 is
generic(DATA_WIDTH : integer := 64);
port(
    in0    : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- sel == 0
    in1    : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- sel == 1
    in2    : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- sel == 2
    sel    : in std_logic_vector(1 downto 0);
    output : out std_logic_vector(DATA_WIDTH - 1 downto 0)
);
end entity;

architecture dataflw of MUX_3 is
begin
  output <= in0 when sel = 2x"0" else 
            in1 when sel = 2x"1" else
            in2 when sel = 2x"2" else
            (others => '-');
end architecture;
