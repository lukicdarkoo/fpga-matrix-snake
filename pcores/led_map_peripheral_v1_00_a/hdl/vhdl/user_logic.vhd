------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Mon May 09 17:42:32 2016 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_NUM_REG                    -- Number of software accessible registers
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Resetn                -- Bus to IP reset
--   Bus2IP_Addr                  -- Bus to IP address bus
--   Bus2IP_CS                    -- Bus to IP chip select
--   Bus2IP_RNW                   -- Bus to IP read/not write
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_NUM_REG                      : integer              := 32;
    C_SLV_DWIDTH                   : integer              := 32
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    Out_Data	: out std_logic;
	 Out_Strobe : out std_logic;
	 Out_Clock : out std_logic;
	 
	 -- TODO: Test LED
	 Out_Test_Led : out std_logic;
	 
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Resetn                  : in  std_logic;
    Bus2IP_Addr                    : in  std_logic_vector(0 to 31);
    Bus2IP_CS                      : in  std_logic_vector(0 to 0);
    Bus2IP_RNW                     : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    Bus2IP_BE                      : in  std_logic_vector(C_SLV_DWIDTH/8-1 downto 0);
    Bus2IP_RdCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    Bus2IP_WrCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    IP2Bus_Data                    : out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE --------------------- 
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;

  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Resetn : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic

	type state_types is (IDLE, ROW1, ROW2, ROW3, ROW4, ROW5, ROW6, ROW7, ROW8);
	signal state : state_types;
	 
	type pixel_array_t is array (natural range<>) of std_logic_vector(2 downto 0);
	signal led_ram : pixel_array_t(0 to 63);
	
	signal row_idx : std_logic_vector(3 downto 0);
	signal row : pixel_array_t(0 to 7);
	signal row_o : pixel_array_t(0 to 7);
	
	--FREQUENCY DIVIDER
	signal temporal: std_logic; 
   signal counter : integer range 0 to 1000 := 0;
	signal clk_internal : std_logic;
	
	-- SENDER
	signal bit_index: integer range 0 to 31 := 0;
	signal test_led: std_logic_vector(31 downto 0) := x"aaaaaaaa";


	signal ser_clk : std_logic;
	signal ser_data : std_logic;
	signal ser_strobe : std_logic;
	signal ser_cnt : std_logic_vector(15 downto 0);
	signal ser_half_clk : std_logic;
	signal ser_clk_rising_edge : std_logic;
	signal ser_clk_falling_edge : std_logic;
	signal ser_idx : std_logic_vector(4 downto 0);
	signal ser_par_data : std_logic_vector(31 downto 0) := x"AAAAAAAA";--:= x"babadeda";--(others => '0');
begin
--	--FREQUENCY DIVIDER
--    frequency_divider: process (Bus2IP_Resetn, Bus2IP_Clk) begin
--        if (Bus2IP_Resetn = '1') then
--            temporal <= '0';
--            counter <= 0;
--        elsif rising_edge(Bus2IP_Clk) then
--            if (counter = 1000) then
--                temporal <= NOT(temporal);
--                counter <= 0;
--            else
--                counter <= counter + 1;
--            end if;
--        end if;
--    end process;
--    
--   clk_internal <= temporal;
--	--END FREQUENCY DIVIDER
--	
--	
--	-- BEGIN SENDER
--	Sender: process (clk_internal, Bus2IP_Resetn) begin
--		  if (Bus2IP_Resetn = '1') then
--            bit_index <= 0;
--		  elsif rising_edge(clk_internal) then
--				if (bit_index = 32) then
--					bit_index <= 0;
--				else 
--					bit_index <= bit_index + 1;
--				end if;
--        end if;
--	end process;
--	-- END SENDER

	process(Bus2IP_Clk) begin
		if rising_edge(Bus2IP_Clk) then
			if Bus2IP_Resetn = '0' then
				ser_cnt <= (others => '0');
			else
				if ser_half_clk = '1' then
					ser_cnt <= (others => '0');
				else
					ser_cnt <= ser_cnt+1;
				end if;
			end if;
		end if;
	end process;
	ser_half_clk <= '1' when ser_cnt = 1000/2-1 else '0'; -- 100kHz
	
	process(Bus2IP_Clk) begin
		if rising_edge(Bus2IP_Clk) then
			if Bus2IP_Resetn = '0' then
				ser_clk <= '0';
			else
				if ser_half_clk = '1' then
					ser_clk <= not ser_clk;
				end if;
			end if;
		end if;
	end process;
	ser_clk_rising_edge <= ser_half_clk and not ser_clk;
	ser_clk_falling_edge <= ser_half_clk and ser_clk;
	
	process(Bus2IP_Clk) begin
		if rising_edge(Bus2IP_Clk) then
			if Bus2IP_Resetn = '0' then
				ser_idx <= (others => '0');
			else
				if ser_clk_falling_edge = '1' then
					if ser_idx = ser_par_data'length-1 then
						ser_idx <= (others => '0');
					else
						ser_idx <= ser_idx + 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	ser_data <= ser_par_data(conv_integer(ser_idx));
	ser_strobe <= '1' when ser_idx = 0 and ser_clk = '0' else '0';
	
	
	Out_Data <= ser_data;
	Out_Strobe <= ser_strobe;
	Out_Clock <= ser_clk;
	
	Out_Test_Led <= '1';
	
	
   --row <= led_ram(conv_integer(row_idx)*8 to conv_integer(row_idx)*8+7);
	
	--row_o <= row;
	
	--row2(0)(1) & row2(1)(1) & row2(2)(1)

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Resetn = '0' then
			led_ram <= (others => (others => '0'));
      elsif Bus2IP_RNW = '0' and Bus2IP_CS(0) = '1' then
			led_ram(conv_integer(Bus2IP_Addr)) <= Bus2IP_Data(2 downto 0);
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process( Bus2IP_Addr, led_ram ) is
  begin
		IP2Bus_Data <= "00000000000000000000000000000" & led_ram(conv_integer(Bus2IP_Addr));
  end process SLAVE_REG_READ_PROC;


  IP2Bus_WrAck <= '1';
  IP2Bus_RdAck <= '1';
  IP2Bus_Error <= '0';

end IMP;
