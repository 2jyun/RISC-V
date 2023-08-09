`timescale 1ns / 1ps

module instruction_memory #(parameter addr_width = 32 , data_width = 32) (address, instruction, address_plus_4);
    input [addr_width-1:0] address;
    output [data_width-1:0] instruction;
    output [addr_width-1:0] address_plus_4; //�бⰡ ���� �� ���� address PC�� ��� ��

    wire [data_width-1:0] instruction;
    wire [addr_width-1:0] address_plus_4;
    
    reg [7:0] memory [31:0]; //32byte ũ���� �޸�
    initial begin
        $readmemb("memory.mem", memory); // �޸𸮸� �ʱ�ȭ �Լ� �ùķ��̼� ����
        //��Ʋ����� �޸� ������ ���� ��� �����ּҿ� ���� ����Ʈ LSB�� ������� �����ϴ� ��� 
    end
    assign instruction = {memory[address*4 + 3], memory[address*4 + 2], memory[address*4 + 1], memory[address*4]}; // ���带 ����Ʈ ������ �о� merge
    assign address_plus_4 = address + 1;
endmodule
