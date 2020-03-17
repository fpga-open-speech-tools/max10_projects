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
    clk_clk                             : in  std_logic                     := 'X';             -- clk
    i2c_clk_clk                         : out std_logic;                                        -- clk
    led_output_led_sd                   : out std_logic;                                        -- led_sd
    led_output_led_ws                   : out std_logic;                                        -- led_ws
    pll_mclk_clk                        : out std_logic;                                        -- clk
    reset_reset_n                       : in  std_logic                     := 'X';             -- reset_n
    serial_clk_clk                      : in  std_logic                     := 'X';             -- serial_clk_in
    rj45_interface_serial_data_in       : in  std_logic                     := 'X';             -- serial_data_in
    rj45_interface_serial_data_out      : out std_logic;                                        -- serial_data_out
    bme_input_data                      : in  std_logic_vector(63 downto 0) := (others => 'X'); -- data
    bme_input_error                     : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    bme_input_valid                     : in  std_logic                     := 'X';             -- valid
    control_conduit_busy_out            : out std_logic;                                        -- busy_out
    fpga_rj45_interface_serial_data_in  : in  std_logic                     := 'X';             -- serial_data_in
    fpga_rj45_interface_serial_data_out : out std_logic;                                        -- serial_data_out
    fpga_rj45_interface_serial_clk_out  : out std_logic;                                        -- serial_clk_out
    fpga_control_conduit_busy_out       : out std_logic;                                        -- busy_out
    cfg_input_data                      : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    cfg_input_error                     : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    cfg_input_valid                     : in  std_logic                     := 'X';             -- valid
    rgb_input_data                      : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    rgb_input_error                     : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    rgb_input_valid                     : in  std_logic                     := 'X';             -- valid
    fpga_serial_clk_clk                 : in  std_logic                     := 'X';             -- clk
    bme_output_data                     : out std_logic_vector(63 downto 0);                    -- data
    bme_output_error                    : out std_logic_vector(1 downto 0);                     -- error
    bme_output_valid                    : out std_logic;                                        -- valid
    ics52000_physical_mic_data_in       : in  std_logic_vector(15 downto 0) := (others => 'X'); -- mic_data_in
    ics52000_physical_mic_ws_out        : out std_logic_vector(15 downto 0);                    -- mic_ws_out
    ics52000_physical_clk               : out std_logic_vector(3 downto 0);                      -- clk
    ics52000_physical_mics_rdy          : out std_logic;
    fe_ics52000_0_cfg_input_data        : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    fe_ics52000_0_cfg_input_error       : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    fe_ics52000_0_cfg_input_valid       : in  std_logic                     := 'X';            -- valid
    ics52000_mic_output_channel         : out std_logic_vector(5 downto 0);                     -- channel
    ics52000_mic_output_data            : out std_logic_vector(31 downto 0);                    -- data
    ics52000_mic_output_error           : out std_logic_vector(1 downto 0);                     -- error
    ics52000_mic_output_valid           : out std_logic;                                        -- valid
    mic_input_data                      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- data
    mic_input_channel                   : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- channel
    mic_input_error                     : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    mic_input_valid                     : in  std_logic                     := 'X'              -- valid
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
    bme_input_data                      => bme_data,                  --               bme_input.data
    bme_input_error                     => bme_error,                 --                        .error
    bme_input_valid                     => bme_valid,                 --                        .valid
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
    ics52000_physical_mics_rdy          => mics_rdy,
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
    mic_input_valid                     => ics52000_mic_valid                      --                        .valid
  );

rgb_counter:  FE_Streaming_Counter
generic map ( 
  n_channels    => 1,
  channel_width => 1,
  data_width    => 16
)
port map (
  sys_clk               => CLK_50,
  reset_n               => RESET_N,
  
  data_output_channel  => open,
  data_output_data     => rgb_data,
  data_output_error    => rgb_error,
  data_output_valid    => rgb_valid
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
   ena       => i2c_enable,
   addr      => i2c_address,
   rw        => i2c_rdwr,
   data_wr   => i2c_data_write,
   busy      => i2c_bsy,
   data_rd   => i2c_data_read,
   ack_error => i2c_err,
   sda       => I2C_SDA,
   scl       => I2C_SCL
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
      end if;

    end if;
  end process;

  i2c_transition_process: process(CLOCK,RESET_N)
  begin
    if RESET_N = '0' then 
      cur_i2c_state <= idle;
    elsif rising_edge(CLOCK) then 
      case cur_i2c_state is

        when init_device =>
          cur_i2c_state <= i2c_busy_wait;

        when idle => 
          if i2c_write = '1' then 
            cur_i2c_state <= load_r;
          end if;

        when load_r =>
            cur_i2c_state <= load_first_byte;

        when load_g =>
            cur_i2c_state <= load_first_byte;

        when load_b =>
            cur_i2c_state <= load_first_byte;

        when load_first_byte =>
          cur_i2c_state <= i2c_busy_wait;

        when i2c_busy_wait =>
          if i2c_bsy = '1' and write_two = '1' and second_byte_loaded = '0' then 
            cur_i2c_state <= load_second_byte;
          elsif i2c_bsy = '1' then 
            cur_i2c_state <= tx_wait;
          else
            cur_i2c_state <= i2c_busy_wait;
          end if;

        when load_second_byte =>
          cur_i2c_state <= tx_wait;

        when tx_wait =>
          if i2c_bsy = '0' and write_two = '0' then 
            second_byte_loaded <= '0';
            cur_i2c_state <= idle;
          elsif i2c_bsy = '0' and second_byte_loaded = '0' then 
            cur_i2c_state <= i2c_busy_wait;
            second_byte_loaded <= '1';
          elsif i2c_bsy = '0' and second_byte_loaded = '1' then 
            cur_i2c_state <= next_i2c_state;
            --cur_i2c_state <= i2c_hold;
            second_byte_loaded <= '0';
          else 
            cur_i2c_state <= tx_wait;
          end if;

        when others =>

      end case;

    end if;
  end process;

  i2c_logic_process: process(CLOCK,RESET_N)
  begin
    if rising_edge(CLOCK) then 
      case cur_i2c_state is

        when init_device =>
          i2c_rdwr <= '0';
          i2c_enable <= '1';
          i2c_data_write <= ILED_OUTPUT & MAX_OUTPUT;
          second_byte <= ILED_OUTPUT & "11111";
          write_two <= '0';

        when idle => 
          i2c_enable <= '0';

        when load_r =>
          first_byte <= PWM1 & PWM1_COLOR;
          second_byte <= PWM1 & "11111";
          next_i2c_state <= load_g;

        when load_g =>
          first_byte <= PWM2 & PWM2_COLOR;
          second_byte <= PWM2 & "11111";
          next_i2c_state <= load_b;

        when load_b =>
          first_byte <= PWM3 & PWM3_COLOR;
          second_byte <= PWM3 & "11111";
          next_i2c_state <= idle;

        when load_first_byte =>
          i2c_rdwr <= '0';
          i2c_data_write <= first_byte;
          i2c_enable <= '1';
          write_two <= '1';

        when load_second_byte =>
          i2c_data_write <= second_byte;

        when i2c_busy_wait =>

        when tx_wait =>
          if second_byte_loaded = '1' then 
            i2c_enable <= '0';
          elsif write_two = '0' then 
            i2c_enable <= '0';
          else
            i2c_enable <= '1';
          end if;

        when others =>

        end case;

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














































