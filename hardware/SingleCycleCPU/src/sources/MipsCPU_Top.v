`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: MipsCPU_Top
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module MipsCPU_Top(
        input rawClk,
        input CPU_RESETN,
        input go,
        input [1:0] SW,
        output [1:0] LED,
        output [7:0] SEG,
        output [7:0] AN
    );
    // Clock
    wire clk;
    wire reset;

    // Instructions
    wire [31:0] instruction;
    // Controller signals
    wire jmp, jr, signedext;
    wire beq, bne, memtoreg, memwrite, alusrcb, regwrite, jal, regdst, syscall;
    wire [3:0] aluop;

    // Regfile
    wire [4:0] sel_regdst_out;
    wire [4:0] R1_in, R2_in, RegWrite_in;
    wire [31:0] RegWriteData;
    wire [31:0] R1;
    wire [31:0] R2;

    // Alu
    wire [31:0] y_in;
    wire [31:0] alu_data;
    wire aluequal;

    // Immediate
    wire [31:0] unsignedext_16_out;
    wire [31:0] signedext_16_out;
    wire [31:0] I_imm;
    wire [31:0] J_imm;

    // PC
    wire pcEnable;
    wire branch;
    wire [31:0] normal_pc;
    wire [9:0] pc_addr;

    // Ram
    wire [31:0] ram_data;
    wire [31:0] wireback_data;

    // LedData
    wire show;
    wire [31:0] LedData_out;

    assign LED = SW;
    assign reset = ~CPU_RESETN;

    //-----This part needs to be deleted during the simulation-----
    // begin

    Divider #(1000000)clock_divider(
        .clk(rawClk), .clk_N(clk)
    );

    Display led_display(
        .leddata(LedData_out),
        .select(SW),
        .clk(rawClk),
        .rst(reset),
        .seg(SEG),
        .an(AN)
    );

    // end
    //-----This part needs to be deleted during the simulation-----

    PC pc_path(
        .Beq(beq), .Bne(bne), .JMP(jmp), .JR(jr), .JAL(jal), .AluEqual(aluequal),
        .enable(pcEnable), .clk(clk), .rst(reset),
        .R1(R1), .I_imm(I_imm), .J_imm(J_imm),
        .branch(branch), .normal_pc(normal_pc), .addr(pc_addr)
    );

    Rom ins_rom(
        .addr(pc_addr), .data(instruction)
    );

    ControlUnit contorller(
        .opcode(instruction[31:26]), .func(instruction[5:0]),
        .JMP(jmp), .JR(jr), .SignedExt(signedext),
        .Beq(beq), .Bne(bne), .MemToReg(memtoreg), .MemWrite(memwrite),
        .AluSrcB(alusrcb), .RegWrite(regwrite), .JAL(jal),
        .RegDst(regdst), .Syscall(syscall),
        .AluOP(aluop)
    );

    Mux #(5)sel_r1(
        .data_in1(instruction[25:21]), .data_in2(5'h4),
        .select(syscall), .data_out(R1_in)
    );

    Mux #(5)sel_r2(
        .data_in1(instruction[20:16]), .data_in2(5'h2),
        .select(syscall), .data_out(R2_in)
    );
    
    Mux #(5)sel_regdst(
        .data_in1(instruction[20:16]), .data_in2(instruction[15:11]),
        .select(regdst), .data_out(sel_regdst_out)
    );

    Mux #(5)sel_regwrite(
        .data_in1(sel_regdst_out), .data_in2(5'h1f),
        .select(jal), .data_out(RegWrite_in)
    );

    Mux sel_regwrite_data(
        .data_in1(wireback_data), .data_in2(normal_pc),
        .select(jal), .data_out(RegWriteData)
    );

    RegFile mips_regfile(
        .Reg1(R1_in), .Reg2(R2_in),
        .RegWrite(RegWrite_in), .Din(RegWriteData),
        .WE(regwrite), .clk(clk),
        .R1(R1), .R2(R2)
    );

    SignExt unsignedext_16(
        .data_in(instruction[15:0]),
        .sign(0),
        .data_out(unsignedext_16_out)
    );

    SignExt signedext_16(
        .data_in(instruction[15:0]),
        .sign(1),
        .data_out(signedext_16_out)
    );

    Mux sel_signedext(
        .data_in1(unsignedext_16_out), .data_in2(signedext_16_out),
        .select(signedext), .data_out(I_imm)
    );

    SignExt signedext_26(
        .data_in(instruction[25:0]),
        .sign(1),
        .data_out(J_imm)
    );

    Mux sel_alu_y(
        .data_in1(R2), .data_in2(I_imm),
        .select(alusrcb), .data_out(y_in)
    );

    Alu mips_alu(
        .x(R1), .y(y_in),
        .shamt(instruction[10:6]),
        .AluOP(aluop),
        .result(alu_data),
        .equal(aluequal)
    );

    Ram data_ram(
        .clk(clk), .rst(reset), .str(memwrite),
        .addr(alu_data[11:2]), .data(R2),
        .result(ram_data)
    );

    Mux sel_wireback_data(
        .data_in1(alu_data), .data_in2(ram_data),
        .select(memtoreg), .data_out(wireback_data)
    );

    Compare cmp_syscall(
        .data_in1(32'h22), .data_in2(R2),
        .equal(show)
    );

    LedData leddata(
        .R1(R1),
        .syscall(syscall),
        .show(show),
        .rst(reset), .clk(clk),
        .pc_enable(pcEnable),
        .jmp(jmp),
        .branch(branch),
        .select(SW),
        .leddata_out(LedData_out)
    );

    EnablePC enable_pc(
        .syscall(syscall),
        .show(show),
        .rst(reset), .go(go), .clk(clk),
        .pc_enable(pcEnable)
    );


endmodule
