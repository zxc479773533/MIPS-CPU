`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: Ram
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Ram #(
        ADDR_WIDTH = 10,
        DATA_WIDTH = 32,
        RAM_SIZE = 1024
    )(
        input clk,
        input rst,
        input str,
        input [ADDR_WIDTH - 1:0] addr,
        input [DATA_WIDTH - 1:0] data,
        output [DATA_WIDTH - 1:0] result
    );

    reg [DATA_WIDTH - 1:0] memory[RAM_SIZE - 1:0];

    integer i;
    initial begin
        for(i = 0; i < RAM_SIZE; i = i + 1) begin
            memory[i] = 0;
        end
    end
  

    always @(posedge clk) begin
        if (str) begin
            memory[addr] <= data;
        end

        if (rst) begin
            for(i = 0; i < RAM_SIZE; i = i+1) begin
                memory[i] = 0;
            end
        end
    end

    assign result = memory[addr];
    
endmodule