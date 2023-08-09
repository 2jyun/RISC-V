`timescale 1ns / 1ps

module Register_File #(parameter bitwidth = 32)(clk, write_enable, rd, write_data, rs1, rs2, operand_A, operand_B);
    input clk;
    input write_enable; //reg_write�� �Է����� ����
    input [bitwidth-1:0] write_data;
    input [4:0] rd;
    input [4:0] rs1;    
    input [4:0] rs2;

    output [bitwidth-1:0] operand_A;
    output[bitwidth-1:0] operand_B;
    
    reg [bitwidth-1:0] operand_A;
    reg [bitwidth-1:0] operand_B;
    reg [bitwidth-1:0] registers [31:0]; //32��Ʈũ���� register�� �迭 32���� ����

    always@(*)begin
       operand_A = registers[rs1];
       operand_B = registers[rs2];
       registers[0]=0; // x0�� �׻� 0���� �ʱ�ȭ
    end
    always @(posedge clk) begin
        if (write_enable && rd != 0) begin
            registers[rd] <= write_data;
        end
    end 
endmodule
