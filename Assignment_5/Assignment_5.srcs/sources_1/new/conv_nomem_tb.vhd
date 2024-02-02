----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 06:39:46
-- Design Name: 
-- Module Name: conv_highperf_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

library work;
use work.array_types.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_nomem_tb is
--  Port ( );
end conv_nomem_tb;

architecture Behavioral of conv_nomem_tb is
    component conv_nomem
        Port (
            clk, reset : in std_logic;
            x          : in array_inputs(0 to 9);
            y          : out signed(3 downto 0)
        );
    end component;
    
    signal clk, reset: std_logic := '0';
    signal x : array_inputs(0 to 9);
    signal y : signed(3 downto 0);
    constant clk_period: time := 1 ns;
begin
    
    DUT: conv_nomem port map (
        clk => clk,
        reset => reset,
        x => x,
        y => y);
    
    clk_process:
    process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    dut_process:
    process
    begin
        reset <= '0';
        x <= ( "0001", "0001", "0001", "0001", "0001", "0001", "0001", "0001", "0001", "0001" );
        wait for 2 ns;
        reset <= '1';
        wait;
    end process;

end Behavioral;
