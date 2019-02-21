`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: RegFile
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    input [4:0] Reg1,
    input [4:0] Reg2,
    input [4:0] RegWrite,
    input [31:0] Din,
    input WE,
    input clk,
    output [31:0] R1,
    output [31:0] R2
    );
    reg [31:0] RegGroup[31:0];

    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            RegGroup[i] = 0;
        end
    end

    always @(posedge clk) begin
        if (WE && (RegWrite != 0)) begin
            RegGroup[RegWrite] <= Din;
        end
    end

    // $zero is always zero!
    assign R1 = Reg1 == 0 ? 0 : RegGroup[Reg1];
    assign R2 = Reg2 == 0 ? 0 : RegGroup[Reg2];

endmodule
