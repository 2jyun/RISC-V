`timescale 1ns / 1ps

module RISCV_tb;
    parameter bitwidth =32;
    reg clk;
    reg rst;
    wire [bitwidth-1:0] instruction;
    wire [bitwidth-1:0] ALU_Result;
    wire [bitwidth-1:0] PC;
    wire [bitwidth-1:0] immediate, operand_A,operand_B;
    wire [bitwidth-1:0] ALU_Result_reg,address;
    wire [4:0] rd,rs2;
    wire [3:0] byte_enable;
    wire ALUSrc,RegWrite, MemRead,MemWrite,branch;
    // Instantiate the Unit Under Test (UUT)
    RISCV_architecture uut (
        .instruction(instruction), .clk(clk), .rst(rst), .ALU_Result(ALU_Result), .PC(PC), .immediate(immediate), .ALUSrc(ALUSrc), .operand_A(operand_A),
        .operand_B(operand_B), .ALU_Result_reg(ALU_Result_reg), .address(address), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
        .branch(branch), .rd(rd), .rs2(rs2),.byte_enable(byte_enable)
    );

    initial begin
        //Default Value
        clk = 0;
        rst = 0;

        #15;
        rst = 1;
        #10
        rst = 0;
        repeat (6) @(posedge clk);
        $finish;
    end
    always begin
        #10 clk = ~clk;
    end

endmodule