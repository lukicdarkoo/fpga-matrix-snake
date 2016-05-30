------------------------------------------------------------------------------
-- led_map_peripheral.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
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
-- Filename:          led_map_peripheral.vhd
-- Version:           1.00.a
-- Description:       Top level design, instantiates library components and user logic.
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_S_AXI_DATA_WIDTH           -- AXI4LITE slave: Data width
--   C_S_AXI_ADDR_WIDTH           -- AXI4LITE slave: Address Width
--   C_S_AXI_MIN_SIZE             -- AXI4LITE slave: Min Size
--   C_USE_WSTRB                  -- AXI4LITE slave: Write Strobe
--   C_DPHASE_TIMEOUT             -- AXI4LITE slave: Data Phase Timeout
--   C_BASEADDR                   -- AXI4LITE slave: base address
--   C_HIGHADDR                   -- AXI4LITE slave: high address
--   C_FAMILY                     -- FPGA Family
--   C_NUM_REG                    -- Number of software accessible registers
--   C_NUM_MEM                    -- Number of address-ranges
--   C_SLV_AWIDTH                 -- Slave interface address bus width
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
-- Definition of Ports:
--   S_AXI_ACLK                   -- AXI4LITE slave: Clock 
--   S_AXI_ARESETN                -- AXI4LITE slave: Reset
--   S_AXI_AWADDR                 -- AXI4LITE slave: Write address
--   S_AXI_AWVALID                -- AXI4LITE slave: Write address valid
--   S_AXI_WDATA                  -- AXI4LITE slave: Write data
--   S_AXI_WSTRB                  -- AXI4LITE slave: Write strobe
--   S_AXI_WVALID                 -- AXI4LITE slave: Write data valid
--   S_AXI_BREADY                 -- AXI4LITE slave: Response ready
--   S_AXI_ARADDR                 -- AXI4LITE slave: Read address
--   S_AXI_ARVALID                -- AXI4LITE slave: Read address valid
--   S_AXI_RREADY                 -- AXI4LITE slave: Read data ready
--   S_AXI_ARREADY                -- AXI4LITE slave: read addres ready
--   S_AXI_RDATA                  -- AXI4LITE slave: Read data
--   S_AXI_RRESP                  -- AXI4LITE slave: Read data response
--   S_AXI_RVALID                 -- AXI4LITE slave: Read data valid
--   S_AXI_WREADY                 -- AXI4LITE slave: Write data ready
--   S_AXI_BRESP                  -- AXI4LITE slave: Response
--   S_AXI_BVALID                 -- AXI4LITE slave: Resonse valid
--   S_AXI_AWREADY                -- AXI4LITE slave: Wrte address ready
------------------------------------------------------------------------------

entity led_map_peripheral is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_S_AXI_DATA_WIDTH             : integer              := 32;
    C_S_AXI_ADDR_WIDTH             : integer              := 32;
    C_S_AXI_MIN_SIZE               : std_logic_vector     := X"000001FF";
    C_USE_WSTRB                    : integer              := 0;
    C_DPHASE_TIMEOUT               : integer              := 8;
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_FAMILY                       : string               := "virtex6";
    C_NUM_REG                      : integer              := 1;
    C_NUM_MEM                      : integer              := 1;
    C_SLV_AWIDTH                   : integer              := 32;
    C_SLV_DWIDTH                   : integer              := 32
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
	 Out_Data	: out std_logic;
	 Out_Strobe : out std_logic;
	 Out_Clock : out std_logic;
	 Out_IRQ : out std_logic;

    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    S_AXI_ACLK                     : in  std_logic;
    S_AXI_ARESETN                  : in  std_logic;
    S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWVALID                  : in  std_logic;
    S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID                   : in  std_logic;
    S_AXI_BREADY                   : in  std_logic;
    S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID                  : in  std_logic;
    S_AXI_RREADY                   : in  std_logic;
    S_AXI_ARREADY                  : out std_logic;
    S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
    S_AXI_RVALID                   : out std_logic;
    S_AXI_WREADY                   : out std_logic;
    S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
    S_AXI_BVALID                   : out std_logic;
    S_AXI_AWREADY                  : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;
  attribute MAX_FANOUT of S_AXI_ACLK       : signal is "10000";
  attribute MAX_FANOUT of S_AXI_ARESETN       : signal is "10000";
  attribute SIGIS of S_AXI_ACLK       : signal is "Clk";
  attribute SIGIS of S_AXI_ARESETN       : signal is "Rst";
end entity led_map_peripheral;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of led_map_peripheral is


	-- AXI stuff.
	constant BASE_ADDR : signed(C_S_AXI_ADDR_WIDTH-1 downto 0) := signed(C_BASEADDR);
	subtype t_addr is signed(C_S_AXI_ADDR_WIDTH-1 downto 2);
	subtype t_word is std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	constant ADDR_WIDTH : natural := 6;
	
	
	signal accept_write     : std_logic;
	signal r_write_response : std_logic;
	
	signal local_write_addr : t_addr;
	signal write_regs_en    : boolean;
	signal we_en : std_logic;
	
	
	-- LED stuff.
	type pixel_array_t is array (natural range<>) of std_logic_vector(2 downto 0);
	signal led_ram : pixel_array_t(0 to 63);
	
	signal row_idx : std_logic_vector(2 downto 0);
	signal decoded_row_idx : std_logic_vector(7 downto 0);
	signal row : pixel_array_t(0 to 7);
	
	signal ser_clk : std_logic;
	signal ser_data : std_logic;
	signal ser_strobe : std_logic;
	signal ser_cnt : std_logic_vector(15 downto 0);
	signal ser_half_clk : std_logic;
	signal ser_clk_rising_edge : std_logic;
	signal ser_clk_falling_edge : std_logic;
	signal ser_idx : std_logic_vector(4 downto 0);
	signal ser_par_data : std_logic_vector(31 downto 0) := x"AAAAAAAA";--:= x"babadeda";--(others => '0');
	
	signal led_r: std_logic_vector(7 downto 0);
	signal led_b: std_logic_vector(7 downto 0);
	signal led_g: std_logic_vector(7 downto 0);	
	
	signal s_joy_state: std_logic_vector(4 downto 0);
begin

	-- Read transaction.
    S_AXI_ARREADY <= '0';
    S_AXI_RDATA <= (others => '0');
    S_AXI_RRESP <= (others => '0');
    S_AXI_RVALID <= '0';
	 
	 

	-- Write transaction.
	
	-- When both valid signals are asserted and response is not in progress
	-- then say valid to master, write data and give response.
	
	accept_write <= S_AXI_AWVALID and S_AXI_WVALID and not r_write_response;
	S_AXI_AWREADY <= accept_write;
	S_AXI_WREADY <= accept_write;
	
	local_write_addr <= signed(S_AXI_AWADDR(t_addr'range)) - BASE_ADDR(t_addr'range);
	write_regs_en <= accept_write = '1' and local_write_addr(t_addr'left downto ADDR_WIDTH+2) = 0;
	we_en <= '1' when write_regs_en else '0';

	write_regs: process(S_AXI_ACLK)
	begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
				--r_regs <= (others => (others => '0'));
				r_write_response <= '0';
			else
				if accept_write = '1' then
					r_write_response <= '1';
				else
					if S_AXI_BREADY = '1' then
						r_write_response <= '0';
					end if;
				end if;
			end if;
		end if;
	end process write_regs;
	
	S_AXI_BRESP  <= "00"; -- Always OK response.
	S_AXI_BVALID <= r_write_response;


	-- Writing to map.
	process(S_AXI_ACLK) begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
				led_ram <= (others => (others => '0'));
			else
				if we_en = '1' then
					led_ram(to_integer(local_write_addr(ADDR_WIDTH+1 downto 2))) <= S_AXI_WDATA(2 downto 0);
				end if;
			end if;
		end if;
	end process;


	-- LED Stuff.

	-- Clock Divider
	process(S_AXI_ACLK) begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
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
	
	-- Generate ser_clk
	process(S_AXI_ACLK) begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
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
	
	-- Serializer
	process(S_AXI_ACLK) begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
				ser_idx <= (others => '0');
				row_idx <= (others => '0');
				Out_IRQ <= '0';
			else
				Out_IRQ <= '0';
				if ser_clk_falling_edge = '1' then
					if ser_idx = ser_par_data'length-1 then
						ser_idx <= (others => '0');
						
						if row_idx = 7 then
							Out_IRQ <= '1';
						end if;
						row_idx <= row_idx + 1;
					else
						ser_idx <= ser_idx + 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	


	ser_data <= ser_par_data(conv_integer(ser_idx));
	ser_strobe <= '1' when ser_idx = 0 and ser_clk = '0' else '0';
	
   row <= led_ram(conv_integer(row_idx)*8 to conv_integer(row_idx)*8+7);
	led_r <= row(0)(0) & row(1)(0) & row(2)(0) & row(3)(0) & row(4)(0) & row(5)(0) & row(6)(0) & row(7)(0);
	led_g <= row(0)(1) & row(1)(1) & row(2)(1) & row(3)(1) & row(4)(1) & row(5)(1) & row(6)(1) & row(7)(1);
	led_b <= row(0)(2) & row(1)(2) & row(2)(2) & row(3)(2) & row(4)(2) & row(5)(2) & row(6)(2) & row(7)(2);

	decoded_row_idx <= "00000001" when row_idx = 0 else
						"00000010" when row_idx = 1 else
						"00000100" when row_idx = 2 else
						"00001000" when row_idx = 3 else
						"10000000" when row_idx = 4 else
						"01000000" when row_idx = 5 else
						"00100000" when row_idx = 6 else
						"00010000";
						
	

	ser_par_data <= not(decoded_row_idx & led_g & led_b & led_r);
	
	Out_Data <= ser_data;
	Out_Strobe <= ser_strobe;
	Out_Clock <= ser_clk;
	
end IMP;
