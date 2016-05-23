--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:44:10 05/23/2016
-- Design Name:   
-- Module Name:   C:/materija/RA117-2013/RGB_LED/pcores/led_map_peripheral_v1_00_a/devl/projnav/led_map_peripheral_tb.vhd
-- Project Name:  led_map_peripheral
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: led_map_peripheral
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY led_map_peripheral_tb IS
END led_map_peripheral_tb;
 
ARCHITECTURE behavior OF led_map_peripheral_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT led_map_peripheral
    PORT(
         Out_Data : OUT  std_logic;
         Out_Strobe : OUT  std_logic;
         Out_Clock : OUT  std_logic;
         Out_Test_Led : OUT  std_logic;
         S_AXI_ACLK : IN  std_logic;
         S_AXI_ARESETN : IN  std_logic;
         S_AXI_AWADDR : IN  std_logic_vector(31 downto 0);
         S_AXI_AWVALID : IN  std_logic;
         S_AXI_WDATA : IN  std_logic_vector(31 downto 0);
         S_AXI_WSTRB : IN  std_logic_vector(3 downto 0);
         S_AXI_WVALID : IN  std_logic;
         S_AXI_BREADY : IN  std_logic;
         S_AXI_ARADDR : IN  std_logic_vector(31 downto 0);
         S_AXI_ARVALID : IN  std_logic;
         S_AXI_RREADY : IN  std_logic;
         S_AXI_ARREADY : OUT  std_logic;
         S_AXI_RDATA : OUT  std_logic_vector(31 downto 0);
         S_AXI_RRESP : OUT  std_logic_vector(1 downto 0);
         S_AXI_RVALID : OUT  std_logic;
         S_AXI_WREADY : OUT  std_logic;
         S_AXI_BRESP : OUT  std_logic_vector(1 downto 0);
         S_AXI_BVALID : OUT  std_logic;
         S_AXI_AWREADY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S_AXI_ACLK : std_logic := '0';
   signal S_AXI_ARESETN : std_logic := '0';
   signal S_AXI_AWADDR : std_logic_vector(31 downto 0) := (others => '0');
   signal S_AXI_AWVALID : std_logic := '0';
   signal S_AXI_WDATA : std_logic_vector(31 downto 0) := (others => '0');
   signal S_AXI_WSTRB : std_logic_vector(3 downto 0) := (others => '0');
   signal S_AXI_WVALID : std_logic := '0';
   signal S_AXI_BREADY : std_logic := '0';
   signal S_AXI_ARADDR : std_logic_vector(31 downto 0) := (others => '0');
   signal S_AXI_ARVALID : std_logic := '0';
   signal S_AXI_RREADY : std_logic := '0';

 	--Outputs
   signal Out_Data : std_logic;
   signal Out_Strobe : std_logic;
   signal Out_Clock : std_logic;
   signal Out_Test_Led : std_logic;
   signal S_AXI_ARREADY : std_logic;
   signal S_AXI_RDATA : std_logic_vector(31 downto 0);
   signal S_AXI_RRESP : std_logic_vector(1 downto 0);
   signal S_AXI_RVALID : std_logic;
   signal S_AXI_WREADY : std_logic;
   signal S_AXI_BRESP : std_logic_vector(1 downto 0);
   signal S_AXI_BVALID : std_logic;
   signal S_AXI_AWREADY : std_logic;

   -- Clock period definitions
   constant S_AXI_ACLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: led_map_peripheral PORT MAP (
          Out_Data => Out_Data,
          Out_Strobe => Out_Strobe,
          Out_Clock => Out_Clock,
          Out_Test_Led => Out_Test_Led,
          S_AXI_ACLK => S_AXI_ACLK,
          S_AXI_ARESETN => S_AXI_ARESETN,
          S_AXI_AWADDR => S_AXI_AWADDR,
          S_AXI_AWVALID => S_AXI_AWVALID,
          S_AXI_WDATA => S_AXI_WDATA,
          S_AXI_WSTRB => S_AXI_WSTRB,
          S_AXI_WVALID => S_AXI_WVALID,
          S_AXI_BREADY => S_AXI_BREADY,
          S_AXI_ARADDR => S_AXI_ARADDR,
          S_AXI_ARVALID => S_AXI_ARVALID,
          S_AXI_RREADY => S_AXI_RREADY,
          S_AXI_ARREADY => S_AXI_ARREADY,
          S_AXI_RDATA => S_AXI_RDATA,
          S_AXI_RRESP => S_AXI_RRESP,
          S_AXI_RVALID => S_AXI_RVALID,
          S_AXI_WREADY => S_AXI_WREADY,
          S_AXI_BRESP => S_AXI_BRESP,
          S_AXI_BVALID => S_AXI_BVALID,
          S_AXI_AWREADY => S_AXI_AWREADY
        );

 
   S_AXI_ACLK_process :process
   begin
		S_AXI_ACLK <= '0';
		wait for S_AXI_ACLK_period/2;
		S_AXI_ACLK <= '1';
		wait for S_AXI_ACLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for S_AXI_ACLK_period*10;
		
		S_AXI_ARESETN <= '1';

      wait;
   end process;

END;
