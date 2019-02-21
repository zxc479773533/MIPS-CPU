`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: EnablePC
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module EnablePC (
        input syscall,
        input show, 
        input rst,
        input go,
        input clk,
        output pc_enable
    );
    wire enable_in;
    wire rst_in;
    wire pc_enable_out;

    Reg pc_enable_reg(.data_in(syscall), .enable(enable_in), .clk(clk), .rst(rst_in), .data_out(pc_enable_out));

    assign enable_in = syscall & ~show;

    assign rst_in = rst | go;

    assign pc_enable = ~pc_enable_out;

endmodule