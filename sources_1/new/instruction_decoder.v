`timescale 1ns / 1ps

module instructiondecoder #(parameter bitwidth = 32) (instruction, opcode, funct7,rd,funct3,rs1,rs2);
    input [bitwidth-1:0] instruction;
    output [6:0] opcode;
    output [6:0] funct7;
    output [4:0] rd;
    output [2:0] funct3;
    output [4:0] rs1;
    output [4:0] rs2;
    reg [6:0] opcode,funct7;
    reg [4:0] rd;
    reg [4:0] rs1, rs2;
    reg [2:0] funct3;
    //instruction를 여러개 출력으로 디코딩
    always@(*) begin
        opcode = instruction[6:0];
        rd = instruction[11:7];
        funct3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        funct7 = instruction[31:25];
    end
 endmodule
