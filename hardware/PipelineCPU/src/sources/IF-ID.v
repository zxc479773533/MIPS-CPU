`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: IF_ID
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_ID(
        input [31:0] Din_ins,
        input [31:0] Din_PCand4,
        input [31:0] Din_PC,
        input status_in,
        input clk,
        input rst,
        input stall,
        output [31:0] Dout_ins,
        output [31:0] Dout_PCand4,
        output [31:0] Dout_PC,
        output status_out
    );
    wire enable;
    assign enable = ~stall;

    wire [31:0] ins, pcand4, pc;
    wire status;

    Mux Ins_mux(
        .data_in1(Din_ins),
        .data_in2(0),
        .select(rst),
        .data_out(ins)
    );

    Reg Ins_reg(
        .data_in(ins),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_ins)
    );

    Mux PCand4_mux(
        .data_in1(Din_PCand4),
        .data_in2(0),
        .select(rst),
        .data_out(pcand4)
    );

    Reg PCand4_reg(
        .data_in(pcand4),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_PCand4)
    );

    Mux PC_mux(
        .data_in1(Din_PC),
        .data_in2(0),
        .select(rst),
        .data_out(pc)
    );

    Reg PC_reg(
        .data_in(pc),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_PC)
    );

    Mux Status_mux(
        .data_in1(status_in),
        .data_in2(0),
        .select(rst),
        .data_out(status)
    );

    Reg Status_reg(
        .data_in(status),
        .enable(enable),
        .clk(clk),
        .data_out(status_out)
    );

endmodule