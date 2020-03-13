	component cx_system is
		port (
			altpll_0_locked_conduit_export          : out   std_logic;                            -- export
			bme280_i2c_0_bme_output_data            : out   std_logic_vector(95 downto 0);        -- data
			bme280_i2c_0_bme_output_error           : out   std_logic_vector(1 downto 0);         -- error
			bme280_i2c_0_bme_output_valid           : out   std_logic;                            -- valid
			bme280_i2c_0_control_conduit_busy_out   : out   std_logic;                            -- busy_out
			bme280_i2c_0_control_conduit_continuous : in    std_logic                     := 'X'; -- continuous
			bme280_i2c_0_control_conduit_enable     : in    std_logic                     := 'X'; -- enable
			bme280_i2c_0_i2c_interface_scl          : inout std_logic                     := 'X'; -- scl
			bme280_i2c_0_i2c_interface_sda          : inout std_logic                     := 'X'; -- sda
			clk_clk                                 : in    std_logic                     := 'X'; -- clk
			reset_reset_n                           : in    std_logic                     := 'X'  -- reset_n
		);
	end component cx_system;

	u0 : component cx_system
		port map (
			altpll_0_locked_conduit_export          => CONNECTED_TO_altpll_0_locked_conduit_export,          --      altpll_0_locked_conduit.export
			bme280_i2c_0_bme_output_data            => CONNECTED_TO_bme280_i2c_0_bme_output_data,            --      bme280_i2c_0_bme_output.data
			bme280_i2c_0_bme_output_error           => CONNECTED_TO_bme280_i2c_0_bme_output_error,           --                             .error
			bme280_i2c_0_bme_output_valid           => CONNECTED_TO_bme280_i2c_0_bme_output_valid,           --                             .valid
			bme280_i2c_0_control_conduit_busy_out   => CONNECTED_TO_bme280_i2c_0_control_conduit_busy_out,   -- bme280_i2c_0_control_conduit.busy_out
			bme280_i2c_0_control_conduit_continuous => CONNECTED_TO_bme280_i2c_0_control_conduit_continuous, --                             .continuous
			bme280_i2c_0_control_conduit_enable     => CONNECTED_TO_bme280_i2c_0_control_conduit_enable,     --                             .enable
			bme280_i2c_0_i2c_interface_scl          => CONNECTED_TO_bme280_i2c_0_i2c_interface_scl,          --   bme280_i2c_0_i2c_interface.scl
			bme280_i2c_0_i2c_interface_sda          => CONNECTED_TO_bme280_i2c_0_i2c_interface_sda,          --                             .sda
			clk_clk                                 => CONNECTED_TO_clk_clk,                                 --                          clk.clk
			reset_reset_n                           => CONNECTED_TO_reset_reset_n                            --                        reset.reset_n
		);

