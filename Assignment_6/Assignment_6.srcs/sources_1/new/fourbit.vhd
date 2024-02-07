----------------------------------------------------------------------------------
-- Company: Indian Institute of Techonology, Hyderabad
-- Engineer: Gautam Singh
-- 
-- Create Date: 30.01.2024 16:30:41
-- Design Name: conv_nomem
-- Module Name: conv_nomem - Behavioral
-- Project Name: conv_nomem
-- Target Devices: 
-- Tool Versions: 
-- Description: Perform convolution with a kernel of size 10 without using
-- multipliers, memory and repeated or shifted additions.
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

entity fourbit is
    Port (
        clk, reset : in std_logic;
        x : in signed(3 downto 0);
        y : out signed(3 downto 0)
    );
end fourbit;

architecture Behavioral of fourbit is
    type buf_type is array(0 to 2) of signed(3 downto 0);
begin
    process(clk, reset, x)
        variable buf : buf_type := ( "0000", "0000", "0000" );
    begin
        if reset = '1' then
            buf := ( "0000", "0000", "0000" );
            y <= (others => '0');
        elsif rising_edge(clk) then
            y <= buf(0);
            buf(0) := buf(1);
            buf(1) := buf(2);
            buf(2) := x;
        end if;
    end process;
end Behavioral;
