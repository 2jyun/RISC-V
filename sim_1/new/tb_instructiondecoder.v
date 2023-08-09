`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 12:44:29
// Design Name: 
// Module Name: tb_instructiondecoder
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


module tb_instructiondecoder();
    reg [31:0]instruction;
    wire [6:0]opcode, funct7;
    wire [4:0]rd,rs1,rs2;
    wire [2:0]funct3;
    instructiondecoder U0 (.instruction(instruction), .opcode(opcode),
     .funct7(funct7), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2));
    initial begin
        instruction=32'b0100000_00110_00101_000_01010_0110011;
        #100;
        $finish;
    end
endmodule
