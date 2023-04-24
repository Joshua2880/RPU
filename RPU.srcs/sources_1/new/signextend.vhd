library ieee;
use ieee.std_logic_1164.all;

entity SignExtend is
generic(
  IN_WIDTH : integer := 32;
  OUT_WIDTH : integer := 64
);
port(
  x : in  STD_LOGIC_VECTOR(IN_WIDTH - 1 downto 0);
  y : out STD_LOGIC_VECTOR(OUT_WIDTH - 1 downto 0) -- sign-extend(x)
);
end SignExtend;

architecture dataflw of SignExtend is
begin
  y(IN_WIDTH - 1 downto 0) <= x;
  
  EXTEND: for i in IN_WIDTH to OUT_WIDTH - 1 generate
  begin
    y(i) <= x(IN_WIDTH - 1);
  end generate;
end architecture;