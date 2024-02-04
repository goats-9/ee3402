----------------------------------------------------------------------------------
-- Company: Indian Institute of Techonology, Hyderabad
-- Engineer: Gautam Singh
-- 
-- Create Date: 30.01.2024 16:30:41
-- Design Name: conv_highperf
-- Module Name: conv_mux - Behavioral
-- Project Name: conv_mux
-- Target Devices: 
-- Tool Versions: 
-- Description: Perform convolution with a kernel of size 10 having only two
-- multipliers and an adder.
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

entity conv_mux is
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
end conv_mux;

architecture Behavioral of conv_mux is
    signal sel : unsigned(3 downto 0) := (others => '0');
    signal par_sel : std_logic := '0';
begin
    process(clk, reset, x, h)
        variable x_even, x_odd, h_even, h_odd, acc, prod : signed(bit_width-1 downto 0) := (others => '0');
    begin
        y <= (others => '0');
        if rising_edge(clk) and reset = '0' then
            case sel is
                when "0000" =>
                    x_even := x(0);
                    h_even := h(0);
                when "0001" =>
                    x_odd := x(1);
                    h_odd := h(1);
                when "0010" =>
                    x_even := x(2);
                    h_even := h(2);
                when "0011" =>
                    x_odd := x(3);
                    h_odd := h(3);
                when "0100" =>
                    x_even := x(4);
                    h_even := h(4);
                when "0101" =>
                    x_odd := x(5);
                    h_odd := h(5);
                when "0110" =>
                    x_even := x(6);
                    h_even := h(6);
                when "0111" =>
                    x_odd := x(7);
                    h_odd := h(7);
                when "1000" =>
                    x_even := x(8);
                    h_even := h(8);
                when "1001" =>
                    x_odd := x(9);
                    h_odd := h(9);
                when others =>
            end case;
            case par_sel is
                when '0' => prod := resize(x_even*h_even, bit_width);
                when '1' => prod := resize(x_odd*h_odd, bit_width);
                when others =>
            end case;
            acc := acc + prod;
            sel <= sel + "0001";
            par_sel <= par_sel xor '1';
            y <= acc;
            if sel = "1001" then
                sel <= "0000";
                acc := (others => '0');
            end if;
        end if;
    end process;
end Behavioral;
