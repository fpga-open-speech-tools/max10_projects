----------------------------------------------------------------------------
--! @file MAX10_system.vhd
--! @brief MAX10 top level design
--! @details This is the top level entity for the microphone arrays.  It records data from the microphones as well as 
--!          the temperature and humidity sensor and passes it over an RJ45 interface.
--! @author Tyler Davis
--! @date 2020
--! @copyright Copyright 2020 Flat Earth Inc
--
--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  IN the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is furnished
--  to do so, subject to the following conditions:
--
--  The above copyright notice and this permission notice shall be included IN all
--  copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
--  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
--  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
--  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
--  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- Tyler Davis
-- Flat Earth Inc
-- 985 Technology Blvd
-- Bozeman, MT 59718
-- support@flatearthinc.com
----------------------------------------------------------------------------
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
    MICROPHONE_CLK  : out std_logic_vector(3 downto 0);
    MICROPHONE_SDI  : in  std_logic_vector(15 downto 0);
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
    ics52000_physical_mic_data_in            : in  std_logic_vector(15 downto 0) := (others => 'X'); -- mic_data_in
    ics52000_physical_mic_ws_out             : out std_logic_vector(15 downto 0);                    -- mic_ws_out
    ics52000_physical_clk                    : out std_logic_vector(3 downto 0);                      -- clk
    fe_ics52000_0_cfg_input_data             : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
    fe_ics52000_0_cfg_input_error            : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
    fe_ics52000_0_cfg_input_valid            : in  std_logic                     := 'X';            -- valid
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
    bus_clk   : INTEGER := 400_000);   --speed the i2c bus (scl) will run at in Hz
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

signal bme_data : std_logic_vector(95 downto 0) := (others => '0');
signal bme_valid : std_logic := '0';
signal bme_error : std_logic_vector(1 downto 0) := (others => '0');

signal bme_out_data : std_logic_vector(95 downto 0) := (others => '0');
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

signal i2c_control  : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'));
signal bme_i2c      : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'));
signal rgb_i2c      : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'));

begin

pd : cx_system
  port map (
    clk_clk                                   => CLK_50,
    reset_reset_n                             => RESET_N,
    i2c_clk_clk                               => i2c_data_clk,              --                 i2c_clk.clk
    led_output_led_sd                         => open,                      --              led_output.led_sd
    led_output_led_ws                         => open,                      --                        .led_ws
                                              
    pll_mclk_clk                              => open,
    serial_clk_clk                            => serial_clk,                --          rj45_interface.serial_clk_in
    rj45_interface_serial_data_in             => rj45_sdi_r,                --                        .serial_data_in
    rj45_interface_serial_data_out            => rj45_sdo_r,                --                        .serial_data_out
    control_conduit_busy_out                  => open,                                        -- busy_out
                                              
    ics52000_physical_mic_data_in             => mic_data_in,       --       ics52000_physical.mic_data_in
    ics52000_physical_mic_ws_out              => mic_ws_out,        --                        .mic_ws_out
    ics52000_physical_clk                     => mic_clk_out,                --                        .clk
   
    bme280_i2c_0_control_conduit_busy_out     => bme_busy,    -- bme280_i2c_0_control_conduit.busy_out
	  bme280_i2c_0_control_conduit_continuous   => bme_continuous,  --                             .continuous
	  bme280_i2c_0_control_conduit_enable       => bme_enable,      --                             .enable
      
    bme280_i2c_0_i2c_interface_i2c_ack_error  => i2c_err, --   bme280_i2c_0_i2c_interface.i2c_ack_error
	  bme280_i2c_0_i2c_interface_i2c_addr       => bme_i2c.addr,      --                             .i2c_addr
	  bme280_i2c_0_i2c_interface_i2c_busy       => i2c_bsy,      --                             .i2c_busy
	  bme280_i2c_0_i2c_interface_i2c_data_rd    => i2c_data_read,   --                             .i2c_data_rd
	  bme280_i2c_0_i2c_interface_i2c_data_wr    => bme_i2c.data_wr,   --                             .i2c_data_wr
	  bme280_i2c_0_i2c_interface_i2c_ena        => bme_i2c.ena,       --                             .i2c_ena
	  bme280_i2c_0_i2c_interface_i2c_rw         => bme_i2c.rw,       --                             .i2c_rw
  
    ncp5623b_i2c_conduit_i2c_enable_out       => rgb_i2c.ena,      --         ncp5623b_i2c_conduit.i2c_enable_out
    ncp5623b_i2c_conduit_i2c_address_out      => rgb_i2c.addr,     --                             .i2c_address_out
    ncp5623b_i2c_conduit_i2c_rdwr_out         => rgb_i2c.rw,        --                             .i2c_rdwr_out
    ncp5623b_i2c_conduit_i2c_data_write_out   => rgb_i2c.data_wr,  --                             .i2c_data_write_out
    ncp5623b_i2c_conduit_i2c_bsy_in           => i2c_bsy,          --                             .i2c_bsy_in
    ncp5623b_i2c_conduit_i2c_data_read_in     => open,    --                             .i2c_data_read_in
    ncp5623b_i2c_conduit_i2c_req_out          => rgb_req,         --                             .i2c_req_out
    ncp5623b_i2c_conduit_i2c_rdy_in           => rgb_en           --                             .i2c_rdy_in
  );


i2c_component : i2c_master 
 port map(
   clk       => CLK_50,
   reset_n   => RESET_N,
   ena       => i2c_control.ena,
   addr      => i2c_control.addr,
   rw        => i2c_control.rw,
   data_wr   => i2c_control.data_wr,
   busy      => i2c_bsy,
   data_rd   => i2c_data_read,
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
      LED_GREEN <= '1';
      LED_YELLOW <= '0';
	  else 
	  	i2c_control <= rgb_i2c;
      rgb_en <= '1';
      LED_GREEN <= '1';
      LED_YELLOW <= '0';
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
rj45_sdi_r <= RJ45_SDI; -- CPLD SDI
serial_clk <= RJ45_SCK; -- CPLD SCK
RJ45_SDO   <= rj45_sdo_r; -- CPLD SDO

-- Map the microphone CLK_50s
MICROPHONE_CLK <= mic_clk_out;

-- Map the microphone data lines
mic_data_in <= MICROPHONE_SDI;

-- Map the microphone word select lines
MICROPHONE_WS  <= mic_ws_out;
 


end;














































