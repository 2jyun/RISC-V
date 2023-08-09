`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 14:47:43
// Design Name: 
// Module Name: tb_instruction_memory
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


module tb_instruction_memory();
    parameter bitwidth = 32;
    reg [bitwidth-1:0] address;
    wire [bitwidth-1:0] instruction;
    wire [31:0] address_plus_4;
    integer i;
    instruction_memory U11 (.address(address), .instruction(instruction), .address_plus_4(address_plus_4));
    //분기가 없을 때 다음 address PC로 사용 됨 ( 분기 구현 X)
    initial begin
        address = 0;
        for(i=0; i<5; i=i+1)begin
            #100;
            address = address + 1;    
        end
        #100 $finish;
    end 
endmodule
