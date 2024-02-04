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

library work;
use work.array_types.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_nomem is
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
end conv_nomem;

architecture Behavioral of conv_nomem is
    signal h : array_inputs(0 to num_inputs-1) := ("0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010");
begin
    process(clk, reset, x)
        variable acc, prod : signed(bit_width-1 downto 0);
        variable carry : natural;
    begin
        y <= (others => '0');
        if rising_edge(clk) and reset = '0' then
            acc := (others => '0');
            for i in 0 to num_inputs-1 loop
                -- Multiplication algorithm x(i)*h(i)
                prod := (others => '0');
                for j in 0 to bit_width-1 loop
                    -- Maintain amount of carry
                    carry := 0;
                    for k in 0 to j loop
                        if x(i)(k) = '1' and h(i)(j-k) = '1' then
                            carry := carry + 1;
                        end if;
                    end loop;
                    -- Units digit of carry
                    if carry rem 2 = 1 then
                        prod(j) := '1';
                    end if;
                    -- Shift carry right
                    carry := carry / 2;
                end loop;
                acc := acc + prod;
            end loop;
            y <= acc;
        end if;
    end process;
end Behavioral;
