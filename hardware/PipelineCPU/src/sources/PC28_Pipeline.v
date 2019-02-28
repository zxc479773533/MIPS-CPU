`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-21
// Design Name: 
// Module Name: PC28_Pipeline
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module PC28_Pipeline(
    input Beq, Bne,
    input JMP, JR, JAL, BLTZ,
    input SH,
    input AluEqual,
    input enable,
    input clk,
    input rst,
    input [31:0] R1,
    input [31:0] I_imm,
    input [31:0] J_imm,
    input [31:0] pcand4,
    output branch_ok,
    output [31:0] pc_out,
    output [31:0] normal_pc,
    output [9:0] addr
    );
    reg [31:0] next_pc;
    wire cmp_out;
    wire branch;
    wire bltz_branch;
    wire jmp_ok;
    wire [31:0] branch_pc;
    wire [31:0] branch_pc_out;
    wire [31:0] nojmp_pc;
    wire [31:0] j_pc;
    wire [31:0] jmp_pc;
    wire [31:0] jmp_pc_out;
    wire [31:0] final_pc;
    
    Reg pc_reg(.data_in(next_pc), .enable(enable), .clk(clk), .rst(rst), .data_out(pc_out));

    Mux sel_branch(.data_in1(pcand4), .data_in2(branch_pc), .select(branch_ok), .data_out(branch_pc_out));

    Mux sel_jr(.data_in1(j_pc), .data_in2(R1), .select(JR), .data_out(jmp_pc));

    Mux sel_jmp(.data_in1(branch_pc_out), .data_in2(jmp_pc), .select(JMP), .data_out(jmp_pc_out));

    Mux sel_final(.data_in1(normal_pc), .data_in2(jmp_pc_out), .select(jmp_ok), .data_out(final_pc));

    Compare cmp_r1_and_0(.data_in1(R1), .data_in2(0), .less(cmp_out));

    initial begin
        next_pc = 0;
    end

    always @(final_pc) begin
        next_pc = final_pc;
    end

    assign normal_pc = pc_out + 4;

    assign branch_pc = pcand4 + (I_imm << 2);

    assign j_pc = J_imm << 2;

    assign addr = pc_out[11:2];

    assign bltz_branch = cmp_out & BLTZ;

    assign branch = (Beq & AluEqual) | (Bne & ~AluEqual);

    assign branch_ok = branch | bltz_branch;

    assign jmp_ok = branch_ok | JMP;

endmodule
