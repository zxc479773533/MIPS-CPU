`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: test_mips24
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_mips24;
    reg clk, go, rst;
    reg [1:0] select;
    wire [31:0] LedData;

    MipsCPU_Top MIPS_CPU(
        .clk(clk),
        .rst(rst),
        .go(go),
        .select(select),
        .LedData_out(LedData)
    );

    initial begin
        select = 2'b01;
        clk = 0;
        go = 0;
        rst = 0;
    end

    always begin
        #10 clk = ~clk;
    end

endmodule
