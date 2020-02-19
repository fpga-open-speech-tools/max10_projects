
module cx_system (
	altpll_0_locked_conduit_export,
	bme_input_data,
	bme_input_error,
	bme_input_valid,
	cfg_output_data,
	cfg_output_error,
	cfg_output_valid,
	clk_clk,
	control_conduit_busy_out,
	debug_out_debug_out,
	i2c_clk_clk,
	led_output_led_sd,
	led_output_led_ws,
	mic_input_data,
	mic_input_channel,
	mic_input_error,
	mic_input_valid,
	pll_mclk_clk,
	reset_reset_n,
	rgb_output_data,
	rgb_output_error,
	rgb_output_valid,
	rj45_interface_serial_data_in,
	rj45_interface_serial_data_out,
	serial_clk_clk);	

	output		altpll_0_locked_conduit_export;
	input	[63:0]	bme_input_data;
	input	[1:0]	bme_input_error;
	input		bme_input_valid;
	output	[63:0]	cfg_output_data;
	output	[1:0]	cfg_output_error;
	output		cfg_output_valid;
	input		clk_clk;
	output		control_conduit_busy_out;
	output	[7:0]	debug_out_debug_out;
	output		i2c_clk_clk;
	output		led_output_led_sd;
	output		led_output_led_ws;
	input	[31:0]	mic_input_data;
	input	[4:0]	mic_input_channel;
	input	[1:0]	mic_input_error;
	input		mic_input_valid;
	output		pll_mclk_clk;
	input		reset_reset_n;
	output	[15:0]	rgb_output_data;
	output	[1:0]	rgb_output_error;
	output		rgb_output_valid;
	input		rj45_interface_serial_data_in;
	output		rj45_interface_serial_data_out;
	input		serial_clk_clk;
endmodule
