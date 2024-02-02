----------------------------------------------------------------------------------
-- Company: Indian Institute of Techonology, Hyderabad
-- Engineer: Gautam Singh
-- 
-- Create Date: 30.01.2024 16:30:41
-- Design Name: conv_highperf
-- Module Name: conv_highperf - Behavioral
-- Project Name: conv_highperf
-- Target Devices: 
-- Tool Versions: 
-- Description: Perform convolution with a kernel of size 10 by performing 
-- additions and multiplications in parallel.
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

entity conv_highperf is
    -- Generic bit widths and number of inputs
    Generic (
        constant num_inputs : natural := 10;
        constant bit_width  : natural := 8
    );
    Port (
        clk, reset : in std_logic;
        x, h       : in array_inputs(0 to num_inputs-1);
        y          : out signed(bit_width-1 downto 0)
    );
end conv_highperf;

architecture Behavioral of conv_highperf is
begin
    process(clk, reset, x, h)
        variable acc : signed(bit_width-1 downto 0);
    begin
        acc := (others => '0');
        y <= (others => '0');
        if rising_edge(clk) and reset = '0' then
            for i in 0 to 9 loop
                acc := acc + resize(x(i)*h(i), bit_width);
            end loop;
            y <= acc;
        end if;
    end process;
end Behavioral;
