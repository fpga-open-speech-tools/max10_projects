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
library altera;
use altera.altera_syn_attributes.all;

entity MAX10_system is
	port
	(
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
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

		Arduino_IO8 : in std_logic;
		Arduino_IO9 : in std_logic;
		Arduino_IO10 : in std_logic;
		Arduino_IO11 : in std_logic;
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
		DIFFIO_B3N : in std_logic;
		DIFFIO_B3P : in std_logic;
		DIFFIO_B5N : in std_logic;
		DIFFIO_B5P : in std_logic;
		DIFFIO_B7N : in std_logic;
		DIFFIO_B7P : in std_logic;
		DIFFIO_B9N : in std_logic;
		DIFFIO_B9P : in std_logic;
		DIFFIO_B12N : in std_logic;
		DIFFIO_B12P : in std_logic;
		DIFFIO_B14N : in std_logic;
		DIFFIO_B14P : in std_logic;
		DIFFIO_B16N : in std_logic;
		DIFFIO_B16P : in std_logic;
		DIFFIO_R14P_CLK2P : in std_logic;
		DIFFIO_R14N_CLK2N : in std_logic;
		DIFFIO_R16P_CLK3P : in std_logic;
		DIFFIO_R16N_CLK3N : in std_logic;
		DIFFIO_R18P : in std_logic;
		DIFFIO_R18N : in std_logic;
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
		DIFFIO_T10N : in std_logic
-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!

	);

-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end MAX10_system;

architecture ppl_type of MAX10_system is

-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!

end;
