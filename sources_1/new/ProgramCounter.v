`timescale 1ns / 1ps

module ProgramCounter #(parameter bitwidth = 32) (clk, rst, pc_plus_4, branch_decision,branch_target, PC);
    input clk;
    input rst;
    input [bitwidth-1:0] pc_plus_4;
    input [bitwidth-1:0] branch_target;
    input branch_decision;

    output [bitwidth-1:0] PC;

    wire [bitwidth-1:0] pc_plus_4;
    wire [bitwidth-1:0] branch_target; 

    reg [bitwidth-1:0] PC;

    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            PC <= 32'b0; //리셋시 PC를 초기화
        end
        else if (branch_decision) begin //prototype (분기명령에 따른 실행 logic은 구현되지 않음)
            PC <= branch_target;
        end
        else begin
            PC <= pc_plus_4;
        end
    end
endmodule
