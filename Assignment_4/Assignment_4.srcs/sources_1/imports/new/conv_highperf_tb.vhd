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

entity conv_highperf_tb is
--  Port ( );
end conv_highperf_tb;

architecture Behavioral of conv_highperf_tb is
    component conv_highperf
        Port (
            clk, reset : in std_logic;
            x, h       : in array_inputs(0 to 9);
            y          : out signed(7 downto 0)
        );
    end component;
    
    signal clk, reset: std_logic := '0';
    signal x, h : array_inputs(0 to 9);
    signal y : signed(7 downto 0);
    constant clk_period: time := 1 ns;
    
begin
    
    DUT: conv_highperf port map (
        clk => clk,
        reset => reset,
        x => x,
        h => h,
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
        x <= ( "00000001", "00000010", "00000011", "00000100", "00000101", "00000110", "00000111", "00001000", "00001001", "00001010" );
        h <= ( "00000001", "00000001", "00000001", "00000001", "00000001", "00000001", "00000001", "00000001", "00000001", "00000001" );
        wait for 1 ns;
        reset <= '1';
        wait;
    end process;

end Behavioral;
