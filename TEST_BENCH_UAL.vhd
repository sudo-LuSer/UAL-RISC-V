library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity UAL_TB is
end UAL_TB;

architecture Behavioral of UAL_TB is
    -- Component Declaration for the ALU
    component UAL is
        Port(
            A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            F : in std_logic_vector(3 downto 0);
            result : out std_logic_vector(7 downto 0);
            carry : inout std_logic;
            overflow : out std_logic;
            zero : out std_logic
        );
    end component;

    -- Signals for Testbench
    signal A_tb, B_tb : std_logic_vector(7 downto 0);
    signal F_tb : std_logic_vector(3 downto 0);
    signal result_tb : std_logic_vector(7 downto 0);
    signal carry_tb : std_logic;
    signal overflow_tb : std_logic;
    signal zero_tb : std_logic;

begin
    -- Instantiate the ALU
    UUT: UAL
        port map(
            A => A_tb,
            B => B_tb,
            F => F_tb,
            result => result_tb,
            carry => carry_tb,
            overflow => overflow_tb,
            zero => zero_tb
        );

    -- Test Process
    process
    begin
        -- Test Case 1: XOR Operation (F = "0000")
        A_tb <= "11001100";
        B_tb <= "10101010";
        F_tb <= "0000";
        wait for 10 ns;
        assert result_tb = "01100110" report "XOR Operation Failed" severity error;

        -- Test Case 2: OR Operation (F = "0001")
        A_tb <= "11001100";
        B_tb <= "10101010";
        F_tb <= "0001";
        wait for 10 ns;
        assert result_tb = "11101110" report "OR Operation Failed" severity error;

        -- Test Case 3: AND Operation (F = "0010")
        A_tb <= "11001100";
        B_tb <= "10101010";
        F_tb <= "0010";
        wait for 10 ns;
        assert result_tb = "10001000" report "AND Operation Failed" severity error;

        -- Test Case 4: ADD Operation (F = "0011")
        A_tb <= "00001111";
        B_tb <= "00000001";
        F_tb <= "0011";
        wait for 10 ns;
        assert result_tb = "00010000" report "ADD Operation Failed" severity error;

        -- Test Case 5: NOT Operation (F = "0100")
        A_tb <= "11001100";
        B_tb <= "10101010"; -- B is ignored for NOT operation
        F_tb <= "0100";
        wait for 10 ns;
        assert result_tb = "00110011" report "NOT Operation Failed" severity error;

        -- Test Case 6: SLL Operation (F = "0101")
        A_tb <= "00000001";
        B_tb <= "00000011"; -- Shift left by 3
        F_tb <= "0101";
        wait for 10 ns;
        assert result_tb = "00001000" report "SLL Operation Failed" severity error;

        -- Test Case 7: ADD with Carry (F = "0110")
        A_tb <= "00001111";
        carry_tb <= '1';
        F_tb <= "0110";
        wait for 10 ns;
        assert result_tb = "00010000" report "ADD with Carry Operation Failed" severity error;

        -- Test Case 8: SUB Operation (F = "0111")
        A_tb <= "00010000";
        B_tb <= "00000001";
        F_tb <= "0111";
        wait for 10 ns;
        assert result_tb = "00001111" report "SUB Operation Failed" severity error;

        -- Test Case 9: NEG Operation (F = "1000")
        A_tb <= "00000001";
        F_tb <= "1000";
        wait for 10 ns;
        assert result_tb = "11111111" report "NEG Operation Failed" severity error;

        -- Test Case 10: SUB with Carry (F = "1001")
        A_tb <= "00010000";
        B_tb <= "00000001";
        carry_tb <= '1';
        F_tb <= "1001";
        wait for 10 ns;
        assert result_tb = "00001110" report "SUB with Carry Operation Failed" severity error;

        -- Test Case 11: SLL by Carry (F = "1010")
        A_tb <= "00000001";
        carry_tb <= '1';
        F_tb <= "1010";
        wait for 10 ns;
        assert result_tb = "00000010" report "SLL by Carry Operation Failed" severity error;

        -- Test Case 12: SRL Operation (F = "1011")
        A_tb <= "10000000";
        B_tb <= "00000011"; -- Shift right by 3
        F_tb <= "1011";
        wait for 10 ns;
        assert result_tb = "00010000" report "SRL Operation Failed" severity error;

        -- Test Case 13: SRA Operation (F = "1100")
        A_tb <= "10000000";
        B_tb <= "00000011"; -- Shift right by 3
        F_tb <= "1100";
        wait for 10 ns;
        assert result_tb = "11110000" report "SRA Operation Failed" severity error;

        -- Test Case 14: SRL by Carry (F = "1101")
        A_tb <= "10000000";
        carry_tb <= '1';
        F_tb <= "1101";
        wait for 10 ns;
        assert result_tb = "01000000" report "SRL by Carry Operation Failed" severity error;

        -- End of Test
        wait;
    end process;
end Behavioral;