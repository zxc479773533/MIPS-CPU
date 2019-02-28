`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-21
// Design Name: 
// Module Name: RamSel
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module RamSel #(
        ADDR_WIDTH = 10,
        RAM_SIZE = 1024
    )(
        input clk,
        input rst,
        input str,
        input [3:0] sel,
        input [ADDR_WIDTH - 1:0] addr,
        input [31:0] data,
        output [31:0] result
    );

    reg [31:0] memory[RAM_SIZE - 1:0];

    integer i;
    initial begin
        for(i = 0; i < RAM_SIZE; i = i + 1) begin
            memory[i] = 0;
        end
    end
  

    always @(posedge clk) begin
        if (str) begin
            if (sel[0] == 1'b1) begin
                memory[addr][7:0] <= data[7:0];
            end
            if (sel[1] == 1'b1) begin
                memory[addr][15:8] <= data[15:8];
            end
            if (sel[2] == 1'b1) begin
                memory[addr][23:16] <= data[23:16];
            end
            if (sel[3] == 1'b1) begin
                memory[addr][31:24] <= data[31:24];
            end
        end

        if (rst) begin
            for(i = 0; i < RAM_SIZE; i = i + 1) begin
                memory[i] = 0;
            end
        end
    end

    assign result = memory[addr];
    
endmodule