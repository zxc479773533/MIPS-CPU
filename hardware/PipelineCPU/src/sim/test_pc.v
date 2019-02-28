`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: test_pc
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module test_pc;
    reg beq, bne;
    reg jmp, jr, jal;
    reg aluequal;
    reg pcEnable;
    reg clk;
    reg rst;
    reg [31:0] R1;
    reg [31:0] I_imm;
    reg [31:0] J_imm;
    wire branch;
    wire [31:0] normal_pc;
    wire [9:0] addr;

    PC pc_path(
        .Beq(beq), .Bne(bne), .JMP(jmp), .JR(jr), .JAL(jal), .AluEqual(aluequal),
        .enable(pcEnable), .clk(clk), .rst(rst),
        .R1(R1), .I_imm(I_imm), .J_imm(J_imm),
        .branch(branch), .normal_pc(normal_pc), .addr(addr)
    );

    initial begin
        beq = 0;
        bne = 0;
        jmp = 0;
        jr = 0;
        jal = 0;
        aluequal = 0;
        pcEnable = 1;
        clk = 0;
        rst = 0;
        R1 = 0;
        I_imm = 0;
        J_imm = 0;
    end

    always begin
        #10 clk = ~clk;
    end
endmodule
