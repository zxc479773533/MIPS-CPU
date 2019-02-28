`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: EnablePC
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module EnablePC_Pipeline (
        input syscall,
        input show, 
        input rst,
        input go,
        input clk,
        output pc_enable
    );
    wire enable_in;
    wire rst_in;
    reg pc_enable_out;

    initial begin
        pc_enable_out = 0;
    end

    assign enable_in = syscall & ~show;

    assign rst_in = rst | go;

    assign pc_enable = ~pc_enable_out;

    always @(negedge clk or posedge rst_in) begin
        if (rst_in == 1) begin
            pc_enable_out = 0;
        end
        else if (enable_in != 0) begin
            pc_enable_out <= syscall;
        end
    end

endmodule