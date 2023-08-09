`timescale 1ns / 1ps

//instructions 

module RISCV_architecture #(parameter bitwidth = 32)(clk, rst, instruction, ALU_Result, PC, immediate, address, ALU_Result_reg, 
read_data, ALUSrc, RegWrite, MemRead, MemWrite, branch, operand_A, operand_B, rd, byte_enable, rs2);

    input clk;
    input rst;
    output [bitwidth-1:0] instruction;
    output [bitwidth-1:0] ALU_Result;
    output [bitwidth-1:0] PC;
    output [bitwidth-1:0] immediate;
    output [bitwidth-1:0] address; 
    output [bitwidth-1:0] ALU_Result_reg;
    output [bitwidth-1:0] read_data;
    output [bitwidth-1:0] operand_A; 
    output [bitwidth-1:0] operand_B;
    output [4:0] rd; 
    output [4:0] rs2;
    output [3:0] byte_enable;
    output ALUSrc;
    output RegWrite;
    output MemRead; 
    output MemWrite; 
    output branch;
    
    reg [bitwidth-1:0] operand_B_ALU;
    reg [bitwidth-1:0] operand_B_Mem;
    reg [bitwidth-1:0] address;
    reg [bitwidth-1:0] ALU_Result_reg;
    reg [bitwidth-1:0] read_data;
    wire [bitwidth-1:0] instruction;
    wire [bitwidth-1:0] ALU_Result;
    wire [bitwidth-1:0] PC;
    wire [bitwidth-1:0] immediate;
    wire [bitwidth-1:0] operand_A;
    wire [bitwidth-1:0] operand_B;
    wire [6:0] opcode, funct7;
    wire [4:0] rs1;
    wire [4:0] rd;
    wire [4:0] rs2;
    wire [3:0] ALUOp;
    wire [3:0] byte_enable;
    wire [2:0] funct3;
    wire ALUSrc; 
    wire RegWrite; 
    wire MemRead; 
    wire MemWrite;
    wire branch;
    wire zero;
    wire [bitwidth-1:0] pc_plus_4, branch_target;
    
    instructiondecoder U0 (.instruction(instruction), .opcode(opcode), .funct7(funct7), .funct3(funct3), .rs1(rs1), .rs2(rs2), .rd(rd));
    Control_Unit U1 (.opcode(opcode), .byte_enable(byte_enable), .funct3(funct3), .funct7(funct7), .zero(zero), .ALUOp(ALUOp), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .branch(branch), .ALUSrc(ALUSrc),
                     .less_than(less_than), .less_than_unsigned(less_than_unsigned), .greater_than(greater_than), .greater_than_or_equal(greater_than_or_equal), .greater_than_or_equal_unsigned(greater_than_or_equal_unsigned));
    ALU_32bit U2 (.operand_A(operand_A), .operand_B(operand_B_ALU), .ALUOp(ALUOp), .ALU_Result(ALU_Result), .zero(zero), .ALUSrc(ALUSrc), .immediate(immediate),
                   .less_than(less_than), .less_than_unsigned(less_than_unsigned), .greater_than(greater_than), .greater_than_or_equal(greater_than_or_equal), .greater_than_or_equal_unsigned(greater_than_or_equal_unsigned));
    ProgramCounter U3 (.clk(clk), .rst(rst), .pc_plus_4(pc_plus_4), .branch_target(branch_target), .branch_decision(branch), .PC(PC));
    Register_File U4 (.clk(clk), .write_enable(RegWrite), .rd(rd), .write_data(ALU_Result_reg), .rs1(rs1), .rs2(rs2), .operand_A(operand_A), .operand_B(operand_B));
    Data_Memory U5 (.clk(clk), .write_enable(MemWrite), .read_enable(MemRead), .address(address), .write_data(operand_B_Mem), .read_data(read_data), .byte_enable(byte_enable));
    instruction_memory U6 (.address(PC), .instruction(instruction), .address_plus_4(pc_plus_4));
    immediate_generator U7 (.instruction(instruction), .immediate(immediate));

    always @(*) begin
        if(opcode == 7'b0100011) begin //S-type Instruction port
            address = ALU_Result;
            operand_B_Mem = operand_B;
            ALU_Result_reg = 0;
            operand_B_ALU = 0;
        end
        else if(opcode == 7'b0000011)begin //I-type Instruction port
            address = ALU_Result;
            ALU_Result_reg = read_data;
            operand_B_Mem = 0;
            operand_B_ALU = operand_B;
        end
        else if(opcode != 7'b0000011)begin // Other instruction port
            ALU_Result_reg = ALU_Result;
            operand_B_ALU = operand_B;
            address = 0;
            operand_B_Mem = 0;
        end
        else begin
            address = 0;
            operand_B_Mem = 0;
            ALU_Result_reg = 0;
            operand_B_ALU = 0;
        end
    end
endmodule
