----------------------------------------------------------------------------------
-- Company: Indian Institute of Techonology, Hyderabad
-- Engineer: Gautam Singh
-- 
-- Create Date: 30.01.2024 16:30:41
-- Design Name: conv_memory
-- Module Name: conv_memory - Behavioral
-- Project Name: conv_memory
-- Target Devices: 
-- Tool Versions: 
-- Description: Perform convolution with a kernel of size 10 without using
-- multipliers or replacing multiplication with repeated or shifted addition.
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

entity conv_memory is
    -- Generic bit widths and number of inputs
    Generic (
        constant num_inputs : natural := 10;
        constant bit_width  : natural := 4;
        constant h_mem_size : natural := 15
    );
    Port (
        clk, reset : in std_logic;
        x          : in array_inputs(0 to num_inputs-1);
        y          : out signed(bit_width-1 downto 0)
    );
end conv_memory;

architecture Behavioral of conv_memory is
begin
    process(clk, reset, x)
        variable h0_mem : array_inputs(0 to h_mem_size) := ("0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111");
        variable h1_mem : array_inputs(0 to h_mem_size) := ("0000","0010","0100","0110","1000","1010","1100","1110","0000","0010","0100","0110","1000","1010","1100","1110");
        variable h2_mem : array_inputs(0 to h_mem_size) := ("0000","0011","0110","1001","1100","1111","0010","0101","1000","1011","1110","0001","0100","0111","1010","1101");
        variable h3_mem : array_inputs(0 to h_mem_size) := ("0000","0100","1000","1100","0000","0100","1000","1100","0000","0100","1000","1100","0000","0100","1000","1100");
        variable h4_mem : array_inputs(0 to h_mem_size) := ("0000","0101","1010","1111","0100","1001","1110","0011","1000","1101","0010","0111","1100","0001","0110","1011");
        variable h5_mem : array_inputs(0 to h_mem_size) := ("0000","0110","1100","0010","1000","1110","0100","1010","0000","0110","1100","0010","1000","1110","0100","1010");
        variable h6_mem : array_inputs(0 to h_mem_size) := ("0000","0111","1110","0101","1100","0011","1010","0001","1000","1111","0110","1101","0100","1011","0010","1001");
        variable h7_mem : array_inputs(0 to h_mem_size) := ("0000","1000","0000","1000","0000","1000","0000","1000","0000","1000","0000","1000","0000","1000","0000","1000");
        variable h8_mem : array_inputs(0 to h_mem_size) := ("0000","1001","0010","1011","0100","1101","0110","1111","1000","0001","1010","0011","1100","0101","1110","0111");
        variable h9_mem : array_inputs(0 to h_mem_size) := ("0000","1010","0100","1110","1000","0010","1100","0110","0000","1010","0100","1110","1000","0010","1100","0110");
        variable acc : signed(bit_width-1 downto 0);
    begin
        y <= (others => '0');
        if rising_edge(clk) and reset = '0' then
            acc := (others => '0');
            acc := acc + h0_mem(to_integer(unsigned(x(0))));
            acc := acc + h1_mem(to_integer(unsigned(x(1))));
            acc := acc + h2_mem(to_integer(unsigned(x(2))));
            acc := acc + h3_mem(to_integer(unsigned(x(3))));
            acc := acc + h4_mem(to_integer(unsigned(x(4))));
            acc := acc + h5_mem(to_integer(unsigned(x(5))));
            acc := acc + h6_mem(to_integer(unsigned(x(6))));
            acc := acc + h7_mem(to_integer(unsigned(x(7))));
            acc := acc + h8_mem(to_integer(unsigned(x(8))));
            acc := acc + h9_mem(to_integer(unsigned(x(9))));
            y <= acc;
        end if;
    end process;
end Behavioral;
