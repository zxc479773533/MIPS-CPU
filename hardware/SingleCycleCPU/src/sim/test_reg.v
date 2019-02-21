`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: test_reg
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_reg;
    reg in, en, clk, rst;
    wire out;

    Reg test_reg(.data_in(in), .enable(en), .clk(clk), .rst(rst), .data_out(out));

initial begin
    clk = 1'b0;
    in = 0;
    en = 1;
    rst = 0;
    #200 in = 1;
    //#100 en = 0;
    #100 in = 0;
end

always begin
    #10 clk = ~clk;
end

endmodule
