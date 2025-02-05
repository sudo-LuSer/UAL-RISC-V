# 8-Bit Arithmetic Logic Unit (ALU) in VHDL

This repository contains a VHDL implementation of an 8-bit Arithmetic Logic Unit (ALU). The ALU is designed to perform various arithmetic and logical operations on two 8-bit inputs and generate an 8-bit result along with status flags (carry, overflow, and zero).

## Features
- **Supported Operations**:
  - Bitwise operations: AND, OR, XOR, NOT
  - Arithmetic operations: Addition, Subtraction, Negation
  - Shift operations: Logical Left Shift (SLL), Logical Right Shift (SRL), Arithmetic Right Shift (SRA)
- **Status Flags**:
  - **Carry**: Indicates a carry-out from the most significant bit (MSB) during arithmetic operations.
  - **Overflow**: Indicates signed arithmetic overflow.
  - **Zero**: Indicates if the result is zero.
- **Configurable Operation Code**: A 4-bit control signal (`F`) selects the operation to be performed.

## VHDL Code Structure
The design consists of the following components:
- **Entity**: `UAL`
  - Inputs: `A`, `B` (8-bit operands), `F` (4-bit operation code), `carry` (input carry for certain operations).
  - Outputs: `result` (8-bit result), `carry`, `overflow`, `zero` (status flags).
- **Architecture**: `RISC_V`
  - Implements the ALU logic using a `case` statement to handle different operations.
  - Calculates status flags based on the result of the operation.

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/sudo-LuSer/UAL-RISC-V.git
   cd UAL-RISC-V
