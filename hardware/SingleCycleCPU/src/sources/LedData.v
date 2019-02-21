`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: LedData
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module LedData (
        input [31:0] R1,
        input syscall,
        input show, 
        input rst,
        input clk,
        input pc_enable,
        input jmp,
        input branch,
        input [1:0] select,
        output reg [31:0] leddata_out
    );
    wire enable_in;
    wire [31:0] a0_out;
    wire [31:0] cycles;
    wire [31:0] jmp_clcyes;
    wire [31:0] branch_clcyes;

    Reg a0_reg(.data_in(R1), .enable(enable_in), .clk(clk), .rst(rst), .data_out(a0_out));

    Counter cycle_counter(.clk(clk), .rst(rst), .enable(pc_enable), .data_out(cycles));

    Counter jmp_counter(.clk(clk), .rst(rst), .enable(jmp), .data_out(jmp_clcyes));

    Counter branch_counter(.clk(clk), .rst(rst), .enable(branch), .data_out(branch_clcyes));

    always @(*) begin
        case (select)
            2'b00: leddata_out <= a0_out;
            2'b01: leddata_out <= cycles;
            2'b10: leddata_out <= jmp_clcyes;
            2'b11: leddata_out <= branch_clcyes;
        endcase
    end

    assign enable_in = syscall & show;
endmodule