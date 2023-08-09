`timescale 1ns / 1ps

module instruction_memory #(parameter addr_width = 32 , data_width = 32) (address, instruction, address_plus_4);
    input [addr_width-1:0] address;
    output [data_width-1:0] instruction;
    output [addr_width-1:0] address_plus_4; //분기가 없을 때 다음 address PC로 사용 됨

    wire [data_width-1:0] instruction;
    wire [addr_width-1:0] address_plus_4;
    
    reg [7:0] memory [31:0]; //32byte 크기의 메모리
    initial begin
        $readmemb("memory.mem", memory); // 메모리를 초기화 함수 시뮬레이션 전용
        //리틀엔디안 메모리 데이터 저장 방식 낮은주소에 낮은 바이트 LSB를 순서대로 저장하는 방식 
    end
    assign instruction = {memory[address*4 + 3], memory[address*4 + 2], memory[address*4 + 1], memory[address*4]}; // 워드를 바이트 단위로 읽어 merge
    assign address_plus_4 = address + 1;
endmodule
