
module cx_system (
	altpll_0_locked_conduit_export,
	bme_output_data,
	bme_output_error,
	bme_output_valid,
	cfg_input_data,
	cfg_input_error,
	cfg_input_valid,
	cfg_output_data,
	cfg_output_error,
	cfg_output_valid,
	clk_clk,
	control_conduit_busy_out,
	fe_ics52000_0_cfg_input_data,
	fe_ics52000_0_cfg_input_error,
	fe_ics52000_0_cfg_input_valid,
	fpga_control_conduit_busy_out,
	fpga_rj45_interface_serial_data_in,
	fpga_rj45_interface_serial_data_out,
	fpga_rj45_interface_serial_clk_out,
	fpga_serial_clk_clk,
	i2c_clk_clk,
	ics52000_mic_output_channel,
	ics52000_mic_output_data,
	ics52000_mic_output_error,
	ics52000_mic_output_valid,
	ics52000_physical_mic_data_in,
	ics52000_physical_mic_ws_out,
	ics52000_physical_clk,
	led_output_led_sd,
	led_output_led_ws,
	mic_input_data,
	mic_input_channel,
	mic_input_error,
	mic_input_valid,
	mic_output_channel,
	mic_output_data,
	mic_output_error,
	mic_output_valid,
	pll_mclk_clk,
	reset_reset_n,
	rgb_input_data,
	rgb_input_error,
	rgb_input_valid,
	rgb_output_data,
	rgb_output_error,
	rgb_output_valid,
	rj45_interface_serial_data_in,
	rj45_interface_serial_data_out,
	serial_clk_clk,
	bme280_i2c_0_control_conduit_busy_out,
	bme280_i2c_0_control_conduit_continuous,
	bme280_i2c_0_control_conduit_enable,
	bme280_i2c_0_i2c_interface_i2c_ack_error,
	bme280_i2c_0_i2c_interface_i2c_addr,
	bme280_i2c_0_i2c_interface_i2c_busy,
	bme280_i2c_0_i2c_interface_i2c_data_rd,
	bme280_i2c_0_i2c_interface_i2c_data_wr,
	bme280_i2c_0_i2c_interface_i2c_ena,
	bme280_i2c_0_i2c_interface_writeresponsevalid_n);	

	output		altpll_0_locked_conduit_export;
	output	[63:0]	bme_output_data;
	output	[1:0]	bme_output_error;
	output		bme_output_valid;
	input	[15:0]	cfg_input_data;
	input	[1:0]	cfg_input_error;
	input		cfg_input_valid;
	output	[15:0]	cfg_output_data;
	output	[1:0]	cfg_output_error;
	output		cfg_output_valid;
	input		clk_clk;
	output		control_conduit_busy_out;
	input	[15:0]	fe_ics52000_0_cfg_input_data;
	input	[1:0]	fe_ics52000_0_cfg_input_error;
	input		fe_ics52000_0_cfg_input_valid;
	output		fpga_control_conduit_busy_out;
	input		fpga_rj45_interface_serial_data_in;
	output		fpga_rj45_interface_serial_data_out;
	output		fpga_rj45_interface_serial_clk_out;
	input		fpga_serial_clk_clk;
	output		i2c_clk_clk;
	output	[5:0]	ics52000_mic_output_channel;
	output	[31:0]	ics52000_mic_output_data;
	output	[1:0]	ics52000_mic_output_error;
	output		ics52000_mic_output_valid;
	input	[15:0]	ics52000_physical_mic_data_in;
	output	[15:0]	ics52000_physical_mic_ws_out;
	output	[3:0]	ics52000_physical_clk;
	output		led_output_led_sd;
	output		led_output_led_ws;
	input	[31:0]	mic_input_data;
	input	[4:0]	mic_input_channel;
	input	[1:0]	mic_input_error;
	input		mic_input_valid;
	output	[3:0]	mic_output_channel;
	output	[31:0]	mic_output_data;
	output	[1:0]	mic_output_error;
	output		mic_output_valid;
	output		pll_mclk_clk;
	input		reset_reset_n;
	input	[15:0]	rgb_input_data;
	input	[1:0]	rgb_input_error;
	input		rgb_input_valid;
	output	[15:0]	rgb_output_data;
	output	[1:0]	rgb_output_error;
	output		rgb_output_valid;
	input		rj45_interface_serial_data_in;
	output		rj45_interface_serial_data_out;
	input		serial_clk_clk;
	output		bme280_i2c_0_control_conduit_busy_out;
	input		bme280_i2c_0_control_conduit_continuous;
	input		bme280_i2c_0_control_conduit_enable;
	input		bme280_i2c_0_i2c_interface_i2c_ack_error;
	output	[6:0]	bme280_i2c_0_i2c_interface_i2c_addr;
	input		bme280_i2c_0_i2c_interface_i2c_busy;
	input	[7:0]	bme280_i2c_0_i2c_interface_i2c_data_rd;
	output	[7:0]	bme280_i2c_0_i2c_interface_i2c_data_wr;
	output		bme280_i2c_0_i2c_interface_i2c_ena;
	output		bme280_i2c_0_i2c_interface_writeresponsevalid_n;
endmodule
