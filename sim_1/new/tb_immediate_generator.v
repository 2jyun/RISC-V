`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 19:18:43
// Design Name: 
// Module Name: tb_immediate_generator
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


module tb_immediate_generator();
    reg [31:0] instruction;
    wire [31:0] immediate;
    immediate_generator U1 (.instruction(instruction), .immediate(immediate));
    initial begin
        instruction = 32'b0000000_00000_00101_000_00101_0010011; // I-type
        #20;
        instruction = 32'b0000000_00110_00101_010_00000_0100011; // S-type
        #20;
        instruction = 32'b0000000_00110_00101_000_00101_1100011; // B-type
        #20;
        instruction = 32'b0000000_1111101000_00101_0110111; // U-type
        #20;
        instruction = 32'b0000000_1111101000_00101_1101111; // J-type
        #20;
        instruction = 0; // default
        #20;
        $finish;
    end
endmodule
