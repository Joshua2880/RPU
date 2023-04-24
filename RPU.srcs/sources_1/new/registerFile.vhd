library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Register_File is
  generic(REGISTER_WIDTH : integer := 64);
  port (
  		write_enable     : in  STD_LOGIC:='0';
  		rst     : in  STD_LOGIC:='0';
  		clk     : in  STD_LOGIC:='0';
        
        A_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        B_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        C_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        D_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        E_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        F_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        G_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        H_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        
        A_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        B_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        C_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        D_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        E_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        F_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        G_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        H_out     : out  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0')
        );
end entity Register_File;

architecture A1 of Register_File is
  
  signal A_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal B_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal C_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal D_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal E_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal F_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal G_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  signal H_wire : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
  
begin
  
  A_out <= A_wire;
  B_out <= B_wire;
  C_out <= C_wire;
  D_out <= D_wire;
  E_out <= E_wire;
  F_out <= F_wire;
  G_out <= G_wire;
  H_out <= H_wire;

  
  process(rst,clk,write_enable) is
  begin
  	if(rst = '1') then
    	A_wire <= (others => '0');
        B_wire <= (others => '0');
        C_wire <= (others => '0');
        D_wire <= (others => '0');
        E_wire <= (others => '0');
        F_wire <= (others => '0');
        G_wire <= (others => '0');
        H_wire <= (others => '0');
    elsif rising_edge(clk) and write_enable = '1' then
    	A_wire <= A_in;
        B_wire <= B_in;
        C_wire <= C_in;
        D_wire <= D_in;
        E_wire <= E_in;
        F_wire <= F_in;
        G_wire <= G_in;
        H_wire <= H_in;
    end if;
  end process;
  
end architecture;
