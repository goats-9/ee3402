----------------------------------------------------------------------------------
-- Company: Indian Institute of Techonology, Hyderabad
-- Engineer: Gautam Singh
-- 
-- Create Date: 31.01.2024 06:39:46
-- Design Name: 
-- Module Name: conv_nomem_tb - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fourbit_tb is
--  Port ( );
end fourbit_tb;

architecture Behavioral of fourbit_tb is
    component fourbit
        Port (
            clk, reset : in std_logic;
            x          : in signed(3 downto 0);
            y          : out signed(3 downto 0)
        );
    end component;
    
    signal clk, reset: std_logic := '0';
    signal x, y : signed(3 downto 0);
    constant clk_period: time := 10 ns;
begin
    
    DUT: fourbit port map (
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
        x <= "0000";
        wait for clk_period;
        x <= "0001";
        wait for clk_period;
        x <= "0010";
        wait for clk_period;
        x <= "0011";
        wait for clk_period;
        x <= "0000";
        wait for clk_period;
        x <= "0001";
        wait for clk_period;
        x <= "0010";
        wait for clk_period;
        x <= "0011";
        wait for clk_period;
        x <= "0000";
        wait for clk_period;
        x <= "0001";
        wait for 4*clk_period;
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        x <= "0000";
        wait for clk_period;
        x <= "0001";
        wait for clk_period;
        x <= "0010";
        wait for clk_period;
        x <= "0011";
        wait for clk_period;
        x <= "0100";
        wait for clk_period;
        x <= "0101";
        wait for clk_period;
        x <= "0110";
        wait for clk_period;
        x <= "0111";
        wait for clk_period;
        x <= "1000";
        wait for clk_period;
        x <= "1001";
        wait for clk_period;
        x <= "1010";
        wait for clk_period;
        x <= "1011";
        wait for clk_period;
        x <= "1100";
        wait for clk_period;
        x <= "1101";
        wait for clk_period;
        x <= "1110";
        wait for clk_period;
        x <= "1111";
        wait for 4*clk_period;        
        reset <= '1';
        wait;
    end process;
end Behavioral;
