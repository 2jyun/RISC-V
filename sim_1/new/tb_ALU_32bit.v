`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/09 16:58:50
// Design Name: 
// Module Name: tb_ALU_32bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ALU_32bit(
    );
    reg [31:0] operand_A, operand_B, immediate;
    reg [3:0] ALUOp;
    reg ALUSrc;
    wire [31:0] ALU_Result_ALU;
    ALU_32bit U2 (.operand_A(operand_A), .operand_B(operand_B), .ALUOp(ALUOp), 
    .ALU_Result(ALU_Result_ALU), .zero(zero), .ALUSrc(ALUSrc), .immediate(immediate),
    .less_than(less_than), .less_than_unsigned(less_than_unsigned), .greater_than(greater_than),
    .greater_than_or_equal(greater_than_or_equal), .greater_than_or_equal_unsigned(greater_than_or_equal_unsigned));
    initial begin
            operand_A <= 0;
            operand_B <= 0;
            immediate <= 0;
        #10 operand_A = 32'h00000001;
            operand_B = 32'h00000003;  
            immediate = 32'h00000001;
    end
    initial begin
        #10 ALUOp <= 4'b0000;
        #20 ALUOp <= 4'b0001;
        #20 ALUOp <= 4'b1010;
        #20 ALUOp <= 4'b1011;
        #20 ALUOp <= 4'b0111;
        #20 ALUOp <= 4'b1001;
        #20 $finish;
    end
    initial begin
        ALUSrc <= 0;
        #20 ALUSrc <= 1;
        #10 ALUSrc <= 0;
    end

endmodule
