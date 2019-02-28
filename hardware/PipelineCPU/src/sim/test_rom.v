`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: test_rom
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_rom;
    reg [9:0] addr;
    wire [31:0] data;

    Rom rom(.addr(addr), .data(data));

    initial begin
        addr = 0;
    end

    always begin
        #10 addr = addr + 1;
    end
endmodule
