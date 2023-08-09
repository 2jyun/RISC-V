`timescale 1ns / 1ps

//ALU Logic
module ALU_32bit #(parameter bitwidth = 32) (operand_A,operand_B,ALUSrc,immediate,ALUOp,ALU_Result,zero,less_than, less_than_unsigned, greater_than, greater_than_or_equal, greater_than_or_equal_unsigned);

    input [bitwidth-1:0] operand_A;
    input [bitwidth-1:0] operand_B;
    input [bitwidth-1:0] immediate;
    input ALUSrc;
    input [3:0] ALUOp;

    output [bitwidth-1:0] ALU_Result; 
    output zero, less_than, less_than_unsigned, greater_than, greater_than_or_equal, greater_than_or_equal_unsigned;

    wire [bitwidth-1:0] Value_B;

    reg [bitwidth-1:0] ALU_Result;
    reg zero, less_than, less_than_unsigned, greater_than, greater_than_or_equal, greater_than_or_equal_unsigned;

    assign Value_B = ALUSrc ? immediate : operand_B; //ALUSrc Flag가 HIGH 신호이면 연산자B는 즉시값으로 변환

    always@(*) begin
        zero = 0; //Default Value
        less_than = 0;
        less_than_unsigned = 0; // less_than_unsigned flag
        greater_than = 0; // greater_than flag
        greater_than_or_equal = 0; // greater_than_or_equal flag
        greater_than_or_equal_unsigned = 0; // greater_than_or_equal_unsigned flag
        case (ALUOp)
            4'b0000 : ALU_Result = operand_A + Value_B; //ADD
            4'b0001 : ALU_Result = operand_A - Value_B; //SUB
            4'b0010 : ALU_Result = operand_A & Value_B; //AND
            4'b0011 : ALU_Result = operand_A | Value_B; //OR
            4'b0100 : ALU_Result = operand_A ^ Value_B; //XOR
            4'b0101 : ALU_Result = operand_A < Value_B ? 32'b1 : 32'b0; //SLT Set if Less then 레지스터 값 비교
            4'b1010 : begin // SLTU (Set if Less Than Unsigned)
                            ALU_Result <= ($unsigned(operand_A) < $unsigned(Value_B)) ? 32'b1 : 32'b0;
                            less_than_unsigned <= (ALU_Result == 1) ? 1'b1 : 1'b0;
                      end
            4'b1011 : begin // BGEU (Branch if Greater Than or Equal Unsigned)
                            ALU_Result <= ($unsigned(operand_A) >= $unsigned(Value_B)) ? 32'b1 : 32'b0;
                            greater_than_or_equal_unsigned <= (ALU_Result == 1) ? 1'b1 : 1'b0;
                      end          
            4'b0110 : ALU_Result = operand_A >> Value_B; //SRL >>>는 산술 쉬프트 연산 >>은 논리 쉬프트 연산
            4'b0111 : ALU_Result = operand_A << Value_B; //SLL Shift Left Logical.
            4'b1001 : ALU_Result = {$signed(operand_A) >>> Value_B}; //SRA $signed는 MSB(부호비트)유지하고 쉬프트
            default : ALU_Result = 0;
       endcase
       if (ALUOp == 4'b0001) begin // SUB
            zero = (ALU_Result == 8'h00000000) ? 1'b1 : 1'b0; // zero flag
            less_than = (ALU_Result[bitwidth-1] == 1) ? 1'b1 : 1'b0; // less_than flag
            greater_than = (ALU_Result[bitwidth-1] == 0 && ALU_Result != 0) ? 1'b1 : 1'b0; // greater_than flag
            greater_than_or_equal = (ALU_Result[bitwidth-1] == 0) ? 1'b1 : 1'b0; // greater_than_or_equal flag
       end
       else begin
            zero = 0;
            less_than = 0;
            less_than_unsigned = 0; // less_than_unsigned flag
            greater_than = 0; // greater_than flag
            greater_than_or_equal = 0; // greater_than_or_equal flag
       end
   end
   //0verflow, Negative, carry_out Flags 미구현 
endmodule
