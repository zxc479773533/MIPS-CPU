`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-21
// Design Name: 
// Module Name: test_mips28
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_mips28;
    reg clk, go, rst;
    reg [1:0] select;
    wire [31:0] LedData;
    wire [31:0] sh_data;

    MipsCPU_Top28 MIPS_CPU(
        .clk(clk),
        .CPU_RESETN(rst),
        .go(go),
        .SW(select),
        .LedData_out(LedData),
        .sh_data(sh_data)
    );

    initial begin
        select = 2'b01;
        clk = 0;
        go = 1;
        rst = 1;
    end

    always begin
        #10 clk = ~clk;
    end

endmodule
