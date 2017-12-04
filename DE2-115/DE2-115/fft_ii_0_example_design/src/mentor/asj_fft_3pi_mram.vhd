-- (C) 2001-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions and other 
-- software and tools, and its AMPP partner logic functions, and any output 
-- files any of the foregoing (including device programming or simulation 
-- files), and any associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License Subscription 
-- Agreement, Altera MegaCore Function License Agreement, or other applicable 
-- license agreement, including, without limitation, that your use is for the 
-- sole purpose of programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the applicable 
-- agreement for further details.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--  version   : $Version: 1.0 $ 
--  revision    : $Revision: #1 $ 
--  designer name   : $Author: swbranch $ 
--  company name    : altera corp.
--  company address : 101 innovation drive
--                      san jose, california 95134
--                      u.s.a.
-- 
--  copyright altera corp. 2003
-- 
-- 
--  $Header: //acds/rel/16.0/ip/dsp/altera_fft_ii/src/rtl/lib/old_arch/asj_fft_3pi_mram.vhd#1 $ 
--  $log$ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- megafunction wizard: %ALTSYNCRAM%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altsyncram 

-- ============================================================
-- File Name: asj_fft_3pi_mram.vhd
-- Megafunction Name(s):
--      altsyncram
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
-- ************************************************************


--Copyright (C) 1991-2003 Altera Corporation
--Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
--support information,  device programming or simulation file,  and any other
--associated  documentation or information  provided by  Altera  or a partner
--under  Altera's   Megafunction   Partnership   Program  may  be  used  only
--to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
--other  use  of such  megafunction  design,  netlist,  support  information,
--device programming or simulation file,  or any other  related documentation
--or information  is prohibited  for  any  other purpose,  including, but not
--limited to  modification,  reverse engineering,  de-compiling, or use  with
--any other  silicon devices,  unless such use is  explicitly  licensed under
--a separate agreement with  Altera  or a megafunction partner.  Title to the
--intellectual property,  including patents,  copyrights,  trademarks,  trade
--secrets,  or maskworks,  embodied in any such megafunction design, netlist,
--support  information,  device programming or simulation file,  or any other
--related documentation or information provided by  Altera  or a megafunction
--partner, remains with Altera, the megafunction partner, or their respective
--licensors. No other licenses, including any licenses needed under any third
--party's intellectual property, are provided herein.


library ieee;
use ieee.std_logic_1164.all;

use work.fft_pack.all;
library lpm;
use lpm.lpm_components.all;
library altera_mf;
use altera_mf.altera_mf_components.all;


entity asj_fft_3pi_mram is
  generic(
          device_family : string; 
          dpr : integer :=128; 
          apr : integer :=10;
          bytesize : integer :=8;
          bpr : integer :=16
  );
  port
  (
global_clock_enable : in std_logic;
    data_a    : in std_logic_vector (dpr-1 downto 0);
    wren_a    : in std_logic  := '1';
    address_a   : in std_logic_vector (apr-1 downto 0);
    data_b    : in std_logic_vector (dpr-1 downto 0);
    address_b   : in std_logic_vector (apr-1 downto 0);
    wren_b    : in std_logic  := '1';
    byteena_a   : in std_logic_vector (bpr-1 downto 0);
    clock   : in std_logic ;
    q_a   : out std_logic_vector (dpr-1 downto 0);
    q_b   : out std_logic_vector (dpr-1 downto 0)
  );
end asj_fft_3pi_mram;


architecture syn of asj_fft_3pi_mram is

  constant internal_dpr : integer:=bpr*bytesize;
  constant external_mpr : integer:=dpr/8;
  constant internal_mpr : integer:=internal_dpr/8;
  signal sub_wire0  : std_logic_vector (internal_dpr-1 downto 0);
  signal sub_wire1  : std_logic_vector (internal_dpr-1 downto 0);
  signal data_a_int : std_logic_vector(internal_dpr-1 downto 0);
  signal q_a_int     : std_logic_vector(internal_dpr-1 downto 0);
  signal q_b_int     : std_logic_vector(internal_dpr-1 downto 0);


  component altsyncram
  generic (
    operation_mode    : string;
    width_a   : natural;
    widthad_a   : natural;
    numwords_a    : natural;
    width_b   : natural;
    widthad_b   : natural;
    numwords_b    : natural;
    lpm_type    : string;
    width_byteena_a   : natural;
    width_byteena_b   : natural;
    byte_size   : natural;
    outdata_reg_a   : string;
    outdata_aclr_a    : string;
    outdata_reg_b   : string;
    indata_aclr_a   : string;
    wrcontrol_aclr_a    : string;
    address_aclr_a    : string;
    byteena_aclr_a    : string;
    indata_reg_b    : string;
    address_reg_b   : string;
    wrcontrol_wraddress_reg_b   : string;
    indata_aclr_b   : string;
    wrcontrol_aclr_b    : string;
    address_aclr_b    : string;
    outdata_aclr_b    : string;
    read_during_write_mode_mixed_ports    : string;
    ram_block_type    : string;
    intended_device_family    : string
  );
  port (
clocken0 : in std_logic;
      wren_a  : in std_logic ;
      clock0  : in std_logic ;
      wren_b  : in std_logic ;
      byteena_a : in std_logic_vector (bpr-1 downto 0);
      address_a : in std_logic_vector (apr-1 downto 0);
      address_b : in std_logic_vector (apr-1 downto 0);
      q_a : out std_logic_vector (internal_dpr-1 downto 0);
      q_b : out std_logic_vector (internal_dpr-1 downto 0);
      data_a  : in std_logic_vector (internal_dpr-1 downto 0);
      data_b  : in std_logic_vector (internal_dpr-1 downto 0):=(OTHERS=>'0')
  );
  end component;

BEGIN
  
  gen_input_data_bus : process(data_a) is
  begin
    for i in 8 downto 1 loop
      data_a_int(i*internal_mpr-1 downto ((i-1)*internal_mpr)+external_mpr) <= (i*internal_mpr-1 downto ((i-1)*internal_mpr)+external_mpr => data_a(i*external_mpr-1));
      data_a_int(((i-1)*internal_mpr)+external_mpr-1 downto (i-1)*internal_mpr) <=  data_a(i*external_mpr-1 downto (i-1)*external_mpr); 
    end loop;
  end process gen_input_data_bus;
  
  gen_output_data_bus : process(q_a_int, q_b_int) is
  begin
    for i in 8 downto 1 loop
      q_a(i*external_mpr-1 downto (i-1)*external_mpr) <=  q_a_int((i-1)*internal_mpr+external_mpr-1 downto (i-1)*internal_mpr); 
      q_b(i*external_mpr-1 downto (i-1)*external_mpr) <=  q_b_int((i-1)*internal_mpr+external_mpr-1 downto (i-1)*internal_mpr); 
    end loop;
  end process gen_output_data_bus;
  
  q_a_int    <= sub_wire0(internal_dpr-1 DOWNTO 0);
  q_b_int    <= sub_wire1(internal_dpr-1 DOWNTO 0);

  altsyncram_component : altsyncram
  GENERIC MAP (
    operation_mode => "BIDIR_DUAL_PORT",
    width_a => internal_dpr,
    widthad_a => apr,
    numwords_a => 2**apr,
    width_b => internal_dpr,
    widthad_b => apr,
    numwords_b => 2**apr,
    lpm_type => "altsyncram",
    width_byteena_a => bpr,
    width_byteena_b => 1,
    byte_size => bytesize,
    outdata_reg_a => "CLOCK0",
    outdata_aclr_a => "NONE",
    outdata_reg_b => "CLOCK0",
    indata_aclr_a => "NONE",
    wrcontrol_aclr_a => "NONE",
    address_aclr_a => "NONE",
    byteena_aclr_a => "NONE",
    indata_reg_b => "CLOCK0",
    address_reg_b => "CLOCK0",
    wrcontrol_wraddress_reg_b => "CLOCK0",
    indata_aclr_b => "NONE",
    wrcontrol_aclr_b => "NONE",
    address_aclr_b => "NONE",
    outdata_aclr_b => "NONE",
    read_during_write_mode_mixed_ports => "DONT_CARE",
    ram_block_type => "M-RAM",
    intended_device_family => device_family 
  )
  PORT MAP (
clocken0 => global_clock_enable,
    wren_a => wren_a,
    clock0 => clock,
    wren_b => '0',
    byteena_a => byteena_a,
    address_a => address_a,
    address_b => address_b,
    data_a => data_a_int,
    data_b => (others=>'0'),
    q_a => sub_wire0,
    q_b => sub_wire1
  );



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: VarWidth NUMERIC "0"
-- Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "128"
-- Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "128"
-- Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "128"
-- Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "128"
-- Retrieval info: PRIVATE: MEMSIZE NUMERIC "524288"
-- Retrieval info: PRIVATE: Clock NUMERIC "0"
-- Retrieval info: PRIVATE: rden NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "1"
-- Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: Clock_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clock_B NUMERIC "0"
-- Retrieval info: PRIVATE: REGdata NUMERIC "1"
-- Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
-- Retrieval info: PRIVATE: REGwren NUMERIC "1"
-- Retrieval info: PRIVATE: REGrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: REGrren NUMERIC "0"
-- Retrieval info: PRIVATE: REGq NUMERIC "1"
-- Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: CLRdata NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwren NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwraddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrren NUMERIC "0"
-- Retrieval info: PRIVATE: CLRq NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: enable NUMERIC "0"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "2"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "1"
-- Retrieval info: PRIVATE: MIFfilename STRING ""
-- Retrieval info: PRIVATE: UseLCs NUMERIC "0"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "3"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
-- Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "0"
-- Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "3"
-- Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "BIDIR_DUAL_PORT"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "128"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "12"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "4096"
-- Retrieval info: CONSTANT: WIDTH_B NUMERIC "128"
-- Retrieval info: CONSTANT: WIDTHAD_B NUMERIC "12"
-- Retrieval info: CONSTANT: NUMWORDS_B NUMERIC "4096"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "16"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_B NUMERIC "1"
-- Retrieval info: CONSTANT: BYTE_SIZE NUMERIC "8"
-- Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: INDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: WRCONTROL_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: ADDRESS_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: BYTEENA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: INDATA_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: ADDRESS_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: WRCONTROL_WRADDRESS_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: INDATA_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: WRCONTROL_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: ADDRESS_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_MIXED_PORTS STRING "DONT_CARE"
-- Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "M-RAM"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix"
-- Retrieval info: USED_PORT: data_a 0 0 128 0 INPUT NODEFVAL data_a[127..0]
-- Retrieval info: USED_PORT: wren_a 0 0 0 0 INPUT VCC wren_a
-- Retrieval info: USED_PORT: q_a 0 0 128 0 OUTPUT NODEFVAL q_a[127..0]
-- Retrieval info: USED_PORT: q_b 0 0 128 0 OUTPUT NODEFVAL q_b[127..0]
-- Retrieval info: USED_PORT: address_a 0 0 12 0 INPUT NODEFVAL address_a[11..0]
-- Retrieval info: USED_PORT: data_b 0 0 128 0 INPUT NODEFVAL data_b[127..0]
-- Retrieval info: USED_PORT: address_b 0 0 12 0 INPUT NODEFVAL address_b[11..0]
-- Retrieval info: USED_PORT: wren_b 0 0 0 0 INPUT VCC wren_b
-- Retrieval info: USED_PORT: byteena_a 0 0 16 0 INPUT VCC byteena_a[15..0]
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
-- Retrieval info: CONNECT: @data_a 0 0 128 0 data_a 0 0 128 0
-- Retrieval info: CONNECT: @wren_a 0 0 0 0 wren_a 0 0 0 0
-- Retrieval info: CONNECT: q_a 0 0 128 0 @q_a 0 0 128 0
-- Retrieval info: CONNECT: q_b 0 0 128 0 @q_b 0 0 128 0
-- Retrieval info: CONNECT: @address_a 0 0 12 0 address_a 0 0 12 0
-- Retrieval info: CONNECT: @data_b 0 0 128 0 data_b 0 0 128 0
-- Retrieval info: CONNECT: @address_b 0 0 12 0 address_b 0 0 12 0
-- Retrieval info: CONNECT: @wren_b 0 0 0 0 wren_b 0 0 0 0
-- Retrieval info: CONNECT: @byteena_a 0 0 16 0 byteena_a 0 0 16 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
