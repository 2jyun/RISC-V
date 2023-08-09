`timescale 1ns / 1ps
//�ý��� ��ɾ� ������ / ���α׷��� �����ϰų�, �ý��� ȣ���� �����ϰų�, ���μ����� Ư�� ���¸� �аų� ���� ���� �۾��� �����ϴ� �۾� �ȵ�
//Countrol Unit
module Control_Unit #(parameter bitwidth = 32) (opcode, funct3, funct7, zero, less_than, less_than_unsigned, greater_than, greater_than_or_equal, greater_than_or_equal_unsigned, RegWrite,MemRead,MemWrite,
    branch,ALUOp,ALUSrc, byte_enable);
    input [6:0] opcode; 
    input [2:0] funct3;
    input [6:0] funct7;
    input zero;
    input less_than;
    input less_than_unsigned;
    input greater_than;
    input greater_than_or_equal;
    input greater_than_or_equal_unsigned;
    output RegWrite;
    output MemRead;
    output MemWrite;
    output branch;
    output [3:0] ALUOp;
    output ALUSrc;
    output [3:0] byte_enable;

    reg RegWrite;
    reg MemRead;
    reg MemWrite;
    reg branch;
    reg [3:0] ALUOp;
    reg ALUSrc;
    reg [3:0] byte_enable;

    always@(*) begin
        ALUOp = 4'b0000; //Default value
        ALUSrc = 0;
        MemRead = 0;
        MemWrite =0;
        RegWrite =0;
        byte_enable =0;
        if(opcode == 7'b0110011) begin //R-type Instruction 
            case (funct3)
                3'b000 : if(funct7 == 7'b000_0000) begin // add or sub
                            ALUOp = 4'b0000;
                            RegWrite = 1;
                         end
                         else if(funct7 == 7'b010_0000) begin
                            ALUOp = 4'b0001;
                            RegWrite = 1; 
                         end
                3'b001 : begin
                            ALUOp = 4'b0111;  //SLL
                            RegWrite = 1;
                         end
                3'b010 : begin
                            ALUOp = 4'b0101; //SLT
                            RegWrite = 1;
                         end
                3'b011 : begin
                            ALUOp = 4'b1010; //SLTU
                            RegWrite = 1;
                         end
                3'b100 : begin
                            ALUOp = 4'b0100; //XOR
                            RegWrite = 1;
                         end
                3'b101 : if(funct7 == 7'b000_0000) begin  
                            ALUOp = 4'b0110; //SRL
                            RegWrite = 1;
                         end
                         else if(funct7 == 7'b0100000) begin
                            ALUOp = 4'b1001; // SRA
                            RegWrite = 1;
                         end
                3'b110 : begin
                            ALUOp = 4'b0011; // OR
                            RegWrite = 1;
                         end
                3'b111 : begin
                            ALUOp = 4'b0010; // AND
                         end
            endcase
        end
        if(opcode == 7'b0000011) begin //I-Type LOAD Instruction
            case (funct3)
                3'b000 : begin //LB
                    ALUOp = 4'b0000; 
                    ALUSrc = 1;
                    MemRead = 1; // �޸� �бⰡ �ʿ��ϹǷ� 1
                    RegWrite = 1; // ����� �������Ϳ� ���Ƿ� 1
                    byte_enable = 4'b0001;
                end
                3'b001 : begin //LH
                    ALUOp = 4'b0000; 
                    ALUSrc = 1;
                    MemRead = 1; 
                    RegWrite = 1;
                    byte_enable = 4'b0011;
                end
                3'b010 : begin //LW
                    ALUOp = 4'b0000; 
                    ALUSrc = 1;
                    MemRead = 1;
                    RegWrite = 1;
                    byte_enable = 4'b1111;
                end
                default : begin
                    ALUOp = 4'b0000;
                    ALUSrc = 0;
                    MemRead = 0;
                    RegWrite = 0;
                end
            endcase
        end
        if(opcode == 7'b0010011) begin //I-Type Instruction
            case (funct3)
                3'b000 : begin //ADDI
                    ALUOp = 4'b0000; 
                    ALUSrc = 1;
                    RegWrite = 1;
                end
                3'b010 : begin //SLTI
                    ALUOp = 4'b0101;
                    ALUSrc = 1;
                    RegWrite = 1;
                end
                3'b011 : begin //SLTIU
                    ALUOp = 4'b0100;
                    ALUSrc =1;
                    RegWrite = 1;
                end
                3'b100 : begin //XORI
                    ALUOp = 4'b0100;
                    ALUSrc =1;
                    RegWrite = 1;
                end
                3'b110 : begin //ORI
                    ALUOp = 4'b0011;
                    ALUSrc =1;
                    RegWrite = 1;
                end
                3'b111 : begin //ANDI
                    ALUOp = 4'b0010;
                    ALUSrc =1;
                    RegWrite = 1;
                end
                3'b001 : begin //SLLI
                    if(funct7 == 7'b000_000) begin
                        ALUOp = 4'b0111;
                        ALUSrc = 1;
                        RegWrite = 1;
                    end
                end
                3'b101 : begin //SRLI
                    if(funct7 == 7'b000_0000) begin
                        ALUOp = 4'b0110;
                        ALUSrc = 1;
                        RegWrite = 1;
                    end
                    else if(funct7 == 7'b010_0000) begin
                        ALUOp = 4'b1001;
                        ALUSrc = 1;
                        RegWrite = 1;
                    end
                end
                default : begin
                    ALUOp = 4'b0000;
                    ALUSrc = 0;
                    RegWrite = 0;
                end
            endcase
        end
        if(opcode == 7'b0100011) begin // S-type Instruction
            case(funct3) 
                3'b000 : begin
                            ALUOp = 4'b0000; //ADD
                            MemWrite = 1; //SB Store Byte ������ġ������ ���еǾ����� �ʰ� �޸� �������̽��� ���� ó��
                            byte_enable = 4'b0001;
                            ALUSrc = 1;
                         end
                3'b001 : begin
                            MemWrite = 1; //SH Store half word 
                            byte_enable = 4'b0011;
                            ALUSrc = 1;
                            MemWrite = 1;
                         end
                3'b010 : begin
                            MemWrite = 1; //SW store word
                            byte_enable = 4'b1111;
                            ALUSrc = 1;
                            MemWrite = 1;
                         end
                default : MemWrite =0;
           endcase
        end
        if(opcode == 7'b1100011) begin // B-type Instruction �б� ��ɾ�
            case(funct3)
                3'b000 : begin // BEQ(branch if Equal)
                    ALUOp = 4'b0001; //SUB
                end
                3'b001 : begin //BNE(branch if not Equal)
                    ALUOp = 4'b0001; //SUB
                end
                3'b100 : begin //BLT (branch if Less than)
                    ALUOp = 4'b0001; //SUB
                end
                3'b101 : begin //BGE (branch if Greater Than or Equal)
                    ALUOp = 4'b0001; //SUB
                end
                3'b110 : begin //BLTU (branch if Less Than, Unsigned
                    ALUOp = 4'b1010; //SLTU
                end
                3'b111 : begin //BGEU(Branch if Greater Than or Equal, Unsigned)
                    ALUOp = 4'b1010; //SLTU
                end
                default : begin
                    ALUOp = 4'b0000;
                end
            endcase
         end
            //B-type ��ɾ��� ���, ���� ��ġ�� ALU�� ���� ������ �����ϵ��� �����ϴ� ALUOp�� ����
            // �׸��� ALU�� ���(zero)�� �ؼ� �Ͽ� �б⸦ �������� �����ϴ� ������ ���� ��ġ�� ����
            //�� ALU�� ������� �ҷ��ͼ� �� �Ǵ�.
        //U-type Instruction ��������� ū ����� �������Ϳ� �ε��ϰų� PC ������� �ּҸ� ����ϴµ� ���
        if(opcode == 7'b0110111) begin  //LUI (Load Upper Immediate) ��ð��� ���������� 
                                        //���� 20��Ʈ�� �ε��ϰ�, ������ ���� ��Ʈ�� 0���� ����
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 4'bxxxx;
            //ALUOp ����
        end
        else if(opcode == 7'b0010111) begin //AUIPC(Add Upper immediate to PC) ��ð��� PC�� ���� �� ����� �������Ϳ� ����
            //AUIPC�� PC�� ��ð��� ���� ����� �������Ϳ� �����ϹǷ�  ADD ���
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 4'b0000; //ADD
        end
        //J-type instruction
        if(opcode == 7'b1101111) begin // JAL
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 4'b0000; // ADD
        end
        else if(opcode == 7'b1100111 && funct3 == 3'b000) begin // JALR
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 4'b0000; // ADD
        end
    end
    //Branch Decision Logic
    always @(*) begin
    branch = 0;
    if(opcode == 7'b1100011) begin
        case(funct3)
            3'b000 : if (zero == 1) branch = 1; // Branch if equal
            3'b001 : if (zero == 0) branch = 1; // Branch if not equal
            3'b100 : if (less_than == 1) branch = 1; // Branch if less than
            3'b101 : if (greater_than_or_equal == 1) branch = 1; // Branch if greater than or equal
            3'b110 : if (less_than_unsigned == 1) branch = 1; // Branch if less than unsigned
            3'b111 : if (greater_than_or_equal_unsigned == 1) branch = 1; // Branch if greater than or equal unsigned
            default: branch = 0;
        endcase
   end
end
endmodule