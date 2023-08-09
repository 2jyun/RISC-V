`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/13 01:22:58
// Design Name: 
// Module Name: tb_Data_Memory
// Project Name: 
// Target Devices:  : 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Data_Memory();
    reg clk, MemWrite, MemRead;
    reg [31:0] PC,ALU_Result_ALU;
    reg [3:0] byte_enable;
    wire [31:0] ALU_Result_Mem;
    Data_Memory U13 (.clk(clk), .write_enable(MemWrite), 
    .read_enable(MemRead), .address(PC), .write_data(ALU_Result_ALU), 
    .read_data(ALU_Result_Mem), .byte_enable(byte_enable));
    initial begin
        //초기값 설정
        clk <= 0; 
        MemRead <= 0;
        MemWrite <= 0; 
        byte_enable <= 1;
        PC <= 3; //메모리 주소 3
        ALU_Result_ALU <=5;
        #50;
        
        //메모리 데이터 쓰기
        MemWrite <= 1;
        #50;
        
        //메모리 데이터 읽기
        MemWrite <= 0;
        MemRead <= 1;
        #25 MemRead <=0;
        #100 $finish;
    end
    always  #25 clk = ~clk;
endmodule
