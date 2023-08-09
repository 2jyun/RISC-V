`timescale 1ns / 1ps


module immediate_generator #(parameter bitwidth = 32)(instruction, immediate);
    input [bitwidth-1:0] instruction;
    output [bitwidth-1:0] immediate;

    reg [bitwidth-1:0] immediate;
    reg [6:0]opcode;
    
    always@(*) begin
        opcode  = instruction[6:0];
        case (opcode)
            7'b0010011, 7'b0000011 : immediate =  { {12{instruction[31]}}, instruction[31:20] }; //I-type sign extenstion
            7'b0100011 : immediate =  { {20{instruction[31]}}, instruction[31:25], instruction[11:7] }; // S-type sign extension
            7'b1100011 : immediate = { {19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 }; 
            // B-type 1'b0 는 immediate 필드의 가장 낮은 비트로, 항상 0이다  이는 분기 목적지가 항상 2의 배수여야 하기 떄문이다.
            7'b0110111, 7'b0010111 : immediate = { {19{instruction[31]}}, instruction[31:12] }; //U-type
            7'b1101111 : immediate = { {12{instruction[31]}}, instruction[31], instruction[30:21], instruction[20], instruction[19:12] }; //J-type
            default : immediate = 0; //default 값을 사용함으로써 combinational logic을 구성 즉 래치를 안생기게 하기 위함
        endcase
    end
endmodule
