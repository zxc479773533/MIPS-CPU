`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: test_controller
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_controller;
    reg [31:0] instruction;
    wire jmp, jr, signedext, beq, bne, memtoreg, memwrite, alusrcb, regwrite, jal, regdst, syscall;
    wire [3:0] AluOP;

    initial begin
        instruction = 32'h20110001;
        #10 instruction = 32'h08000c05;
        #10 instruction = 32'h20110001;
        #10 instruction = 32'h20120002;
        #10 instruction = 32'h20130003;
        #10 instruction = 32'h08000c09;
        #10 instruction = 32'h20110001;
        #10 instruction = 32'h20120002;
        #10 instruction = 32'h20130003;
        #10 instruction = 32'h08000c0d;
    end

    ControlUnit contorller(
        .opcode(instruction[31:26]), .func(instruction[5:0]),
        .JMP(jmp), .JR(jr), .SignedExt(signedext),
        .Beq(beq), .Bne(bne), .MemToReg(memtoreg), .MemWrite(memwrite),
        .AluSrcB(alusrcb), .RegWrite(regwrite), .JAL(jal),
        .RegDst(regdst), .Syscall(syscall),
        .AluOP(AluOP)
    );
endmodule
