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

		Arduino_IO8 : in std_logic;
		Arduino_IO9 : in std_logic;
		Arduino_IO10 : in std_logic;
		Arduino_IO11 : in std_logic;
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
		DIFFIO_B14N : in std_logic;
		DIFFIO_B14P : in std_logic;
		DIFFIO_R14P_CLK2P : out std_logic;
		DIFFIO_R14N_CLK2N : out std_logic;
		DIFFIO_R16P_CLK3P : out std_logic;
		DIFFIO_R16N_CLK3N : out std_logic;
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
		DIFFIO_B3N : out std_logic;
		DIFFIO_B3P : out std_logic;
		DIFFIO_B7N  : out std_logic;
		DIFFIO_B7P  : out std_logic;
		DIFFIO_B12N : out std_logic;
		DIFFIO_B12P : out std_logic;
		DIFFIO_B16N : out std_logic;
		DIFFIO_B16P : out std_logic
    
    
	);

end MAX10_system;

architecture ppl_type of MAX10_system is

component cx_system is
  port (
    clk_clk                        : in  std_logic                     := 'X';             -- clk
    i2c_clk_clk                    : out std_logic;                                        -- clk
    led_output_led_sd              : out std_logic;                                        -- led_sd
    led_output_led_ws              : out std_logic;                                        -- led_ws
    pll_mclk_clk                   : out std_logic;                                        -- clk
    reset_reset_n                  : in  std_logic                     := 'X';             -- reset_n
    serial_clk_clk                 : in  std_logic                     := 'X';             -- serial_clk_in
    rj45_interface_serial_data_in  : in  std_logic                     := 'X';             -- serial_data_in
    rj45_interface_serial_data_out : out std_logic;                                        -- serial_data_out
    bme_input_data                 : in  std_logic_vector(63 downto 0) := (others => 'X'); -- data
    bme_input_error                : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    bme_input_valid                : in  std_logic                     := 'X';             -- valid
    mic_input_data                 : in  std_logic_vector(31 downto 0) := (others => 'X'); -- data
    mic_input_channel              : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- channel
    mic_input_error                : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    mic_input_valid                : in  std_logic                     := 'X';             -- valid
    control_conduit_busy_out       : out std_logic                                         -- busy_out
  );
end component cx_system;
  


component FE_Streaming_Counter is
generic ( 
    n_channels    : integer := 8;
    channel_width : integer := 8;
    data_width    : integer := 24
  );
  port (
    sys_clk             : in  std_logic                     := '0';
    reset_n             : in  std_logic                     := '0';
    
    data_output_channel  : out  std_logic_vector(channel_width-1 downto 0)  := (others => '0');
    data_output_data     : out  std_logic_vector(data_width-1 downto 0) := (others => '0');
    data_output_error    : out  std_logic_vector(1 downto 0)  := (others => '0');
    data_output_valid    : out  std_logic                     := '0'
  );
end component;

  
  signal clk50            : std_logic := '0';
  signal mclk_clk         : std_logic := '0';
  signal serial_control   : std_logic := '0';
  signal serial_clk       : std_logic := '0';
  signal serial_data      : std_logic := '0';
  signal bclk_out         : std_logic := '0';
  signal lrclk_out        : std_logic := '0';
  signal sdata_out        : std_logic := '0';
  signal altpll_0_locked  : std_logic := '0'; 
  signal rj45_sdo_r       : std_logic := '0';
    
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
  
  
    
  type i2c_state is ( idle,load_first_byte,load_second_byte,
                      tx_wait,i2c_busy_wait, init_device,
                      load_r, load_g, load_b); 
  signal cur_i2c_state : i2c_state := init_device;
  signal next_i2c_state : i2c_state := idle;
  
  signal bme_data : std_logic_vector(63 downto 0) := (others => '0');
  signal bme_valid : std_logic := '0';
  signal bme_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal mic_data : std_logic_vector(31 downto 0) := (others => '0');
  signal mic_valid : std_logic := '0';
  signal mic_error : std_logic_vector(1 downto 0) := (others => '0');
  signal mic_channel : std_logic_vector(4 downto 0) := (others => '0');
  
  signal debug_output : std_logic_vector(7 downto 0) := (others => '0');

begin

pd : cx_system
  port map (
    clk_clk                        => CLOCK,
    reset_reset_n                  => RESET_N,
    i2c_clk_clk                    => i2c_data_clk,                    --                 i2c_clk.clk
    led_output_led_sd              => open,              --              led_output.led_sd
    led_output_led_ws              => open,              --                        .led_ws
            
    pll_mclk_clk                   => open,
    serial_clk_clk                 => i2c_data_clk,   --          rj45_interface.serial_clk_in
    rj45_interface_serial_data_in  => open,  --                        .serial_data_in
    rj45_interface_serial_data_out => rj45_sdo_r, --                        .serial_data_out
    bme_input_data                 => bme_data,                 --               bme_input.data
    bme_input_error                => bme_error,                --                        .error
    bme_input_valid                => bme_valid,                --                        .valid
    mic_input_data                 => mic_data,                 --               mic_input.data
    mic_input_channel              => mic_channel,              --                        .channel
    mic_input_error                => mic_error,                --                        .error
    mic_input_valid                => mic_valid,                --                        .valid
    control_conduit_busy_out       => open                                         -- busy_out
);

mic_counter:  FE_Streaming_Counter
generic map ( 
  n_channels    => 16,
  channel_width => 5,
  data_width    => 24
)
port map (
  sys_clk  => CLOCK,
  reset_n  => RESET_N,
  
  data_output_channel  => mic_channel,
  data_output_data     => mic_data(23 downto 0),
  data_output_error    => mic_error,
  data_output_valid    => mic_valid
);

bme_counter:  FE_Streaming_Counter
generic map ( 
  n_channels    => 1,
  channel_width => 1,
  data_width    => 64
)
port map (
  sys_clk               => CLOCK,
  reset_n               => RESET_N,
  
  data_output_channel  => open,
  data_output_data     => bme_data,
  data_output_error    => bme_error,
  data_output_valid    => bme_valid
);

DIFFIO_B3P  <= i2c_data_clk;
-- DIFFIO_B3N  <= debug_output(0);
-- DIFFIO_B16N <= debug_output(1);
-- DIFFIO_B12P <= debug_output(2);
-- DIFFIO_B12N <= debug_output(3);
-- DIFFIO_B7P  <= debug_output(4); 
DIFFIO_B7N  <= CLOCK;
DIFFIO_B16P <= rj45_sdo_r;


-- DIFFIO_R14P_CLK2P <= i2c_data_clk;
-- DIFFIO_R14N_CLK2N <= i2c_data_clk;
-- DIFFIO_R16P_CLK3P <= i2c_data_clk;
-- DIFFIO_R16N_CLK3N <= i2c_data_clk;
 
end;














































