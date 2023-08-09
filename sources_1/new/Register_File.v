`timescale 1ns / 1ps

module Register_File #(parameter bitwidth = 32)(clk, write_enable, rd, write_data, rs1, rs2, operand_A, operand_B);
    input clk;
    input write_enable; //reg_write를 입력으로 받음
    input [bitwidth-1:0] write_data;
    input [4:0] rd;
    input [4:0] rs1;    
    input [4:0] rs2;

    output [bitwidth-1:0] operand_A;
    output[bitwidth-1:0] operand_B;
    
    reg [bitwidth-1:0] operand_A;
    reg [bitwidth-1:0] operand_B;
    reg [bitwidth-1:0] registers [31:0]; //32비트크기의 register를 배열 32개로 선언

    always@(*)begin
       operand_A = registers[rs1];
       operand_B = registers[rs2];
       registers[0]=0; // x0은 항상 0으로 초기화
    end
    always @(posedge clk) begin
        if (write_enable && rd != 0) begin
            registers[rd] <= write_data;
        end
    end 
endmodule
