	component cx_system is
		port (
			altpll_0_locked_conduit_export           : out std_logic;                                        -- export
			bme280_i2c_0_control_conduit_busy_out    : out std_logic;                                        -- busy_out
			bme280_i2c_0_control_conduit_continuous  : in  std_logic                     := 'X';             -- continuous
			bme280_i2c_0_control_conduit_enable      : in  std_logic                     := 'X';             -- enable
			bme280_i2c_0_i2c_interface_i2c_ack_error : in  std_logic                     := 'X';             -- i2c_ack_error
			bme280_i2c_0_i2c_interface_i2c_addr      : out std_logic_vector(6 downto 0);                     -- i2c_addr
			bme280_i2c_0_i2c_interface_i2c_busy      : in  std_logic                     := 'X';             -- i2c_busy
			bme280_i2c_0_i2c_interface_i2c_data_rd   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- i2c_data_rd
			bme280_i2c_0_i2c_interface_i2c_data_wr   : out std_logic_vector(7 downto 0);                     -- i2c_data_wr
			bme280_i2c_0_i2c_interface_i2c_ena       : out std_logic;                                        -- i2c_ena
			bme280_i2c_0_i2c_interface_i2c_rw        : out std_logic;                                        -- i2c_rw
			bme_output_data                          : out std_logic_vector(63 downto 0);                    -- data
			bme_output_error                         : out std_logic_vector(1 downto 0);                     -- error
			bme_output_valid                         : out std_logic;                                        -- valid
			cfg_input_data                           : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
			cfg_input_error                          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
			cfg_input_valid                          : in  std_logic                     := 'X';             -- valid
			cfg_output_data                          : out std_logic_vector(15 downto 0);                    -- data
			cfg_output_error                         : out std_logic_vector(1 downto 0);                     -- error
			cfg_output_valid                         : out std_logic;                                        -- valid
			clk_clk                                  : in  std_logic                     := 'X';             -- clk
			control_conduit_busy_out                 : out std_logic;                                        -- busy_out
			fe_ics52000_0_cfg_input_data             : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
			fe_ics52000_0_cfg_input_error            : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
			fe_ics52000_0_cfg_input_valid            : in  std_logic                     := 'X';             -- valid
			fpga_control_conduit_busy_out            : out std_logic;                                        -- busy_out
			fpga_rj45_interface_serial_data_in       : in  std_logic                     := 'X';             -- serial_data_in
			fpga_rj45_interface_serial_data_out      : out std_logic;                                        -- serial_data_out
			fpga_rj45_interface_serial_clk_out       : out std_logic;                                        -- serial_clk_out
			fpga_serial_clk_clk                      : in  std_logic                     := 'X';             -- clk
			i2c_clk_clk                              : out std_logic;                                        -- clk
			ics52000_mic_output_channel              : out std_logic_vector(5 downto 0);                     -- channel
			ics52000_mic_output_data                 : out std_logic_vector(31 downto 0);                    -- data
			ics52000_mic_output_error                : out std_logic_vector(1 downto 0);                     -- error
			ics52000_mic_output_valid                : out std_logic;                                        -- valid
			ics52000_physical_mic_data_in            : in  std_logic_vector(15 downto 0) := (others => 'X'); -- mic_data_in
			ics52000_physical_mic_ws_out             : out std_logic_vector(15 downto 0);                    -- mic_ws_out
			ics52000_physical_clk                    : out std_logic_vector(3 downto 0);                     -- clk
			ics52000_physical_mics_rdy               : out std_logic;                                        -- mics_rdy
			led_output_led_sd                        : out std_logic;                                        -- led_sd
			led_output_led_ws                        : out std_logic;                                        -- led_ws
			mic_input_data                           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- data
			mic_input_channel                        : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- channel
			mic_input_error                          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
			mic_input_valid                          : in  std_logic                     := 'X';             -- valid
			mic_output_channel                       : out std_logic_vector(3 downto 0);                     -- channel
			mic_output_data                          : out std_logic_vector(31 downto 0);                    -- data
			mic_output_error                         : out std_logic_vector(1 downto 0);                     -- error
			mic_output_valid                         : out std_logic;                                        -- valid
			pll_mclk_clk                             : out std_logic;                                        -- clk
			reset_reset_n                            : in  std_logic                     := 'X';             -- reset_n
			rgb_input_data                           : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
			rgb_input_error                          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
			rgb_input_valid                          : in  std_logic                     := 'X';             -- valid
			rgb_output_data                          : out std_logic_vector(15 downto 0);                    -- data
			rgb_output_error                         : out std_logic_vector(1 downto 0);                     -- error
			rgb_output_valid                         : out std_logic;                                        -- valid
			rj45_interface_serial_data_in            : in  std_logic                     := 'X';             -- serial_data_in
			rj45_interface_serial_data_out           : out std_logic;                                        -- serial_data_out
			serial_clk_clk                           : in  std_logic                     := 'X';             -- clk
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

	u0 : component cx_system
		port map (
			altpll_0_locked_conduit_export           => CONNECTED_TO_altpll_0_locked_conduit_export,           --      altpll_0_locked_conduit.export
			bme280_i2c_0_control_conduit_busy_out    => CONNECTED_TO_bme280_i2c_0_control_conduit_busy_out,    -- bme280_i2c_0_control_conduit.busy_out
			bme280_i2c_0_control_conduit_continuous  => CONNECTED_TO_bme280_i2c_0_control_conduit_continuous,  --                             .continuous
			bme280_i2c_0_control_conduit_enable      => CONNECTED_TO_bme280_i2c_0_control_conduit_enable,      --                             .enable
			bme280_i2c_0_i2c_interface_i2c_ack_error => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_ack_error, --   bme280_i2c_0_i2c_interface.i2c_ack_error
			bme280_i2c_0_i2c_interface_i2c_addr      => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_addr,      --                             .i2c_addr
			bme280_i2c_0_i2c_interface_i2c_busy      => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_busy,      --                             .i2c_busy
			bme280_i2c_0_i2c_interface_i2c_data_rd   => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_data_rd,   --                             .i2c_data_rd
			bme280_i2c_0_i2c_interface_i2c_data_wr   => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_data_wr,   --                             .i2c_data_wr
			bme280_i2c_0_i2c_interface_i2c_ena       => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_ena,       --                             .i2c_ena
			bme280_i2c_0_i2c_interface_i2c_rw        => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_rw,        --                             .i2c_rw
			bme_output_data                          => CONNECTED_TO_bme_output_data,                          --                   bme_output.data
			bme_output_error                         => CONNECTED_TO_bme_output_error,                         --                             .error
			bme_output_valid                         => CONNECTED_TO_bme_output_valid,                         --                             .valid
			cfg_input_data                           => CONNECTED_TO_cfg_input_data,                           --                    cfg_input.data
			cfg_input_error                          => CONNECTED_TO_cfg_input_error,                          --                             .error
			cfg_input_valid                          => CONNECTED_TO_cfg_input_valid,                          --                             .valid
			cfg_output_data                          => CONNECTED_TO_cfg_output_data,                          --                   cfg_output.data
			cfg_output_error                         => CONNECTED_TO_cfg_output_error,                         --                             .error
			cfg_output_valid                         => CONNECTED_TO_cfg_output_valid,                         --                             .valid
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                          clk.clk
			control_conduit_busy_out                 => CONNECTED_TO_control_conduit_busy_out,                 --              control_conduit.busy_out
			fe_ics52000_0_cfg_input_data             => CONNECTED_TO_fe_ics52000_0_cfg_input_data,             --      fe_ics52000_0_cfg_input.data
			fe_ics52000_0_cfg_input_error            => CONNECTED_TO_fe_ics52000_0_cfg_input_error,            --                             .error
			fe_ics52000_0_cfg_input_valid            => CONNECTED_TO_fe_ics52000_0_cfg_input_valid,            --                             .valid
			fpga_control_conduit_busy_out            => CONNECTED_TO_fpga_control_conduit_busy_out,            --         fpga_control_conduit.busy_out
			fpga_rj45_interface_serial_data_in       => CONNECTED_TO_fpga_rj45_interface_serial_data_in,       --          fpga_rj45_interface.serial_data_in
			fpga_rj45_interface_serial_data_out      => CONNECTED_TO_fpga_rj45_interface_serial_data_out,      --                             .serial_data_out
			fpga_rj45_interface_serial_clk_out       => CONNECTED_TO_fpga_rj45_interface_serial_clk_out,       --                             .serial_clk_out
			fpga_serial_clk_clk                      => CONNECTED_TO_fpga_serial_clk_clk,                      --              fpga_serial_clk.clk
			i2c_clk_clk                              => CONNECTED_TO_i2c_clk_clk,                              --                      i2c_clk.clk
			ics52000_mic_output_channel              => CONNECTED_TO_ics52000_mic_output_channel,              --          ics52000_mic_output.channel
			ics52000_mic_output_data                 => CONNECTED_TO_ics52000_mic_output_data,                 --                             .data
			ics52000_mic_output_error                => CONNECTED_TO_ics52000_mic_output_error,                --                             .error
			ics52000_mic_output_valid                => CONNECTED_TO_ics52000_mic_output_valid,                --                             .valid
			ics52000_physical_mic_data_in            => CONNECTED_TO_ics52000_physical_mic_data_in,            --            ics52000_physical.mic_data_in
			ics52000_physical_mic_ws_out             => CONNECTED_TO_ics52000_physical_mic_ws_out,             --                             .mic_ws_out
			ics52000_physical_clk                    => CONNECTED_TO_ics52000_physical_clk,                    --                             .clk
			ics52000_physical_mics_rdy               => CONNECTED_TO_ics52000_physical_mics_rdy,               --                             .mics_rdy
			led_output_led_sd                        => CONNECTED_TO_led_output_led_sd,                        --                   led_output.led_sd
			led_output_led_ws                        => CONNECTED_TO_led_output_led_ws,                        --                             .led_ws
			mic_input_data                           => CONNECTED_TO_mic_input_data,                           --                    mic_input.data
			mic_input_channel                        => CONNECTED_TO_mic_input_channel,                        --                             .channel
			mic_input_error                          => CONNECTED_TO_mic_input_error,                          --                             .error
			mic_input_valid                          => CONNECTED_TO_mic_input_valid,                          --                             .valid
			mic_output_channel                       => CONNECTED_TO_mic_output_channel,                       --                   mic_output.channel
			mic_output_data                          => CONNECTED_TO_mic_output_data,                          --                             .data
			mic_output_error                         => CONNECTED_TO_mic_output_error,                         --                             .error
			mic_output_valid                         => CONNECTED_TO_mic_output_valid,                         --                             .valid
			pll_mclk_clk                             => CONNECTED_TO_pll_mclk_clk,                             --                     pll_mclk.clk
			reset_reset_n                            => CONNECTED_TO_reset_reset_n,                            --                        reset.reset_n
			rgb_input_data                           => CONNECTED_TO_rgb_input_data,                           --                    rgb_input.data
			rgb_input_error                          => CONNECTED_TO_rgb_input_error,                          --                             .error
			rgb_input_valid                          => CONNECTED_TO_rgb_input_valid,                          --                             .valid
			rgb_output_data                          => CONNECTED_TO_rgb_output_data,                          --                   rgb_output.data
			rgb_output_error                         => CONNECTED_TO_rgb_output_error,                         --                             .error
			rgb_output_valid                         => CONNECTED_TO_rgb_output_valid,                         --                             .valid
			rj45_interface_serial_data_in            => CONNECTED_TO_rj45_interface_serial_data_in,            --               rj45_interface.serial_data_in
			rj45_interface_serial_data_out           => CONNECTED_TO_rj45_interface_serial_data_out,           --                             .serial_data_out
			serial_clk_clk                           => CONNECTED_TO_serial_clk_clk,                           --                   serial_clk.clk
			ncp5623b_rgb_input_data                  => CONNECTED_TO_ncp5623b_rgb_input_data,                  --           ncp5623b_rgb_input.data
			ncp5623b_rgb_input_error                 => CONNECTED_TO_ncp5623b_rgb_input_error,                 --                             .error
			ncp5623b_rgb_input_valid                 => CONNECTED_TO_ncp5623b_rgb_input_valid,                 --                             .valid
			ncp5623b_i2c_conduit_i2c_enable_out      => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_enable_out,      --         ncp5623b_i2c_conduit.i2c_enable_out
			ncp5623b_i2c_conduit_i2c_address_out     => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_address_out,     --                             .i2c_address_out
			ncp5623b_i2c_conduit_i2c_rdwr_out        => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_rdwr_out,        --                             .i2c_rdwr_out
			ncp5623b_i2c_conduit_i2c_data_write_out  => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_data_write_out,  --                             .i2c_data_write_out
			ncp5623b_i2c_conduit_i2c_bsy_in          => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_bsy_in,          --                             .i2c_bsy_in
			ncp5623b_i2c_conduit_i2c_data_read_in    => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_data_read_in,    --                             .i2c_data_read_in
			ncp5623b_i2c_conduit_i2c_req_out         => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_req_out,         --                             .i2c_req_out
			ncp5623b_i2c_conduit_i2c_rdy_in          => CONNECTED_TO_ncp5623b_i2c_conduit_i2c_rdy_in           --                             .i2c_rdy_in
		);

