library IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 

entity UAL is
    Port( 
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        F : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(7 downto 0); 
        carry : inout std_logic;
        overflow : out std_logic; 
        zero : out std_logic
    );
end UAL; 

architecture RISC_V of UAL is

    signal temp : std_logic_vector(8 downto 0) := (others => '0');
    signal temp_result : std_logic_vector(7 downto 0) := (others => '0');
    signal temp_carry : std_logic := '0';
    signal temp_overflow : std_logic := '0';
    signal temp_zero : std_logic := '0';

begin 

    -- Arithmetic and Logic Operations
    process(A, B, F, carry)
    begin
        case F is 
            when "0000" =>
                temp <= '0' & (unsigned(A) xor unsigned(B)); 
            when "0001" =>
                temp <= '0' & (unsigned(A) OR unsigned(B)); 
            when "0010" => 
                temp <= '0' & (unsigned(A) AND unsigned(B)); 
            when "0011" =>
                temp <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B)); 
            when "0100" => 
                temp <= '0' & (NOT unsigned(A)); 
            when "0101" =>
                temp <= '0' & std_logic_vector(unsigned(A) sll to_integer(unsigned(B(2 downto 0)))); 
            when "0110" =>
                temp <= std_logic_vector(unsigned('0' & A) + unsigned'('0' & carry)); 
            when "0111" =>
                temp <= std_logic_vector(unsigned('0' & A) - unsigned('0' & B)); 
            when "1000" =>
                temp <= std_logic_vector(unsigned'("00000000") - unsigned('0' & A)); 
            when "1001" => 
                temp <= std_logic_vector(unsigned('0' & A) - (unsigned('0' & B) + unsigned'('0' & carry)));
            when "1010" =>
                temp <= '0' & std_logic_vector(unsigned(A) sll to_integer(unsigned'('0' & carry))); 
            when "1011" =>
                temp <= '0' & std_logic_vector(unsigned(A) srl to_integer(unsigned(B(2 downto 0)))); 
            when "1100" =>
                temp <= '0' & std_logic_vector(unsigned(A) sra to_integer(unsigned(B(2 downto 0)))); 
            when "1101" =>
                temp <= '0' & std_logic_vector(unsigned(A) srl to_integer(unsigned'('0' & carry))); 
            when others =>
                temp <= (others => '0');
        end case;
    end process;

    -- Output the result
    temp_result <= temp(7 downto 0);
    result <= temp_result;

    -- Carry and Overflow Detection
    process(temp)
    begin
        temp_carry <= temp(8);
        
        -- Overflow detection for addition and subtraction
        if (F = "0011" or F = "0111" or F = "1001") then
            temp_overflow <= temp(8) xor temp(7);
        else
            temp_overflow <= '0';
        end if;
    end process;

    carry <= temp_carry;
    overflow <= temp_overflow;

    -- Zero Flag Detection
    process(temp_result)
    begin
        if (temp_result = "00000000") then
            temp_zero <= '1';
        else
            temp_zero <= '0';
        end if;
    end process;

    zero <= temp_zero;

end RISC_V;
    