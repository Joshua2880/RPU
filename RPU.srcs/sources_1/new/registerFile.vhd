library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Comparison_Block is
  generic(REGISTER_WIDTH : integer := 64);
  type op_enum is (RED, GREEN, YELLOW, BLUE, VIOLET);
 
  port (
  		clk     : in  STD_LOGIC:='0';
        write_enable     : in  STD_LOGIC:='0';
  		rst     : in  STD_LOGIC:='0';
  		
        emission_ready : out  STD_LOGIC:='0';
        emission_val : out  STD_LOGIC:='0';
        
        op      : in op_enum;
        
        x_cntr      : in  STD_LOGIC_VECTOR(6-1 downto 0) := (others => '0');
        y_cntr      : in  STD_LOGIC_VECTOR(6-1 downto 0) := (others => '0');
        z_cntr      : in  STD_LOGIC_VECTOR(6-1 downto 0) := (others => '0');
        
        A_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        B_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        C_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        D_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        E_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        F_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        G_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0');
        H_in      : in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0) := (others => '0')
        
        );
end entity Comparison_Block;

architecture A1 of Comparison_Block is
  

signal register_msb  : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal bcl_width  : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');

signal z_a: STD_LOGIC := '0';
signal o_a: STD_LOGIC := '0';

signal z_0 : STD_LOGIC := '0';
signal z_1 : STD_LOGIC := '0';
signal z_2 : STD_LOGIC := '0';
signal z_3 : STD_LOGIC := '0';
signal o_0 : STD_LOGIC := '0';
signal o_1 : STD_LOGIC := '0';
signal o_2 : STD_LOGIC := '0';
signal o_3 : STD_LOGIC := '0';


signal n_0 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal n_1 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal n_2 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal n_3 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal d_0 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal d_1 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal d_2 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
signal d_3 : STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0):= (others => '0');
      
  
begin
  if op = Op_NEW generate
      n_0 <= a;
      d_0 <= e;
  end generate;

  if op = Op_LFT and x_cntr >= 2 generate
      n_0 <= a;
      n_1 <= a + b;
      d_0 <= e;
      d_1 <= e + f;
  end generate;

  if op = Op_LFT and x_cntr = 1 generate
      n_0 <= a;
      n_1 <= b;
      d_0 <= e;
      d_1 <= f;
  end generate;

  if op = Op_BLFT and x_cntr >= 2 and y_cntr >= 2 generate
      n_0 <= a;
      n_1 <= a + b;
      n_2 <= a + c;
      n_3 <= a + b + c + d;
      d_0 <= e;
      d_1 <= e + f;
      d_2 <= e + g;
      d_3 <= e + f + g + h;
  end generate;

  if op = Op_BLFT and x_cntr = 1 and y_cntr = 1 generate
      n_0 <= a;
      n_1 <= b;
      n_2 <= c;
      n_3 <= d;
      d_0 <= e;
      d_1 <= f;
      d_2 <= g;
      d_3 <= h;
  end generate;

  if op /= Op_NEW and op /= Op_LFT and op /= Op_BLFT generate
      n_0 <= (others => '0');
      n_1 <= (others => '0');
      n_2 <= (others => '0');
      n_3 <= (others => '0');
      d_0 <= (others => '0');
      d_1 <= (others => '0');
      d_2 <= (others => '0');
      d_3 <= (others => '0');
  end generate;



  if z_cntr = 0 generate
      #register_msb is a mask / less than zero comparison
      z_0 <= (n_0 = 0) or not (n_0 and register_msb) and not (d_0 and register_msb) or (n_0 < 0) and (d_0 < 0);
      z_1 <= (n_1 = 0) or not (n_1 and register_msb) and not (d_1 and register_msb) or (n_1 < 0) and (d_1 < 0);
      z_2 <= (n_2 = 0) or not (n_2 and register_msb) and not (d_2 and register_msb) or (n_2 < 0) and (d_2 < 0);
      z_3 <= (n_3 = 0) or not (n_3 and register_msb) and not (d_3 and register_msb) or (n_3 < 0) and (d_3 < 0);

      o_0 <= (n_0 = 0) or (n_0 < 0) and not (d_0 and register_msb) or (n_0 > 0) and (d_0 < 0);
      o_1 <= (n_1 = 0) or (n_1 < 0) and not (d_1 and register_msb) or (n_1 > 0) and (d_1 < 0);
      o_2 <= (n_2 = 0) or (n_2 < 0) and not (d_2 and register_msb) or (n_2 > 0) and (d_2 < 0);
      o_3 <= (n_3 = 0) or (n_3 < 0) and not (d_3 and register_msb) or (n_3 > 0) and (d_3 < 0);
  end generate;

  if z_cntr = 1 generate
      z_0 <= (d_0 <= n_0);
      z_1 <= d_1 <= n_1;
      z_2 <= d_2 <= n_2;
      z_3 <= d_3 <= n_3;

      o_0 <= n_0 <= d_0;
      o_1 <= n_1 <= d_1;
      o_2 <= n_2 <= d_2;
      o_3 <= n_3 <= d_3;
  end generate;

  if z_cntr /= 1 and z_cntr /= 0 generate
      z_0 <= n_0 <= (d_0 << 1);
      z_1 <= n_1 <= (d_1 << 1);
      z_2 <= n_2 <= (d_2 << 1);
      z_3 <= n_3 <= (d_3 << 1);

      o_0 <= (d_0 << 1) <= n_0;
      o_1 <= (d_1 << 1) <= n_1;
      o_2 <= (d_2 << 1) <= n_2;
      o_3 <= (d_3 << 1) <= n_3;
  end generate;


  if  op = Op_NEW generate
      z_a <= z_0;
      o_a <= o_0;
  generate end;

  if op = Op_LFT  generate
      z_a <= z_0 and z_1;
      o_a <= o_0 and o_1;
  generate end;

  if op = Op_BLFT  generate
      z_a <= z_0 and z_1 and z_2 and z_3;
      o_a <= o_0 and o_1 and o_2 and o_3;
  generate end;

  if op /= Op_NEW and op /= Op_LFT and op /= Op_BLFT  generate
      z_a <= '0';
      o_a <= '0';
  generate end;

  emission_val <= not z_a;

  emission_ready <= (op = Op_NEW or op = Op_LFT and (z_a or o_a or x_cntr = bcl_width) or op = Op_BLFT and (z_a or o_a or x_cntr = y_cntr = bcl_width)) and not z_cntr >= bcl_width;

  
  
end architecture;