`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: test_counter
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_counter;
    reg clk;
    reg rst;
    reg enable;
    wire [31:0] dataout;

    Counter counter(.clk(clk), .rst(rst), .enable(enable), .data_out(dataout));

    initial begin
        clk = 0;
        rst = 0;
        enable = 1;
    end

    always begin
        #10 clk = ~clk;
    end
endmodule
