`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: ID_EX
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EX(
        input Din_BLTZ,
        input Din_SH,
        input Din_JR,
        input Din_JMP,
        input Din_Beq,
        input Din_Bne,
        input Din_MemToReg,
        input Din_MemWrite,
        input [3:0] Din_AluOP,
        input Din_AluSrcB,
        input Din_RegWrite,
        input Din_JAL,
        input Din_Syscall,
        input [1:0] Din_forward1,
        input [31:0] Din_R1,
        input [1:0] Din_forward2,
        input [31:0] Din_R2,
        input [31:0] Din_Imm16,
        input [31:0] Din_Imm26,
        input [4:0] Din_Shamt,
        input [31:0] Din_PCand4,
        input [4:0] Din_WriteReg,
        input [31:0] Din_PC,
        input status_in,
        input clk,
        input rst,
        input stall,
        output Dout_BLTZ,
        output Dout_SH,
        output Dout_JR,
        output Dout_JMP,
        output Dout_Beq,
        output Dout_Bne,
        output Dout_MemToReg,
        output Dout_MemWrite,
        output [3:0] Dout_AluOP,
        output Dout_AluSrcB,
        output Dout_RegWrite,
        output Dout_JAL,
        output Dout_Syscall,
        output [1:0] Dout_forward1,
        output [31:0] Dout_R1,
        output [1:0] Dout_forward2,
        output [31:0] Dout_R2,
        output [31:0] Dout_Imm16,
        output [31:0] Dout_Imm26,
        output [4:0] Dout_Shamt,
        output [31:0] Dout_PCand4,
        output [4:0] Dout_WriteReg,
        output [31:0] Dout_PC,
        output status_out
    );
    wire enable;
    assign enable = ~stall;

    wire bltz, sh, jr, jmp, beq, bne, memtoreg, memwrite;
    wire [3:0] aluop;
    wire alusrcb, regwrite, jal, syscall;
    wire [1:0] forward1, forward2;
    wire [31:0] r1, r2, imm16, imm26;
    wire [4:0] shamt;
    wire [31:0] pcand4, pc;
    wire [4:0] writereg;
    wire status;

    Mux Bltz_mux(
        .data_in1(Din_BLTZ),
        .data_in2(0),
        .select(rst),
        .data_out(bltz)
    );

    Reg Bltz_reg(
        .data_in(bltz),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_BLTZ)
    );

    Mux SH_mux(
        .data_in1(Din_SH),
        .data_in2(0),
        .select(rst),
        .data_out(sh)
    );

    Reg SH_reg(
        .data_in(sh),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_SH)
    );

    Mux JR_mux(
        .data_in1(Din_JR),
        .data_in2(0),
        .select(rst),
        .data_out(jr)
    );

    Reg JR_reg(
        .data_in(jr),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_JR)
    );

    Mux JMP_mux(
        .data_in1(Din_JMP),
        .data_in2(0),
        .select(rst),
        .data_out(jmp)
    );

    Reg JMP_reg(
        .data_in(jmp),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_JMP)
    );

    Mux Beq_mux(
        .data_in1(Din_Beq),
        .data_in2(0),
        .select(rst),
        .data_out(beq)
    );

    Reg Beq_reg(
        .data_in(beq),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Beq)
    );

    Mux Bne_mux(
        .data_in1(Din_Bne),
        .data_in2(0),
        .select(rst),
        .data_out(bne)
    );

    Reg Bne_reg(
        .data_in(bne),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Bne)
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

    Mux MemWrite_mux(
        .data_in1(Din_MemWrite),
        .data_in2(0),
        .select(rst),
        .data_out(memwrite)
    );

    Reg MemWrite_reg(
        .data_in(memwrite),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_MemWrite)
    );

    Mux #(4)AluOP_mux(
        .data_in1(Din_AluOP),
        .data_in2(0),
        .select(rst),
        .data_out(aluop)
    );

    Reg #(4)AluOP_reg(
        .data_in(aluop),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_AluOP)
    );

    Mux AluSrcB_mux(
        .data_in1(Din_AluSrcB),
        .data_in2(0),
        .select(rst),
        .data_out(alusrcb)
    );

    Reg AluSrcB_reg(
        .data_in(alusrcb),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_AluSrcB)
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

    Mux #(2)forward1_mux(
        .data_in1(Din_forward1),
        .data_in2(0),
        .select(rst),
        .data_out(forward1)
    );

    Reg #(2)forward1_reg(
        .data_in(forward1),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_forward1)
    );

    Mux R1_mux(
        .data_in1(Din_R1),
        .data_in2(0),
        .select(rst),
        .data_out(r1)
    );

    Reg R1_reg(
        .data_in(r1),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_R1)
    );

    Mux #(2)forward2_mux(
        .data_in1(Din_forward2),
        .data_in2(0),
        .select(rst),
        .data_out(forward2)
    );

    Reg #(2)forward2_reg(
        .data_in(forward2),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_forward2)
    );

    Mux R2_mux(
        .data_in1(Din_R2),
        .data_in2(0),
        .select(rst),
        .data_out(r2)
    );

    Reg R2_reg(
        .data_in(r2),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_R2)
    );

    Mux Imm16_mux(
        .data_in1(Din_Imm16),
        .data_in2(0),
        .select(rst),
        .data_out(imm16)
    );

    Reg Imm16_reg(
        .data_in(imm16),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Imm16)
    );

    Mux Imm26_mux(
        .data_in1(Din_Imm26),
        .data_in2(0),
        .select(rst),
        .data_out(imm26)
    );

    Reg Imm26_reg(
        .data_in(imm26),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Imm26)
    );

    Mux #(5)Shamt_mux(
        .data_in1(Din_Shamt),
        .data_in2(0),
        .select(rst),
        .data_out(shamt)
    );

    Reg #(5)Shamt_reg(
        .data_in(shamt),
        .enable(enable),
        .clk(clk),
        .data_out(Dout_Shamt)
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