
module cx_system (
	altpll_0_locked_conduit_export,
	bme280_i2c_0_control_conduit_busy_out,
	bme280_i2c_0_control_conduit_continuous,
	bme280_i2c_0_control_conduit_enable,
	bme280_i2c_0_i2c_interface_i2c_ack_error,
	bme280_i2c_0_i2c_interface_i2c_addr,
	bme280_i2c_0_i2c_interface_i2c_busy,
	bme280_i2c_0_i2c_interface_i2c_data_rd,
	bme280_i2c_0_i2c_interface_i2c_data_wr,
	bme280_i2c_0_i2c_interface_i2c_ena,
	bme280_i2c_0_i2c_interface_i2c_rw,
	cfg_output_data,
	cfg_output_error,
	cfg_output_valid,
	clk_clk,
	control_conduit_busy_out,
	fe_ics52000_0_cfg_input_data,
	fe_ics52000_0_cfg_input_error,
	fe_ics52000_0_cfg_input_valid,
	i2c_clk_clk,
	ics52000_physical_mic_data_in,
	ics52000_physical_mic_ws_out,
	ics52000_physical_clk,
	ics52000_physical_mics_rdy,
	led_output_led_sd,
	led_output_led_ws,
	ncp5623b_i2c_conduit_i2c_enable_out,
	ncp5623b_i2c_conduit_i2c_address_out,
	ncp5623b_i2c_conduit_i2c_rdwr_out,
	ncp5623b_i2c_conduit_i2c_data_write_out,
	ncp5623b_i2c_conduit_i2c_bsy_in,
	ncp5623b_i2c_conduit_i2c_data_read_in,
	ncp5623b_i2c_conduit_i2c_req_out,
	ncp5623b_i2c_conduit_i2c_rdy_in,
	pll_mclk_clk,
	reset_reset_n,
	rj45_interface_serial_data_in,
	rj45_interface_serial_data_out,
	serial_clk_clk);	

	output		altpll_0_locked_conduit_export;
	output		bme280_i2c_0_control_conduit_busy_out;
	input		bme280_i2c_0_control_conduit_continuous;
	input		bme280_i2c_0_control_conduit_enable;
	input		bme280_i2c_0_i2c_interface_i2c_ack_error;
	output	[6:0]	bme280_i2c_0_i2c_interface_i2c_addr;
	input		bme280_i2c_0_i2c_interface_i2c_busy;
	input	[7:0]	bme280_i2c_0_i2c_interface_i2c_data_rd;
	output	[7:0]	bme280_i2c_0_i2c_interface_i2c_data_wr;
	output		bme280_i2c_0_i2c_interface_i2c_ena;
	output		bme280_i2c_0_i2c_interface_i2c_rw;
	output	[15:0]	cfg_output_data;
	output	[1:0]	cfg_output_error;
	output		cfg_output_valid;
	input		clk_clk;
	output		control_conduit_busy_out;
	input	[15:0]	fe_ics52000_0_cfg_input_data;
	input	[1:0]	fe_ics52000_0_cfg_input_error;
	input		fe_ics52000_0_cfg_input_valid;
	output		i2c_clk_clk;
	input	[15:0]	ics52000_physical_mic_data_in;
	output	[15:0]	ics52000_physical_mic_ws_out;
	output	[3:0]	ics52000_physical_clk;
	output		ics52000_physical_mics_rdy;
	output		led_output_led_sd;
	output		led_output_led_ws;
	output		ncp5623b_i2c_conduit_i2c_enable_out;
	output	[6:0]	ncp5623b_i2c_conduit_i2c_address_out;
	output		ncp5623b_i2c_conduit_i2c_rdwr_out;
	output	[7:0]	ncp5623b_i2c_conduit_i2c_data_write_out;
	input		ncp5623b_i2c_conduit_i2c_bsy_in;
	input	[7:0]	ncp5623b_i2c_conduit_i2c_data_read_in;
	output		ncp5623b_i2c_conduit_i2c_req_out;
	input		ncp5623b_i2c_conduit_i2c_rdy_in;
	output		pll_mclk_clk;
	input		reset_reset_n;
	input		rj45_interface_serial_data_in;
	output		rj45_interface_serial_data_out;
	input		serial_clk_clk;
endmodule
