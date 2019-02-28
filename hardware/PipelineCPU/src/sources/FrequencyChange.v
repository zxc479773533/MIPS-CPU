`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-21
// Design Name: 
// Module Name: FrequencyChange
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module FrequencyChange (
        input rawClk,
        input frequency,
        output clk
    );
    wire slow_clk;
    wire fast_clk;

    Divider #(10)less_clock_divider(.clk(rawClk), .clk_N(fast_clk));

    Divider #(1000000)clock_divider(.clk(rawClk), .clk_N(slow_clk));

    assign clk = frequency == 1 ? fast_clk : slow_clk;

endmodule
