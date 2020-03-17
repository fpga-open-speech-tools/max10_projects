-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library altera;
use altera.altera_syn_attributes.all;

entity MAX10_system is
	port
	(
		SWITCH1 : in std_logic;
		RESET_N : in std_logic;
		SWITCH2 : in std_logic;
		SWITCH3 : in std_logic;
		SWITCH4 : in std_logic;
		SWITCH5 : in std_logic;
    
		LED1 : out std_logic;
		LED2 : out std_logic;
		LED3 : out std_logic;
		LED4 : out std_logic;
		LED5 : out std_logic;

		Arduino_A0 : in std_logic;
		Arduino_A1 : in std_logic;
		Arduino_A2 : in std_logic;
		Arduino_A3 : in std_logic;
		Arduino_A4 : in std_logic;
		Arduino_A5 : in std_logic;
		Arduino_A6 : in std_logic;
		Arduino_A7 : in std_logic;

		Arduino_IO8 : inout std_logic;
		Arduino_IO9 : in std_logic;
		Arduino_IO10 : in std_logic;
		Arduino_IO11 : inout std_logic;
		Arduino_IO12 : in std_logic;
		Arduino_IO13 : in std_logic;
		Arduino_IO1 : in std_logic;
		Arduino_IO0 : in std_logic;
		Arduino_IO3 : in std_logic;
		Arduino_IO2 : in std_logic;
		Arduino_IO4 : in std_logic;
		Arduino_IO5 : in std_logic;
		Arduino_IO6 : in std_logic;
		Arduino_IO7 : in std_logic;
    
		CLOCK : in std_logic;
    
    -- There are 40 GPIOs. In this example pins are not used as LVDS pins. 
    -- NOTE: Refer README.txt on how to use these GPIOs with LVDS option. 
    
		DIFFIO_L20N_CLK1N : in std_logic;
		DIFFIO_L20P_CLK1P : in std_logic;
		DIFFIO_L27N_PLL_CLKOUTN : in std_logic;
		DIFFIO_L27P_PLL_CLKOUTP : in std_logic;
		DIFFIO_B1N : in std_logic;
		DIFFIO_B1P : in std_logic;
		DIFFIO_B5N : in std_logic;
		DIFFIO_B5P : in std_logic;
		DIFFIO_B9N : in std_logic;
		DIFFIO_B9P : in std_logic;
		DIFFIO_B14N : inout std_logic;
		DIFFIO_B14P : inout std_logic;
		DIFFIO_R14P_CLK2P : in std_logic;
		DIFFIO_R14N_CLK2N : in std_logic;
		DIFFIO_R16P_CLK3P : in std_logic;
		DIFFIO_R16N_CLK3N : in std_logic;
		DIFFIO_R26P_DPCLK3 : in std_logic;
		DIFFIO_R26N_DPCLK2 : in std_logic;
		DIFFIO_R27P : in std_logic;
		DIFFIO_R28P : in std_logic;
		DIFFIO_R27N : in std_logic;
		DIFFIO_R28N : in std_logic;
		DIFFIO_R33P : in std_logic;
		DIFFIO_R33N : in std_logic;
		DIFFIO_T1P : in std_logic;
		DIFFIO_T1N : in std_logic;
		DIFFIO_T4N : in std_logic;
		DIFFIO_T6P : in std_logic;
		DIFFIO_T10P : in std_logic;
		DIFFIO_T10N : in std_logic;
    
    
    
		DIFFIO_R18P : inout std_logic;
		DIFFIO_R18N : inout std_logic;
		DIFFIO_B3N : inout std_logic;
		DIFFIO_B3P : inout std_logic;
		DIFFIO_B7N  : out std_logic;
		DIFFIO_B7P  : out std_logic;
		DIFFIO_B12N : out std_logic;
		DIFFIO_B12P : out std_logic;
		DIFFIO_B16N : in std_logic;
		DIFFIO_B16P : in std_logic
    
    
	);

end MAX10_system;

architecture ppl_type of MAX10_system is

  component soc_system is
  port (
    altpll_0_locked_conduit_export    : out std_logic;                                        -- export
    clk_clk                           : in  std_logic                     := 'X';             -- clk
    i2s_output_bclk_out               : out std_logic;                                        -- bclk_out
    i2s_output_lrclk_out              : out std_logic;                                        -- lrclk_out
    i2s_output_sdata_out              : out std_logic_vector(31 downto 0);                    -- sdata_out
    pll_mclk_clk                      : out std_logic;                                        -- clk
    reset_reset_n                     : in  std_logic                     := 'X';             -- reset_n
    serial_input_serial_control       : in  std_logic                     := 'X';             -- serial_control
    serial_input_serial_clk           : in  std_logic                     := 'X';             -- serial_clk
    serial_input_serial_data          : in  std_logic                     := 'X'             -- serial_data
  );
  end component soc_system;
  
  component i2c_master IS
  GENERIC(
    input_clk : INTEGER := 50_000_000; --input clock speed from user logic in Hz
    bus_clk   : INTEGER := 100_000);   --speed the i2c bus (scl) will run at in Hz
  PORT(
    clk       : IN     STD_LOGIC;                    --system clock
    reset_n   : IN     STD_LOGIC;                    --active low reset
    ena       : IN     STD_LOGIC;                    --latch in command
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
  END component i2c_master;

  
  component FE_NCP5623B is
    
    port (
      sys_clk               : in  std_logic                     := '0';
      reset_n               : in  std_logic                     := '0';
      
      -- Avalon streaming input
      rgb_input_data        : in std_logic_vector(15 downto 0)  := (others => '0');
      rgb_input_valid       : in std_logic                      := '0'; 
      rgb_input_error       : in std_logic_vector(1 downto 0)   := (others => '0');
     
      i2c_enable_out        : out std_logic;
      i2c_address_out       : out std_logic_vector(6 downto 0) := "0111000";
      i2c_rdwr_out          : out std_logic;
      i2c_data_write_out    : out std_logic_vector(7 downto 0) := (others => '0');
      i2c_bsy_in            : in  std_logic;
      i2c_data_read_in      : in  std_logic_vector(7 downto 0) := (others => '0');
        
      i2c_req_out           : out std_logic;
      i2c_rdy_in            : in  std_logic
    );
  end component FE_NCP5623B;
  
  signal clk50            : std_logic := '0';
  signal mclk_clk         : std_logic := '0';
  signal serial_control   : std_logic := '0';
  signal serial_clk       : std_logic := '0';
  signal serial_data      : std_logic := '0';
  signal bclk_out         : std_logic := '0';
  signal lrclk_out        : std_logic := '0';
  signal sdata_out        : std_logic := '0';
  signal altpll_0_locked  : std_logic := '0';  
    
  -- I2C logic signals
  signal i2c_enable : std_logic;
  signal i2c_address : std_logic_vector(6 downto 0) := "0111000";
  signal i2c_rdwr : std_logic;
  signal i2c_data_write : std_logic_vector(7 downto 0) := (others => '0');
  signal i2c_bsy : std_logic;
  signal i2c_data_read : std_logic_vector(7 downto 0) := (others => '0');
  signal i2c_data_clk : std_logic;
  signal i2c_err : std_logic;
    
  signal delay_counter : unsigned(31 downto 0) := (others => '0');
  signal delay_value   : unsigned(31 downto 0) := x"02FAF080";
  
  signal ILED_OUTPUT : std_logic_vector(2 downto 0) := "001";
  signal MAX_OUTPUT  : std_logic_vector(4 downto 0) := "11111";
   
  signal PWM1 : std_logic_vector(2 downto 0) := "010";
  signal PWM2 : std_logic_vector(2 downto 0) := "011";
  signal PWM3 : std_logic_vector(2 downto 0) := "100";
  
  signal PWM1_COLOR : std_logic_vector(4 downto 0) := "00000";
  signal PWM2_COLOR : std_logic_vector(4 downto 0) := "00000";
  signal PWM3_COLOR : std_logic_vector(4 downto 0) := "00000";
   
  signal i2c_write : std_logic := '0';
  signal first_byte : std_logic_vector(7 downto 0) := (others => '0');
  signal second_byte : std_logic_vector(7 downto 0) := (others => '0');
  signal write_two : std_logic := '0';
  signal second_byte_loaded : std_logic := '0';
  
  signal temp : std_logic_vector(511 downto 0) := (others => '0');
  
  signal rgb_data        : std_logic_vector(15 downto 0)  := (others => '0');  
  signal rgb_valid       : std_logic                      := '0'; 
  signal rgb_error       : std_logic_vector(1 downto 0)   := (others => '0');  
  
  type i2c_state is ( idle,load_first_byte,load_second_byte,
                      tx_wait,i2c_busy_wait, init_device,
                      load_r, load_g, load_b); 
  signal cur_i2c_state : i2c_state := idle;
  signal next_i2c_state : i2c_state := idle;


begin


u0 : component soc_system
  port map (
    clk_clk                        => CLOCK,
    reset_reset_n                  => RESET_N,
    pll_mclk_clk                   => open,--DIFFIO_B7N,
    serial_input_serial_control    => open,--serial_control,
    serial_input_serial_clk        => open,--DIFFIO_B16N,
    serial_input_serial_data       => open--DIFFIO_B16P
);

i2c_component : i2c_master 
 port map(
   clk       => CLOCK,
   reset_n   => RESET_N,
   ena       => i2c_enable,
   addr      => i2c_address,
   rw        => i2c_rdwr,
   data_wr   => i2c_data_write,
   busy      => i2c_bsy,
   data_rd   => i2c_data_read,
   ack_error => i2c_err,
   sda       => DIFFIO_B14P,
   scl       => DIFFIO_B14N
);  

NCP5623B : FE_NCP5623B
port map(
    sys_clk               => CLOCK,
    reset_n               => RESET_N,
    
    -- Avalon streaming input
    rgb_input_data        => rgb_data,
    rgb_input_valid       => rgb_valid, 
    rgb_input_error       => open,

    i2c_enable_out        => i2c_enable,
    i2c_address_out       => i2c_address,
    i2c_rdwr_out          => i2c_rdwr,
    i2c_data_write_out    => i2c_data_write,
    i2c_bsy_in            => i2c_bsy,
    i2c_data_read_in      => i2c_data_read,
      
    i2c_req_out           => open,
    i2c_rdy_in            => '1'
);

  -- Process to start the data transmission after X clock cycles
  counter_process: process(CLOCK,RESET_N)
  begin
    if RESET_N = '0' then 
      delay_counter   <= (others => '0');
    elsif rising_edge(CLOCK) then 

      -- If the counter reaches the defined value, pulse the transmit data signal and reset the counter
      if delay_counter = delay_value then 
        delay_counter <= (others => '0');
        i2c_write <= '1';
      else
        i2c_write <= '0';
        delay_counter <= delay_counter + 1;
      end if;
    end if;
  end process;

  color_change: process(CLOCK,RESET_N)
  begin
    if RESET_N = '0' then 
      PWM1_COLOR <= "00000";
      PWM2_COLOR <= "00010";
      PWM3_COLOR <= "00100";
    elsif rising_edge(CLOCK) then 
      if i2c_write = '1' then 
        if PWM1_COLOR = "10000" then 
          PWM1_COLOR <= "00000";
        else 
          PWM1_COLOR <= std_logic_vector(unsigned(PWM1_COLOR) + 1);
        end if;
        if PWM2_COLOR = "10000" then 
          PWM2_COLOR <= "00000";
        else 
          PWM2_COLOR <= std_logic_vector(unsigned(PWM2_COLOR) + 1);
        end if;
        if PWM3_COLOR = "10000" then 
          PWM3_COLOR <= "00000";
        else 
          PWM3_COLOR <= std_logic_vector(unsigned(PWM3_COLOR) + 1);
        end if;
        rgb_data <= "0" & PWM1_COLOR & PWM2_COLOR & PWM3_COLOR;
        rgb_valid <= '1';
      else
        rgb_data <= rgb_data;
        rgb_valid <= '0';
      end if;
      
      
      PWM1_COLOR <= "11111";
      PWM2_COLOR <= "00000";
      PWM3_COLOR <= "00000";
    end if;
  end process;
    
end;














































