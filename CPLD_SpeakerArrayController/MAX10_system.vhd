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
		DIFFIO_B14N : in std_logic;
		DIFFIO_B14P : in std_logic;
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
   clk       =>  CLOCK,
   reset_n   => RESET_N,
   ena       => i2c_enable,
   addr      => i2c_address,
   rw        => i2c_rdwr,
   data_wr   => i2c_data_write,
   busy      => i2c_bsy,
   data_rd   => i2c_data_read,
   ack_error => i2c_err,
   sda       => Arduino_IO8,
   scl       => Arduino_IO11
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
        if PWM1_COLOR = "11111" then 
          PWM1_COLOR <= "00000";
        else 
          PWM1_COLOR <= std_logic_vector(unsigned(PWM1_COLOR) + 1);
        end if;
        if PWM2_COLOR = "11111" then 
          PWM2_COLOR <= "00000";
        else 
          PWM2_COLOR <= std_logic_vector(unsigned(PWM2_COLOR) + 1);
        end if;
        if PWM3_COLOR = "11111" then 
          PWM3_COLOR <= "00000";
        else 
          PWM3_COLOR <= std_logic_vector(unsigned(PWM3_COLOR) + 1);
        end if;
        
        -- PWM1_COLOR <= (others => '0');
        -- PWM3_COLOR <= (others => '0');
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
          write_two <= '1';
                  
        when idle => 
          i2c_enable <= '0';
          
        when load_r =>
          first_byte <= PWM1 & "11111";
          second_byte <= ILED_OUTPUT & "11111";
          next_i2c_state <= load_g;
        
        when load_g =>
          first_byte <= PWM2 & "11111";
          second_byte <= ILED_OUTPUT & "11111";
          next_i2c_state <= load_b;
          
        when load_b =>
          first_byte <= PWM3 & "11111";
          second_byte <= ILED_OUTPUT & "11111";
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
  
    
end;














































