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

		BME280_SDA : inout std_logic;
		Arduino_IO9 : in std_logic;
		Arduino_IO10 : in std_logic;
		BME280_SCL : inout std_logic;
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
		DIFFIO_B3N : inout std_logic;
		DIFFIO_B3P : inout std_logic;
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
			altpll_0_locked_conduit_export                  : out std_logic;                                        -- export
			bme280_i2c_0_bme_output_data                    : out std_logic_vector(95 downto 0);                    -- data
			bme280_i2c_0_bme_output_error                   : out std_logic_vector(1 downto 0);                     -- error
			bme280_i2c_0_bme_output_valid                   : out std_logic;                                        -- valid
			bme280_i2c_0_control_conduit_busy_out           : out std_logic;                                        -- busy_out
			bme280_i2c_0_control_conduit_continuous         : in  std_logic                     := 'X';             -- continuous
			bme280_i2c_0_control_conduit_enable             : in  std_logic                     := 'X';             -- enable
			bme280_i2c_0_i2c_interface_i2c_ack_error        : in  std_logic                     := 'X';             -- i2c_ack_error
			bme280_i2c_0_i2c_interface_i2c_addr             : out std_logic_vector(6 downto 0);                     -- i2c_addr
			bme280_i2c_0_i2c_interface_i2c_busy             : in  std_logic                     := 'X';             -- i2c_busy
			bme280_i2c_0_i2c_interface_i2c_data_rd          : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- i2c_data_rd
			bme280_i2c_0_i2c_interface_i2c_data_wr          : out std_logic_vector(7 downto 0);                     -- i2c_data_wr
			bme280_i2c_0_i2c_interface_i2c_ena              : out std_logic;                                        -- i2c_ena
			bme280_i2c_0_i2c_interface_writeresponsevalid_n : out std_logic;                                        -- writeresponsevalid_n
			clk_clk                                         : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                   : in  std_logic                     := 'X'              -- reset_n
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

component i2c_master IS
  GENERIC(
    input_clk : INTEGER := 50_000_000;  --input clock speed from user logic in Hz
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
END component;

  
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
  signal i2c_enable : std_logic := '1';
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
  
  signal bme_data : std_logic_vector(95 downto 0) := (others => '0');
  signal bme_valid : std_logic := '0';
  signal bme_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal mic_data : std_logic_vector(31 downto 0) := (others => '0');
  signal mic_valid : std_logic := '0';
  signal mic_error : std_logic_vector(1 downto 0) := (others => '0');
  signal mic_channel : std_logic_vector(4 downto 0) := (others => '0');
  
  signal debug_output : std_logic_vector(7 downto 0) := (others => '0');
  signal u0_ena       : std_logic := '1';
  signal write_i2c : i2c_rec ;--:= (ena => '1', addr => BME320_I2C_ADDR, rw => '0', data_wr => START_ADDR);
  
  signal i2c_control : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'));
--  signal i2c_data    : i2c_data_rec := ('1', data_rd => (others => '0'), ack_error => '0');
  signal test : std_logic_vector(16 downto 0);
  signal i2c_busy : std_logic;
  signal i2c_data_rd : std_logic_vector(7 downto 0);
  signal i2c_ack_error : std_logic;

begin
--
--	u0 : component cx_system
--		port map (
--			bme280_i2c_0_bme_output_data            => bme_data,            --      bme280_i2c_0_bme_output.data
--			bme280_i2c_0_bme_output_error           => bme_error,           --                             .error
--			bme280_i2c_0_bme_output_valid           => bme_valid,           --                             .valid
--			bme280_i2c_0_control_conduit_busy_out   => i2c_bsy,             -- bme280_i2c_0_control_conduit.busy_out
--			bme280_i2c_0_control_conduit_continuous => i2c_enable,          --                             .continuous
--			bme280_i2c_0_control_conduit_enable     => u0_ena,          --                             .enable
--			bme280_i2c_0_i2c_interface_scl          => BME280_SCL,          --   bme280_i2c_0_i2c_interface.scl
--			bme280_i2c_0_i2c_interface_sda          => BME280_SDA,          --                             .sda
--			clk_clk                                 => CLOCK,               --                          clk.clk
--			reset_reset_n                           => RESET_N              --                        reset.reset_n
--		);

	u0 : component cx_system
			  port map (
					bme280_i2c_0_bme_output_data                    => bme_data,                    --      bme280_i2c_0_bme_output.data
					bme280_i2c_0_bme_output_error                   => bme_error,                   --                             .error
					bme280_i2c_0_bme_output_valid                   => bme_valid,                   --                             .valid
					bme280_i2c_0_control_conduit_busy_out           => i2c_bsy,           -- bme280_i2c_0_control_conduit.busy_out
					bme280_i2c_0_control_conduit_continuous         => i2c_enable,         --                             .continuous
					bme280_i2c_0_control_conduit_enable             => u0_ena,             --                             .enable
					bme280_i2c_0_i2c_interface_i2c_ack_error        => i2c_ack_error,        --   bme280_i2c_0_i2c_interface.i2c_ack_error
					bme280_i2c_0_i2c_interface_i2c_addr             => i2c_control.addr,             --                             .i2c_addr
					bme280_i2c_0_i2c_interface_i2c_busy             => i2c_busy,             --                             .i2c_busy
					bme280_i2c_0_i2c_interface_i2c_data_rd          => i2c_data_rd,          --                             .i2c_data_rd
					bme280_i2c_0_i2c_interface_i2c_data_wr          => i2c_control.data_wr,          --                             .i2c_data_wr
					bme280_i2c_0_i2c_interface_i2c_ena              => i2c_control.ena,  
					bme280_i2c_0_i2c_interface_writeresponsevalid_n => i2c_control.rw,  --                             .writeresponsevalid_n
					clk_clk                                         => CLOCK,                                         --                          clk.clk
					reset_reset_n                                   => RESET_N                                    --                        reset.reset_n
			  );		
		
i2c_component : i2c_master 
--generic map (
--  input_clk => FE_CPLD_BME280_I2C_Reader.input_clk,  
--  bus_clk   => FE_CPLD_BME280_I2C_Reader.bus_clk
--)
port map(
  clk       => CLOCK,
  reset_n   => RESET_N,
  ena       => i2c_control.ena,
  addr      => i2c_control.addr,
  rw        => i2c_control.rw,
  data_wr   => i2c_control.data_wr,
  busy      => i2c_busy,
  data_rd   => i2c_data_rd,
  ack_error => i2c_ack_error,
  sda       => BME280_SDA,
  scl       => BME280_SCL
);

  mic_valid <= not(mic_valid);

  process (CLOCK, u0_ena)
  variable counter : integer := 0;
  begin
  if rising_edge(CLOCK) then
    if u0_ena = '0' then
      u0_ena <= '1';
    end if;
    DIFFIO_B7N <= bme_data(counter);
    counter := counter + 1;
    if counter = 96 then
      counter := 0;
    end if;
  end if;
end process;


--u0_ena <= '1' when u0_ena = '0' else '0';

--DIFFIO_B3P  <= i2c_data_clk;
 --DIFFIO_B3N  <= bme_data(39);
 DIFFIO_B16N <= bme_data(0);
 DIFFIO_B12P <= bme_data(41);
-- DIFFIO_B12N <= debug_output(3);
-- DIFFIO_B7P  <= debug_output(4); 
--DIFFIO_B7N  <= CLOCK;
--DIFFIO_B16P <= rj45_sdo_r;
--  DIFFIO_B16N <= mic_valid;
--  DIFFIO_B12N <= bme_data(25);

-- DIFFIO_R14P_CLK2P <= i2c_data_clk;
-- DIFFIO_R14N_CLK2N <= i2c_data_clk;
-- DIFFIO_R16P_CLK3P <= i2c_data_clk;
-- DIFFIO_R16N_CLK3N <= i2c_data_clk;
 
end;














































