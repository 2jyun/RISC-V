`timescale 1ns / 1ps

module Data_Memory #(parameter bitwidth = 32) (clk, write_enable, byte_enable, read_enable, address, write_data, read_data);
    input clk;
    input write_enable;
    input [3:0] byte_enable; //�����͸� ���� �� byte_enable�� ũ�� ��ŭ �޸𸮸� �о��
    input read_enable;
    input [bitwidth-1:0] address;
    input [bitwidth-1:0] write_data;

    output [bitwidth-1:0] read_data;

    wire [3:0] byte_enable;
    
    reg [bitwidth-1:0] read_data;
    reg [7:0] memory [31:0]; // 32����Ʈ ũ���� �޸�
    
    integer i;

    always @(posedge clk) begin 
        if (write_enable) begin
            for (i = 0; i < 4; i = i + 1) begin
                if (byte_enable[i]) begin //address 1���� 8bit �����ϱ� ����
                    memory[address*4 + i] = write_data[i*8 +: 8]; // Ư�� ����Ʈ ���� +:�� ��Ʈ�� �ɰ��ٴ� ��
                end//adress*4�� �޸��ּҸ� 32��Ʈ ����� �������ϸ��ϴ� �� ex.) 
                   //0��° �ּҴ� 0,1,2,3��° ����Ʈ�� ����Ų��.
                   //�ʿ��� byte ũ�� ��ŭ read_data�� OR�����Ͽ� ����
            end
        end
    end 
     always @(*) begin 
        if (read_enable) begin
            read_data = 8'h00000000; //default value
            for (i = 0; i < 4; i = i + 1) begin
                if (byte_enable[i]) begin
                    read_data = read_data | (memory[address*4 + i] << (i*8));
                    //�޸� �����͸� �о�� �� ����Ʈ�� �°� �޸� ���� �а� read_data�� �ڸ��� �°� ����Ʈ ��Ű�� ����
                end //�ִ´�.
            end
        end
    end
endmodule
