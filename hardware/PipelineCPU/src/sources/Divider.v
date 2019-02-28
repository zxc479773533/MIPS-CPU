`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: Divider
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Divider #(
        parameter N = 100_000_000
    )(
        input clk,
        output reg clk_N
    );

    reg [31: 0] counter = 0;

    initial begin
        counter = 0;
        clk_N = 0;
    end

    always @(posedge clk) begin
        counter <= counter + 1;
        if(counter == N / 2) begin
            clk_N <= ~clk_N;
            counter <= 0;
        end
    end
endmodule