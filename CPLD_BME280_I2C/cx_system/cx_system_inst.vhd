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

	u0 : component cx_system
		port map (
			altpll_0_locked_conduit_export                  => CONNECTED_TO_altpll_0_locked_conduit_export,                  --      altpll_0_locked_conduit.export
			bme280_i2c_0_bme_output_data                    => CONNECTED_TO_bme280_i2c_0_bme_output_data,                    --      bme280_i2c_0_bme_output.data
			bme280_i2c_0_bme_output_error                   => CONNECTED_TO_bme280_i2c_0_bme_output_error,                   --                             .error
			bme280_i2c_0_bme_output_valid                   => CONNECTED_TO_bme280_i2c_0_bme_output_valid,                   --                             .valid
			bme280_i2c_0_control_conduit_busy_out           => CONNECTED_TO_bme280_i2c_0_control_conduit_busy_out,           -- bme280_i2c_0_control_conduit.busy_out
			bme280_i2c_0_control_conduit_continuous         => CONNECTED_TO_bme280_i2c_0_control_conduit_continuous,         --                             .continuous
			bme280_i2c_0_control_conduit_enable             => CONNECTED_TO_bme280_i2c_0_control_conduit_enable,             --                             .enable
			bme280_i2c_0_i2c_interface_i2c_ack_error        => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_ack_error,        --   bme280_i2c_0_i2c_interface.i2c_ack_error
			bme280_i2c_0_i2c_interface_i2c_addr             => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_addr,             --                             .i2c_addr
			bme280_i2c_0_i2c_interface_i2c_busy             => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_busy,             --                             .i2c_busy
			bme280_i2c_0_i2c_interface_i2c_data_rd          => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_data_rd,          --                             .i2c_data_rd
			bme280_i2c_0_i2c_interface_i2c_data_wr          => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_data_wr,          --                             .i2c_data_wr
			bme280_i2c_0_i2c_interface_i2c_ena              => CONNECTED_TO_bme280_i2c_0_i2c_interface_i2c_ena,              --                             .i2c_ena
			bme280_i2c_0_i2c_interface_writeresponsevalid_n => CONNECTED_TO_bme280_i2c_0_i2c_interface_writeresponsevalid_n, --                             .writeresponsevalid_n
			clk_clk                                         => CONNECTED_TO_clk_clk,                                         --                          clk.clk
			reset_reset_n                                   => CONNECTED_TO_reset_reset_n                                    --                        reset.reset_n
		);

