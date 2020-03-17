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
library work;
use work.i2c.all;

entity MAX10_system is
	port
	(
		CLK_50 : in std_logic;
		RESET_N : in std_logic;
    
    -- RJ45 LED Mapping
    LED_GREEN   : out std_logic;
    LED_YELLOW  : out std_logic;
    
    -- I2C Pin Mapping
    I2C_SDA     : inout std_logic;
    I2C_SCL     : inout std_logic;
    
    -- RJ45 Pin Mapping
    RJ45_SDO    : out std_logic;
		RJ45_SDI    : in std_logic;
		RJ45_SCK    : in std_logic;
    
    -- Microphone Pin Mapping
    MICROPHONE_CLK : out std_logic_vector(3 downto 0);
    MICROPHONE_SDI  : in std_logic_vector(15 downto 0);
    MICROPHONE_WS   : out std_logic_vector(15 downto 0)
	);

end MAX10_system;

architecture ppl_type of MAX10_system is

component cx_system is
  port (
    clk_clk                                  : in  std_logic                     := 'X';             -- clk
    i2c_clk_clk                              : out std_logic;                                        -- clk
    led_output_led_sd                        : out std_logic;                                        -- led_sd
    led_output_led_ws                        : out std_logic;                                        -- led_ws
    pll_mclk_clk                             : out std_logic;                                        -- clk
    reset_reset_n                            : in  std_logic                     := 'X';             -- reset_n
    serial_clk_clk                           : in  std_logic                     := 'X';             -- serial_clk_in
    rj45_interface_serial_data_in            : in  std_logic                     := 'X';             -- serial_data_in
    rj45_interface_serial_data_out           : out std_logic;                                        -- serial_data_out
    control_conduit_busy_out                 : out std_logic;                                        -- busy_out
    fpga_rj45_interface_serial_data_in       : in  std_logic                     := 'X';             -- serial_data_in
    fpga_rj45_interface_serial_data_out      : out std_logic;                                        -- serial_data_out
    fpga_rj45_interface_serial_clk_out       : out std_logic;                                        -- serial_clk_out
    fpga_control_conduit_busy_out            : out std_logic;                                        -- busy_out
    cfg_input_data                           : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    cfg_input_error                          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    cfg_input_valid                          : in  std_logic                     := 'X';             -- valid
    rgb_input_data                           : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    rgb_input_error                          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    rgb_input_valid                          : in  std_logic                     := 'X';             -- valid
    fpga_serial_clk_clk                      : in  std_logic                     := 'X';             -- clk
    bme_output_data                          : out std_logic_vector(63 downto 0);                    -- data
    bme_output_error                         : out std_logic_vector(1 downto 0);                     -- error
    bme_output_valid                         : out std_logic;                                        -- valid
    ics52000_physical_mic_data_in            : in  std_logic_vector(15 downto 0) := (others => 'X'); -- mic_data_in
    ics52000_physical_mic_ws_out             : out std_logic_vector(15 downto 0);                    -- mic_ws_out
    ics52000_physical_clk                    : out std_logic_vector(3 downto 0);                      -- clk
    --ics52000_physical_mics_rdy               : out std_logic;
    fe_ics52000_0_cfg_input_data             : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    fe_ics52000_0_cfg_input_error            : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    fe_ics52000_0_cfg_input_valid            : in  std_logic                     := 'X';            -- valid
    ics52000_mic_output_channel              : out std_logic_vector(5 downto 0);                     -- channel
    ics52000_mic_output_data                 : out std_logic_vector(31 downto 0);                    -- data
    ics52000_mic_output_error                : out std_logic_vector(1 downto 0);                     -- error
    ics52000_mic_output_valid                : out std_logic;                                        -- valid
    mic_input_data                           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- data
    mic_input_channel                        : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- channel
    mic_input_error                          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    mic_input_valid                          : in  std_logic                     := 'X';              -- valid
	  bme280_i2c_0_control_conduit_busy_out    : out std_logic;                                        -- busy_out
	  bme280_i2c_0_control_conduit_continuous  : in  std_logic                     := 'X';             -- continuous
	  bme280_i2c_0_control_conduit_enable      : in  std_logic                     := 'X';             -- enable
	  bme280_i2c_0_i2c_interface_i2c_ack_error : in  std_logic                     := 'X';             -- i2c_ack_error
	  bme280_i2c_0_i2c_interface_i2c_addr      : out std_logic_vector(6 downto 0);                     -- i2c_addr
	  bme280_i2c_0_i2c_interface_i2c_busy      : in  std_logic                     := 'X';             -- i2c_busy
	  bme280_i2c_0_i2c_interface_i2c_data_rd   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- i2c_data_rd
	  bme280_i2c_0_i2c_interface_i2c_data_wr   : out std_logic_vector(7 downto 0);                     -- i2c_data_wr
	  bme280_i2c_0_i2c_interface_i2c_ena       : out std_logic;                                        -- i2c_ena
	  bme280_i2c_0_i2c_interface_i2c_rw        : out std_logic;                                       -- i2c_rw
    ncp5623b_rgb_input_data                  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    ncp5623b_rgb_input_error                 : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    ncp5623b_rgb_input_valid                 : in  std_logic                     := 'X';             -- valid
    ncp5623b_i2c_conduit_i2c_enable_out      : out std_logic;                                        -- i2c_enable_out
    ncp5623b_i2c_conduit_i2c_address_out     : out std_logic_vector(6 downto 0);                     -- i2c_address_out
    ncp5623b_i2c_conduit_i2c_rdwr_out        : out std_logic;                                        -- i2c_rdwr_out
    ncp5623b_i2c_conduit_i2c_data_write_out  : out std_logic_vector(7 downto 0);                     -- i2c_data_write_out
    ncp5623b_i2c_conduit_i2c_bsy_in          : in  std_logic                     := 'X';             -- i2c_bsy_in
    ncp5623b_i2c_conduit_i2c_data_read_in    : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- i2c_data_read_in
    ncp5623b_i2c_conduit_i2c_req_out         : out std_logic;                                        -- i2c_req_out
    ncp5623b_i2c_conduit_i2c_rdy_in          : in  std_logic                     := 'X'              -- i2c_rdy_in

  );
end component cx_system;
  
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

  

  component FE_Streaming_Counter is
  generic ( 
      n_channels    : integer := 8;
      channel_width : integer := 8;
      data_width    : integer := 24
    );
    port (
      sys_clk               : in  std_logic                     := '0';
      reset_n               : in  std_logic                     := '0';
      
      data_output_channel   : out  std_logic_vector(channel_width-1 downto 0)  := (others => '0');
      data_output_data      : out  std_logic_vector(data_width-1 downto 0) := (others => '0');
      data_output_error     : out  std_logic_vector(1 downto 0)  := (others => '0');
      data_output_valid     : out  std_logic                     := '0'
    );
  end component;
  
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
  
  signal clk50                : std_logic := '0';
  signal mclk_clk             : std_logic := '0';
  signal serial_control       : std_logic := '0';
  signal serial_clk           : std_logic := '0';
  signal serial_data          : std_logic := '0';
  signal bclk_out             : std_logic := '0';
  signal lrclk_out            : std_logic := '0';
  signal sdata_out            : std_logic := '0';
  signal altpll_0_locked      : std_logic := '0'; 
  signal rj45_sdo_r           : std_logic := '0';
  signal rj45_sdi_r           : std_logic := '0';
        
  -- I2C logic signals    
  signal i2c_enable           : std_logic;
--  signal i2c_address          : std_logic_vector(6 downto 0) := "0111000";
  signal i2c_address          : std_logic_vector(6 downto 0) := "1000000";
  signal i2c_rdwr             : std_logic;
  signal i2c_data_write       : std_logic_vector(7 downto 0) := (others => '0');
  signal i2c_bsy              : std_logic;
  signal i2c_data_read        : std_logic_vector(7 downto 0) := (others => '0');
  signal i2c_data_clk         : std_logic;
  signal i2c_err              : std_logic;
  
  signal rgb_req              : std_logic;
  signal rgb_en               : std_logic;
          
  signal delay_counter        : unsigned(31 downto 0) := (others => '0');
  signal delay_value          : unsigned(31 downto 0) := x"02FAF080";
        
  signal MAX_OUTPUT           : std_logic_vector(4 downto 0) := "01111";
        
  signal ILED_OUTPUT          : std_logic_vector(2 downto 0) := "001";
  signal PWM1                 : std_logic_vector(2 downto 0) := "010";
  signal PWM2                 : std_logic_vector(2 downto 0) := "011";
  signal PWM3                 : std_logic_vector(2 downto 0) := "100";
        
  signal PWM1_COLOR           : std_logic_vector(4 downto 0) := "00000";
  signal PWM2_COLOR           : std_logic_vector(4 downto 0) := "00000";
  signal PWM3_COLOR           : std_logic_vector(4 downto 0) := "00000";
        
  signal i2c_write            : std_logic := '0';
  signal first_byte           : std_logic_vector(7 downto 0) := (others => '0');
  signal second_byte          : std_logic_vector(7 downto 0) := (others => '0');
  signal write_two            : std_logic := '0';
  signal second_byte_loaded   : std_logic := '0';
   
  
    
  type i2c_state is ( idle,load_first_byte,load_second_byte,
                      tx_wait,i2c_busy_wait, init_device,
                      load_r, load_g, load_b); 
  signal cur_i2c_state : i2c_state := init_device;
  signal next_i2c_state : i2c_state := idle;
  
  signal bme_data : std_logic_vector(63 downto 0) := (others => '0');
  signal bme_valid : std_logic := '0';
  signal bme_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal bme_out_data : std_logic_vector(63 downto 0) := (others => '0');
  signal bme_out_valid : std_logic := '0';
  signal bme_out_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal cfg_data : std_logic_vector(15 downto 0) := (others => '1');
  signal cfg_valid : std_logic := '0';
  signal cfg_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal rgb_data : std_logic_vector(15 downto 0) := (others => '0');
  signal rgb_valid : std_logic := '0';
  signal rgb_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal mic_data : std_logic_vector(31 downto 0) := (others => '0');
  signal mic_valid : std_logic := '0';
  signal mic_error : std_logic_vector(1 downto 0) := (others => '0');
  signal mic_channel : std_logic_vector(4 downto 0) := (others => '0');
  
  signal ics52000_mic_data : std_logic_vector(31 downto 0) := (others => '0');
  signal ics52000_mic_valid : std_logic := '0';
  signal ics52000_mic_error : std_logic_vector(1 downto 0) := (others => '0');
  signal ics52000_mic_channel : std_logic_vector(5 downto 0) := (others => '0');
  
  signal mic_out_data : std_logic_vector(31 downto 0) := (others => '0');
  signal mic_out_valid : std_logic := '0';
  signal mic_out_error : std_logic_vector(1 downto 0) := (others => '0');
  signal mic_out_channel : std_logic_vector(3 downto 0) := (others => '0');
  
  signal debug_output : std_logic_vector(7 downto 0) := (others => '0');
  
  signal mic_data_in : std_logic_vector(15 downto 0) := (others => '0');
  signal mic_ws_out  : std_logic_vector(15 downto 0) := (others => '0');
  signal mic_clk_out : std_logic_vector(3 downto 0) := (others => '0');
  signal mics_rdy     : std_logic := '0';
  
  signal bme_enable     : std_logic := '1';
  signal bme_continuous : std_logic := '1';
  signal bme_busy       : std_logic := '1';
  
  signal i2c_control : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'), data_rd => (others => '0'), busy => '0');
  signal bme_i2c : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'), data_rd => (others => '0'), busy => '0');
  signal rgb_i2c : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'), data_rd => (others => '0'), busy => '0');
  
begin

pd : cx_system
  port map (
    clk_clk                             => CLK_50,
    reset_reset_n                       => RESET_N,
    i2c_clk_clk                         => i2c_data_clk,              --                 i2c_clk.clk
    led_output_led_sd                   => open,                      --              led_output.led_sd
    led_output_led_ws                   => open,                      --                        .led_ws
            
    pll_mclk_clk                        => open,
    serial_clk_clk                      => serial_clk,                --          rj45_interface.serial_clk_in
    rj45_interface_serial_data_in       => rj45_sdo_r,                --                        .serial_data_in
    rj45_interface_serial_data_out      => rj45_sdi_r,                --                        .serial_data_out
    control_conduit_busy_out            => open,                                        -- busy_out
    fpga_rj45_interface_serial_data_in  => rj45_sdi_r,                --     fpga_rj45_interface.serial_data_in
    fpga_rj45_interface_serial_data_out => rj45_sdo_r,                --                        .serial_data_out
    fpga_rj45_interface_serial_clk_out  => serial_clk,                --                        .serial_clk_out
    fpga_control_conduit_busy_out       => open,       --    fpga_control_conduit.busy_out
    cfg_input_data                      => x"FFFF",                         --               cfg_input.data
    cfg_input_error                     => open,                        --                        .error
    cfg_input_valid                     => cfg_valid,                        --                        .valid
    rgb_input_data                      => rgb_data,                         --               rgb_input.data
    rgb_input_error                     => rgb_error,                        --                        .error
    rgb_input_valid                     => rgb_valid,                        --                        .valid
    fpga_serial_clk_clk                 => i2c_data_clk,                     --         fpga_serial_clk.clk
    bme_output_data                     => bme_out_data,                     --              bme_output.data
    bme_output_error                    => bme_out_error,                    --                        .error
    bme_output_valid                    => bme_out_valid,                    --                        .valid
    ics52000_physical_mic_data_in       => mic_data_in,       --       ics52000_physical.mic_data_in
    ics52000_physical_mic_ws_out        => mic_ws_out,        --                        .mic_ws_out
    ics52000_physical_clk               => mic_clk_out,                --                        .clk
    --ics52000_physical_mics_rdy          => mics_rdy,
    fe_ics52000_0_cfg_input_data        => x"FFFF",        -- fe_ics52000_0_cfg_input.data
    fe_ics52000_0_cfg_input_error       => cfg_error,       --                        .error
    fe_ics52000_0_cfg_input_valid       => cfg_valid,       --                        .valid
    ics52000_mic_output_channel         => ics52000_mic_channel,         --     ocs52000_mic_output.channel
    ics52000_mic_output_data            => ics52000_mic_data,            --                        .data
    ics52000_mic_output_error           => ics52000_mic_error,           --                        .error
    ics52000_mic_output_valid           => ics52000_mic_valid,           --                        .valid
    mic_input_data                      => ics52000_mic_data,                      --               mic_input.data
    mic_input_channel                   => ics52000_mic_channel(4 downto 0),                   --                        .channel
    mic_input_error                     => ics52000_mic_error,                     --                        .error
    mic_input_valid                     => ics52000_mic_valid,                      --                        .valid
	  bme280_i2c_0_control_conduit_busy_out    => bme_busy,    -- bme280_i2c_0_control_conduit.busy_out
	  bme280_i2c_0_control_conduit_continuous  => bme_continuous,  --                             .continuous
	  bme280_i2c_0_control_conduit_enable      => bme_enable,      --                             .enable
	  bme280_i2c_0_i2c_interface_i2c_ack_error => i2c_err, --   bme280_i2c_0_i2c_interface.i2c_ack_error
	  bme280_i2c_0_i2c_interface_i2c_addr      => bme_i2c.addr,      --                             .i2c_addr
	  bme280_i2c_0_i2c_interface_i2c_busy      => bme_i2c.busy,      --                             .i2c_busy
	  bme280_i2c_0_i2c_interface_i2c_data_rd   => bme_i2c.data_rd,   --                             .i2c_data_rd
	  bme280_i2c_0_i2c_interface_i2c_data_wr   => bme_i2c.data_wr,   --                             .i2c_data_wr
	  bme280_i2c_0_i2c_interface_i2c_ena       => bme_i2c.ena,       --                             .i2c_ena
	  bme280_i2c_0_i2c_interface_i2c_rw        => bme_i2c.rw,       --                             .i2c_rw
    ncp5623b_rgb_input_data                  => rgb_data,                  --           ncp5623b_rgb_input.data
    ncp5623b_rgb_input_error                 => rgb_error,                 --                             .error
    ncp5623b_rgb_input_valid                 => rgb_valid,                 --                             .valid
    ncp5623b_i2c_conduit_i2c_enable_out      => rgb_i2c.ena,      --         ncp5623b_i2c_conduit.i2c_enable_out
    ncp5623b_i2c_conduit_i2c_address_out     => rgb_i2c.addr,     --                             .i2c_address_out
    ncp5623b_i2c_conduit_i2c_rdwr_out        => rgb_i2c.rw,        --                             .i2c_rdwr_out
    ncp5623b_i2c_conduit_i2c_data_write_out  => rgb_i2c.data_wr,  --                             .i2c_data_write_out
    ncp5623b_i2c_conduit_i2c_bsy_in          => rgb_i2c.busy,          --                             .i2c_bsy_in
    ncp5623b_i2c_conduit_i2c_data_read_in    => rgb_i2c.data_rd,    --                             .i2c_data_read_in
    ncp5623b_i2c_conduit_i2c_req_out         => rgb_req,         --                             .i2c_req_out
    ncp5623b_i2c_conduit_i2c_rdy_in          => rgb_en           --                             .i2c_rdy_in
  );

cfg_counter:  FE_Streaming_Counter
generic map ( 
  n_channels    => 1,
  channel_width => 1,
  data_width    => 16
)
port map (
  sys_clk               => CLK_50,
  reset_n               => RESET_N,
  
  data_output_channel  => open,
  data_output_data     => cfg_data,
  data_output_error    => cfg_error,
  data_output_valid    => cfg_valid
);

bme_counter:  FE_Streaming_Counter
generic map ( 
  n_channels    => 1,
  channel_width => 1,
  data_width    => 64
)
port map (
  sys_clk               => CLK_50,
  reset_n               => RESET_N,
  
  data_output_channel  => open,
  data_output_data     => bme_data,
  data_output_error    => bme_error,
  data_output_valid    => bme_valid
);

mic_counter:  FE_Streaming_Counter
generic map ( 
  n_channels    => 16,
  channel_width => 5,
  data_width    => 24
)
port map (
  sys_clk               => CLK_50,
  reset_n               => RESET_N,
  
  data_output_channel  => mic_channel,
  data_output_data     => mic_data(23 downto 0),
  data_output_error    => mic_error,
  data_output_valid    => mic_valid
);

i2c_component : i2c_master 
 port map(
   clk       => CLK_50,
   reset_n   => RESET_N,
   ena       => i2c_control.ena,
   addr      => i2c_control.addr,
   rw        => i2c_control.rw,
   data_wr   => i2c_control.data_wr,
   busy      => i2c_control.busy,
   data_rd   => i2c_control.data_rd,
   ack_error => i2c_err,
   sda       => I2C_SDA,
   scl       => I2C_SCL
);  

  i2c_control_p : process(CLK_50)
  begin
	if rising_edge(CLK_50) then
	  if bme_busy = '1' then
	  	i2c_control <= bme_i2c;
      rgb_en <= '0';
	  else 
	  	i2c_control <= rgb_i2c;
      rgb_en <= '1';
	  end if;
	end if;
  end process;

  -- Process to start the data transmission after X clock cycles
  counter_process: process(CLK_50,RESET_N)
  begin
    if RESET_N = '0' then 
      delay_counter   <= (others => '0');
    elsif rising_edge(CLK_50) then 

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

  color_change: process(CLK_50,RESET_N)
  begin
    if RESET_N = '0' then 
      PWM1_COLOR <= "00000";
      PWM2_COLOR <= "00010";
      PWM3_COLOR <= "00100";
    elsif rising_edge(CLK_50) then 
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
  
-- Map the RJ45 signals
-- RJ45_SDI  <= rj45_sdo_r; -- CPLD SDI
-- RJ45_SCK  <= serial_clk; -- CPLD SCK
RJ45_SDO    <= rj45_sdi_r; -- CPLD SDO

-- Map the microphone CLK_50s
MICROPHONE_CLK <= mic_clk_out;

-- Map the microphone data lines
mic_data_in <= MICROPHONE_SDI;

-- Map the microphone word select lines
MICROPHONE_WS  <= mic_ws_out;
 
end;














































