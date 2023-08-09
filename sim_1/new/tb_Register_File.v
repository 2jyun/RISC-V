`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 15:36:31
// Design Name: 
// Module Name: tb_Register_File
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


module tb_Register_File();
    reg clk;
    reg write_enable;
    reg [4:0] rd;
    reg [31:0] write_data;
    reg [4:0] rs1;
    reg [4:0] rs2;
    wire [31:0] operand_A;
    wire [31:0] operand_B;

    Register_File U12 (.clk(clk), .write_enable(write_enable), .rd(rd), 
        .write_data(write_data), .rs1(rs1), .rs2(rs2), .operand_A(operand_A), 
        .operand_B(operand_B)
    );
    
    initial begin
        clk <= 0; //초기값 설정 
        write_enable <= 0;
        rd <= 0;
        write_data <= 0;
        rs1 <= 0;
        rs2 <= 0;
        #50;

        write_enable <= 1; // x3 레지스터에 3 값 할당 
        rd <= 3;
        write_data <= 8;
        
        #50;
        write_enable <= 0; // x3 레지스터에 값을 읽음
        rs1 <= 3;
        #50;
        
        write_enable = 1;
        rd = 2; //x2 레지스터에 5 값 할당
        write_data = 5;
        #50;

        write_enable = 0; // x2의 레지스터에 값을 읽음
        rs2 = 2;
        #50;
        $finish;
    end
    always #25 clk = ~clk;
endmodule
