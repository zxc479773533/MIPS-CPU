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


module test_pipeline;
    reg clk, go, rst;
    reg [1:0] select;
    wire [11:0] IF_PC;
    wire [11:0] ID_PC;
    wire [11:0] EX_PC;
    wire [11:0] MEM_PC;
    wire [11:0] WB_PC;
    wire [31:0] LedData_out;
    wire [31:0] EX_LedData;
    wire [31:0] WB_LedData;
    wire [31:0] forward1_out;
    wire [31:0] forward2_out;
    wire [1:0] EX_forward1;
    wire [1:0] EX_forward2;

    MipsCPU28_Pipeline MIPS_CPU(
        .clk(clk),
        .CPU_RESETN(rst),
        .go(go),
        .SW15(1),
        .SW(select),
        .IF_PC(IF_PC),
        .ID_PC(ID_PC),
        .EX_PC(EX_PC),
        .MEM_PC(MEM_PC),
        .WB_PC(WB_PC),
        .LedData_out(LedData_out),
        .pcEnable(pcEnable),
        .forward1_out(forward1_out),
        .forward2_out(forward2_out),
        .EX_forward1(EX_forward1),
        .EX_forward2(EX_forward2),
        .WB_LedData(WB_LedData),
        .EX_LedData(EX_LedData),
        .WB_show(WB_show),
        .WB_syscall(WB_syscall)
    );

    initial begin
        select = 2'b11;
        clk = 0;
        go = 1;
        rst = 1;
    end

    always begin
        #10 clk = ~clk;
    end

endmodule
