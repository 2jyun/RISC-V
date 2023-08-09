`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 01:02:03
// Design Name: 
// Module Name: tb_Control_Unit
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


module tb_Control_Unit();
    integer i;
    reg [6:0]opcode;
    reg [2:0]funct3;
    reg [6:0]funct7;
    reg zero;
    wire [3:0] ALUOp;
    wire RegWrite, MemRead, MemWrite, branch, ALUSrc;
    reg less_than, less_than_unsigned, greater_than,
        greater_than_or_equal, greater_than_or_equal_unsigned;
    Control_Unit U14 (.opcode(opcode), .funct3(funct3), .funct7(funct7),
     .zero(zero), .ALUOp(ALUOp), .RegWrite(RegWrite), .MemRead(MemRead),
     .MemWrite(MemWrite), .branch(branch), .ALUSrc(ALUSrc), .less_than(less_than),
     .less_than_unsigned(less_than_unsigned), .greater_than(greater_than),
     .greater_than_or_equal(greater_than_or_equal), .greater_than_or_equal_unsigned(greater_than_or_equal_unsigned));
    initial begin
        less_than = 0;
        less_than_unsigned = 0; 
        greater_than =0;
        greater_than_or_equal = 0;
         greater_than_or_equal_unsigned = 0;
    end
    initial begin
        opcode = 7'b0110011;
        funct3 = 3'b000;
        zero =0;
        funct7 = 7'b000_0000; //R-Type Instruction
        #100
        for(i=0; i<=3'b111; i= i+1) begin
            #100
            funct3 = funct3 + 3'b001;
        end
        funct3 = 0;
        
        opcode = 7'b0000011; // I-Type LOAD Insturcion
        for(i=0; i<=3'b011; i= i+1) begin
            #50;
            funct3 = funct3 + 3'b001;

        end
        funct3 = 0;
        
        opcode = 7'b0010011; // I-Type Instruction
        for(i=0; i<=3'b111; i= i+1) begin
            #100;
            funct3 = funct3 + 3'b001;
        end
        
        opcode = 7'b0100011; //S-Type Instruction
        funct3 = 0;
        for(i=0; i<=3'b010; i= i+1) begin
            #50;
            funct3 = funct3 + 3'b001;
        end
        
        opcode = 7'b1100011; //B-Type Instruction
        funct3 = 0;
        for(i=0; i<=3'b111; i= i+1) begin
            #50;
            funct3 = funct3 + 3'b001;
        end
       
       //U-Type Instruction 
        opcode = 7'b0110111;
        #50;
        opcode = 7'b0010111;
        #50;
        
        //J-Type Instruction
        opcode = 7'b1101111;
        #50;
        opcode = 7'b1100111;
        funct3 = 3'b000;
        #50;
        $finish;
    end
      
   always @(*)begin
       if(opcode == 7'b0110011)begin
           if(funct3 == 3'b000 || funct3 == 3'b101) begin
                #50 funct7 = 7'b010_0000;
                #50 funct7 = 7'b000_0000;
           end
       end
       if(opcode == 7'b0010011 && funct3 == 3'b101)begin //SRAI
           #50 funct7 = 7'b010_0000;
           #50 funct7 = 7'b000_0000;
       end
       else begin
          funct7 = 7'b000_0000;
       end
       if (opcode == 7'b1100011)begin //BEQ
          zero = 1;
       end
       else begin
          zero =0;
       end
   end
endmodule
