`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 09:48:22
// Design Name: 
// Module Name: tb_ProgrmaCounter
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


module tb_ProgramCounter();
    parameter bitwidth = 32;
    reg clk, rst, branch_decision;
    wire [bitwidth-1:0] PC;
    reg [bitwidth-1:0] pc_plus_4; 
    reg [bitwidth-1:0] branch_target;
    ProgramCounter U10 (.clk(clk), .rst(rst), .pc_plus_4(pc_plus_4), 
    .branch_target(branch_target), .branch_decision(branch_decision), .PC(PC));
    initial begin
        clk = 0;
        rst = 0;
        pc_plus_4 =0;
        branch_decision = 0;
        branch_target = 8'h0000_0004;
        forever begin
            #10 clk = ~clk;
        end
    end
    initial begin
        #5 rst = ~rst;
        #20 rst = ~rst;
        #40 rst = ~rst;
        #20 rst = ~rst;
        #60 branch_decision = 1;
        #40 branch_decision = 0;
        #100 $finish;
    end
    always @(posedge clk) begin
        pc_plus_4 <= PC + 4;
    end
endmodule
