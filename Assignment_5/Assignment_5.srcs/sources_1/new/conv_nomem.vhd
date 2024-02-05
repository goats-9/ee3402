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
begin
    process(clk, reset, x)
        variable prod, acc : signed(bit_width-1 downto 0) := (others => '0');
        variable cnt : natural := 0;
        variable a, b, c, d : std_logic := '0';
    begin
        y <= (others => '0');
        if rising_edge(clk) and reset = '0' then
            acc := (others => '0');
            for cnt in 0 to num_inputs-1 loop
                a := x(cnt)(3);
                b := x(cnt)(2);
                c := x(cnt)(1);
                d := x(cnt)(0);
                prod := (others => '0');
                case cnt is
                    when 0 =>
                        -- h0 = 1
                        prod := x(0);
                    when 1 =>
                        -- h1 = 2;
                        prod := (
                            3 => b,
                            2 => c,
                            1 => d,
                            others => '0'
                        );
                    when 2 =>
                        -- h2 = 3;
                        prod := (
                            3 => (not a and b and not c) or (a and not b and not c) or (a and not b and not d) or (a and b and c) or (not a and not b and c and d),
                            2 => (b and not c) or (b and d) or (not b and c and not d),
                            1 => (not c and d) or (c and not d),
                            0 => d
                        );
                    when 3 =>
                        -- h3 = 4;
                        prod := (
                            3 => c,
                            2 => d,
                            others => '0'
                        );
                    when 4 =>
                        -- h4 = 5;
                        prod := (
                            3 => (not a and not b and c) or (not a and c and not d) or (a and not b and not c) or (a and not c and not d) or (not a and b and not c and d) or (a and b and c and d),
                            2 => (not b and d) or (b and not d),
                            1 => c,
                            0 => d
                        );
                    when 5 =>
                        -- h5 = 6;
                        prod := (
                            3 => (b and not c) or (b and d) or (not b and c and not d),
                            2 => (not c and d) or (c and not d),
                            1 => d,
                            others => '0'
                        );
                    when 6 =>
                        -- h6 = 7;
                        prod := (
                            3 => (a and d) or (not a and c and not d) or (not a and b and not d) or (a and not b and not c), 
                            2 => (not b and d) or (not b and c) or (b and c and not d),
                            1 => (not c and d) or (c and not d),
                            0 => d
                        );
                    when 7 =>
                        -- h7 = 8;
                        prod := (
                            3 => d,
                            others => '0'
                        );
                    when 8 =>
                        -- h8 = 9;
                        prod := (
                            3 => (not a and d) or (a and not d),
                            2 => b,
                            1 => c,
                            0 => d
                        );
                    when 9 =>
                        -- h9 = 10;
                        prod := (
                            3 => (not b and d) or (b and not d),
                            2 => c,
                            1 => d,
                            others => '0'
                        );
                    when others =>
                end case;
                acc := acc + prod;
            end loop;
            y <= acc;
        end if;
    end process;
end Behavioral;
