`timescale 1ns / 1ps

module Data_Memory #(parameter bitwidth = 32) (clk, write_enable, byte_enable, read_enable, address, write_data, read_data);
    input clk;
    input write_enable;
    input [3:0] byte_enable; //데이터를 읽을 때 byte_enable의 크기 만큼 메모리를 읽어옴
    input read_enable;
    input [bitwidth-1:0] address;
    input [bitwidth-1:0] write_data;

    output [bitwidth-1:0] read_data;

    wire [3:0] byte_enable;
    
    reg [bitwidth-1:0] read_data;
    reg [7:0] memory [31:0]; // 32바이트 크기의 메모리
    
    integer i;

    always @(posedge clk) begin 
        if (write_enable) begin
            for (i = 0; i < 4; i = i + 1) begin
                if (byte_enable[i]) begin //address 1개당 8bit 저장하기 위함
                    memory[address*4 + i] = write_data[i*8 +: 8]; // 특정 바이트 쓰기 +:은 비트를 쪼갠다는 뜻
                end//adress*4는 메모리주소를 32비트 워드로 업스케일링하는 것 ex.) 
                   //0번째 주소는 0,1,2,3번째 바이트를 가르킨다.
                   //필요한 byte 크기 만큼 read_data와 OR연산하여 쓰기
            end
        end
    end 
     always @(*) begin 
        if (read_enable) begin
            read_data = 8'h00000000; //default value
            for (i = 0; i < 4; i = i + 1) begin
                if (byte_enable[i]) begin
                    read_data = read_data | (memory[address*4 + i] << (i*8));
                    //메모리 데이터를 읽어와 각 바이트에 맞게 메모리 값을 읽고 read_data의 자리에 맞게 쉬프트 시키고 값을
                end //넣는다.
            end
        end
    end
endmodule
