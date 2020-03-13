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

  
  signal bme_data : std_logic_vector(95 downto 0) := (others => '0');
  signal bme_valid : std_logic := '0';
  signal bme_error : std_logic_vector(1 downto 0) := (others => '0');
  
  signal debug_output : std_logic_vector(7 downto 0) := (others => '0');
  signal u0_ena       : std_logic := '1';
  
  signal i2c_control : i2c_rec := (ena => '0', addr => (others => '0'), rw => '0', data_wr => (others => '0'));
  signal test : std_logic_vector(16 downto 0);
  signal i2c_busy : std_logic;
  signal i2c_data_rd : std_logic_vector(7 downto 0);
  signal i2c_ack_error : std_logic;

begin

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
					clk_clk                                         => CLK_50,                                         --                          clk.clk
					reset_reset_n                                   => RESET_N                                    --                        reset.reset_n
			  );		
		
i2c_component : i2c_master 
port map(
  clk       => CLK_50,
  reset_n   => RESET_N,
  ena       => i2c_control.ena,
  addr      => i2c_control.addr,
  rw        => i2c_control.rw,
  data_wr   => i2c_control.data_wr,
  busy      => i2c_busy,
  data_rd   => i2c_data_rd,
  ack_error => i2c_ack_error,
  sda       => I2C_SDA,
  scl       => I2C_SCL
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














































