`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: MEM_WB
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB(
        input Din_Show,
        input Din_Syscall,
        input Din_MemToReg,
        input Din_RegWrite,
        input Din_JAL,
        input [31:0] Din_LedData,
        input [31:0] Din_AluResult,
        input [31:0] Din_MemData,
        input [31:0] Din_PCand4,
        input [4:0] Din_WriteReg,
        input [31:0] Din_PC,
        input status_in,
        input clk,
        input rst,
        input stall,
        output Dout_Show,
        output Dout_Syscall,
        output Dout_MemToReg,
        output Dout_RegWrite,
        output Dout_JAL,
        output [31:0] Dout_LedData,
        output [31:0] Dout_AluResult,
        output [31:0] Dout_MemData,
        output [31:0] Dout_PCand4,
        output [4:0] Dout_WriteReg,
        output [31:0] Dout_PC,
        output status_out
    );
    wire enable;
    assign enable = ~stall;

    wire show, syscall, memtoreg;
    wire regwrite, jal;
    wire [31:0] leddata, aluresult, memdata;
    wire [31:0] pcand4, pc;
    wire [4:0] writereg;
    wire status;

    Mux Show_mux(
        .data_in1(Din_Show),
        .data_in2(0),
        .select(rst),
        .data_out(show)
    );

    Reg Show_reg(
        .data_in(show),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Show)
    );


    Mux Syscall_mux(
        .data_in1(Din_Syscall),
        .data_in2(0),
        .select(rst),
        .data_out(syscall)
    );

    Reg Syscall_reg(
        .data_in(syscall),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Syscall)
    );
    
    Mux MemToReg_mux(
        .data_in1(Din_MemToReg),
        .data_in2(0),
        .select(rst),
        .data_out(memtoreg)
    );

    Reg MemToReg_reg(
        .data_in(memtoreg),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_MemToReg)
    );

    Mux RegWrite_mux(
        .data_in1(Din_RegWrite),
        .data_in2(0),
        .select(rst),
        .data_out(regwrite)
    );

    Reg RegWrite_reg(
        .data_in(regwrite),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_RegWrite)
    );

    Mux JAL_mux(
        .data_in1(Din_JAL),
        .data_in2(0),
        .select(rst),
        .data_out(jal)
    );

    Reg JAL_reg(
        .data_in(jal),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_JAL)
    );

    Mux LedData_mux(
        .data_in1(Din_LedData),
        .data_in2(0),
        .select(rst),
        .data_out(leddata)
    );

    Reg LedData_reg(
        .data_in(leddata),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_LedData)
    );

    Mux AluResult_mux(
        .data_in1(Din_AluResult),
        .data_in2(0),
        .select(rst),
        .data_out(aluresult)
    );

    Reg AluResult_reg(
        .data_in(aluresult),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_AluResult)
    );

    Mux MemData_mux(
        .data_in1(Din_MemData),
        .data_in2(0),
        .select(rst),
        .data_out(memdata)
    );

    Reg MemData_reg(
        .data_in(memdata),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_MemData)
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

    Mux #(5)WriteReg_mux(
        .data_in1(Din_WriteReg),
        .data_in2(0),
        .select(rst),
        .data_out(writereg)
    );

    Reg #(5)WriteReg_reg(
        .data_in(writereg),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_WriteReg)
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