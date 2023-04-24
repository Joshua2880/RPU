library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparison_Block is
  generic(REGISTER_WIDTH : integer := 64;
  Op_NONE : STD_LOGIC_VECTOR := "00";
  Op_NEW : STD_LOGIC_VECTOR := "01";
  Op_LFT : STD_LOGIC_VECTOR := "10";
  Op_BLFT :STD_LOGIC_VECTOR :=  "11");
 -- type op_enum is (Op_NEW,Op_LFT,Op_BLFT);
 
  port(
  		clk     : in  STD_LOGIC:='0';
        write_enable     : in  STD_LOGIC:='0';
  		rst     : in  STD_LOGIC:='0';
  		
        emission_ready : out  STD_LOGIC:='0';
        emission_val : out  STD_LOGIC:='0';
        
        op      : in STD_LOGIC_VECTOR(2-1 downto 0);
        
        x_cntr      : in  STD_LOGIC_VECTOR(6-1 downto 0) := (others => '0');
        y_cntr      : in  STD_LOGIC_VECTOR(6-1 downto 0) := (others => '0');
        z_cntr      : in  STD_LOGIC_VECTOR(6-1 downto 0) := (others => '0');
        
        A_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        B_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        C_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        D_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        E_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        F_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        G_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0');
        H_in      : in  STD_LOGIC_VECTOR(64-1 downto 0) := (others => '0')
        
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

signal condition : STD_LOGIC_VECTOR(3-1 downto 0):= (others => '0');

           
begin
n_0 <= (others => '0') when (op = Op_NONE) else A_in;
d_0 <= (others => '0') when (op = Op_NONE) else E_in;

condition <=  "000" when (op = Op_LFT) and (x_cntr >= 2) else 
              "001" when (op = Op_LFT) and (x_cntr = 1) else
              "010" when (op = Op_BLFT) and (x_cntr >= 2) and (y_cntr >= 2) else
              "011" when (op = Op_BLFT) and (x_cntr = 1) and (y_cntr = 1) else
              "100";

n_1 <= (A_in + B_in) when condition = "000" else 
                B_in when condition = "001" else
         A_in + B_in when condition = "010" else
                B_in when condition = "011" else
                (others => '0');

n_2 <= A_in + B_in when condition = "010" else
              C_in when condition = "011" else
   (others => '0');
                
n_3 <= A_in + B_in + C_in + D_in when condition = "010" else
                            D_in when condition = "011" else
                 (others => '0');
                
d_1 <= (E_in + F_in) when condition = "000" else 
                F_in when condition = "001" else
         E_in + F_in when condition = "010" else
                F_in when condition = "011" else
                (others => '0');
                
d_2 <= E_in + G_in when condition = "010" else
              G_in when condition = "011" else
        (others => '0');
                
d_3 <=  E_in + F_in + G_in + H_in when condition = "010" else
                             H_in when condition = "011" else
                    (others => '0');
                
                
--  A2: if op = Op_LFT and x_cntr >= 2 generate
--      n_1 <= A_in + B_in;
--      d_1 <= E_in + F_in;
--  end generate A2;

--  A3: if op = Op_LFT and x_cntr = 1 generate
--      n_1 <= B_in;
--      d_1 <= F_in;
--  end generate A3;

--  A4: if op = Op_BLFT and x_cntr >= 2 and y_cntr >= 2 generate
--      n_1 <= A_in + B_in;
--      n_2 <= A_in + C_in;
--      n_3 <= A_in + B_in + C_in + D_in;
--      d_1 <= E_in + F_in;
--      d_2 <= E_in + G_in;
--      d_3 <= E_in + F_in + G_in + H_in;
--  end generate A4;

--  A5: if op = Op_BLFT and x_cntr = 1 and y_cntr = 1 generate
--      n_1 <= B_in;
--      n_2 <= C_in;
--      n_3 <= D_in;
--      d_1 <= F_in;
--      d_2 <= G_in;
--      d_3 <= H_in;
--  end generate A5;

--  A6: if op /= Op_NEW and op /= Op_LFT and op /= Op_BLFT generate
--      n_1 <= (others => '0');
--      n_2 <= (others => '0');
--      n_3 <= (others => '0');
--      d_1 <= (others => '0');
--      d_2 <= (others => '0');
--      d_3 <= (others => '0');
--  end generate A6;





z_0 <= '1' when (n_0 = 0) and (z_cntr = 0) else
		'1' when  ((n_0 and register_msb) = 0) and ((d_0 and register_msb) = 0) and (z_cntr = 0)  else
		'1' when  (n_0 < 0) and (d_0 < 0)and (z_cntr = 0) else
	  '1' when (d_0 <= n_0)and (z_cntr = 1) else
	  '0' when (z_cntr /= 1) and (z_cntr /= 0);

	  
z_1 <= '1' when (n_1 = 0) and (z_cntr = 0) else
		'1' when  ( (n_1 and register_msb) = 0) and ( (d_1 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_1 < 0) and (d_1 < 0)and (z_cntr = 0) else
	  '1' when  (d_1 <= n_1)and (z_cntr = 1) else
	  '0' when  signed(n_1) <= shift_left(signed(d_1),1);

z_2 <= '1' when (n_2 = 0) and (z_cntr = 0) else
		'1' when  ( (n_2 and register_msb) = 0) and ( (d_2 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_2 < 0) and (d_2 < 0)and (z_cntr = 0) else
	  '1' when  (d_2 <= n_2)and (z_cntr = 1) else
	  '0' when  signed(n_2) <= shift_left(signed(d_2),1);


z_3 <= '1' when (n_3 = 0) and (z_cntr = 0) else
		'1' when  ( (n_3 and register_msb) = 0) and ( (d_3 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_3 < 0) and (d_3 < 0)and (z_cntr = 0) else
	  '1' when  (d_3 <= n_3)and (z_cntr = 1) else
	  '0' when  signed(n_3) <= shift_left(signed(d_3),1);


o_0 <= '1' when (n_0 = 0)and (z_cntr = 0)  else
		'1' when  (n_0 < 0) and ( (d_0 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_0 > 0) and (d_0 < 0)and (z_cntr = 0) else
	  '1' when n_0 <= d_0 else
	  '0' when  shift_left(signed(d_0),1) <= signed(n_0);


o_1 <= '1' when (n_1 = 0)and (z_cntr = 0)  else
		'1' when  (n_1 < 0) and ( (d_1 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_1 > 0) and (d_1 < 0)and (z_cntr = 0) else
	  '1' when n_1 <= d_1 else
	  '0' when shift_left(signed(d_1),1) <= signed(n_1);


o_2 <= '1' when (n_2 = 0)and (z_cntr = 0)  else
		'1' when  (n_2 < 0) and ( (d_2 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_2 > 0) and (d_2 < 0)and (z_cntr = 0) else
	  '1' when  n_2 <= d_2 else
	  '0' when  shift_left(signed(d_2),1) <= signed(n_2);



o_3 <= '1' when (n_3 = 0)and (z_cntr = 0)  else
		'1' when  (n_3 < 0) and ( (d_3 and register_msb) = 0)and (z_cntr = 0)  else
		'1' when  (n_3 > 0) and (d_3 < 0)and (z_cntr = 0) else
	  '1' when n_3 <= d_3 else
	  '0' when shift_left(signed(d_3),1) <= signed(n_3);



--  A8: if z_cntr = 1 generate
--      z_0 <= (d_0 <= n_0);
--      z_1 <= D_in_in_1 <= n_1;
--      z_2 <= D_in_in_2 <= n_2;
--      z_3 <= D_in_in_3 <= n_3;

--      o_0 <= n_0 <= D_in_in_0;
--      o_1 <= n_1 <= D_in_in_1;
--      o_2 <= n_2 <= D_in_in_2;
--      o_3 <= n_3 <= D_in_in_3;
--  end generate A8;

--  A9: if z_cntr /= 1 and z_cntr /= 0 generate
--      z_0 <= n_0 <= (d_0 << 1);
--      z_1 <= n_1 <= (d_1 << 1);
--      z_2 <= n_2 <= (d_2 << 1);
--      z_3 <= n_3 <= (d_3 << 1);

--      o_0 <= (d_0 << 1) <= n_0;
--      o_1 <= (d_1 << 1) <= n_1;
--      o_2 <= (d_2 << 1) <= n_2;
--      o_3 <= (d_3 << 1) <= n_3;
--  end generate A9;


z_a <=  '1' when (z_0 = '1') and (op = Op_NEW) else
		'1' when (z_0 = '1') and (z_1 = '1') and (op = Op_LFT) else
		'1' when (z_0 = '1') and (z_1 = '1') and (z_2  = '1') and (z_3 = '1') and (op = Op_BLFT) else
		'0';--(op /= Op_NEW and op /= Op_LFT and op /= Op_BLFT)

o_a <=  '1' when (o_0 = '1') and (op = Op_NEW) else
		'1' when (o_0 = '1') and (o_1 = '1') and (op = Op_LFT) else
		'1' when (o_0 = '1') and (o_1 = '1') and (o_2 = '1') and (o_3 = '1') and (op = Op_BLFT) else
		'0';--when (op /= Op_NEW and op /= Op_LFT and op /= Op_BLFT)

emission_val <= (not z_a);

--# emission_ready is the output
emission_ready <= '1' when (not z_cntr >= bcl_width) and (op = Op_NEW)  else
				  '1' when (not z_cntr >= bcl_width) and (op = Op_LFT)  and (z_a = '1')  else
				  '1' when (not z_cntr >= bcl_width) and (op = Op_LFT)  and (o_a = '1')  else
				  '1' when (not z_cntr >= bcl_width) and (op = Op_LFT)  and (x_cntr = bcl_width)  else
				  '1' when (not z_cntr >= bcl_width) and (op = Op_BLFT) and (z_a = '1')  else
				  '1' when (not z_cntr >= bcl_width) and (op = Op_BLFT) and (o_a = '1')  else
				  '1' when (not z_cntr >= bcl_width) and (op = Op_BLFT) and (x_cntr = y_cntr) and (y_cntr = bcl_width) else
				  '0';
  
end architecture;
