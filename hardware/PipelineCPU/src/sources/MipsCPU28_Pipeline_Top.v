`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: MipsCPU28_Pipeline
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module MipsCPU28_Pipeline(
        input rawClk,
        input CPU_RESETN,
        input frequency,
        input go,
        input SW15,
        input [1:0] SW,
        output LED15,
        output [2:0] LED,
        output [7:0] SEG,
        output [7:0] AN
    );
    // Clock
    wire clk;

    // Reset
    wire reset;

    // Status
    wire ID_status, EX_status, MEM_status;

    // Load-Use
    wire load_use;

    // Enable
    wire pcEnable;

    // Branchif
    wire branchif;

    // LED Data
    wire [31:0] LedData_out;

    // Pipeline reset and stall
    wire IF_ID_Rst, ID_EX_Rst;
    wire IF_ID_Stall, ID_EX_Stall, EX_MEM_Stall, MEM_WB_Stall;

    assign LED[1:0] = SW[1:0];
    assign LED[2] = frequency;
    assign reset = ~CPU_RESETN;

    // --------------------     IF Variables     --------------------
    wire [31:0] IF_PC;
    wire run;
    wire [31:0] IF_pcand4;
    wire [9:0] IF_Addr;
    wire [31:0] IF_Instruction;

    // --------------------     ID Variables     --------------------
    wire [31:0] ID_PC;
    wire [31:0] ID_Instruction;
    wire [31:0] ID_pcand4;
    wire ID_jmp, ID_jr, ID_signedext, ID_sh, ID_bltz;
    wire ID_beq, ID_bne, ID_memtoreg, ID_memwrite, ID_alusrcb, ID_regwrite, ID_jal, ID_regdst, ID_syscall;
    wire [3:0] ID_aluop;

    wire [4:0] sel_regdst_out;
    wire [4:0] R1_in, R2_in, ID_WriteReg;
    wire [31:0] ID_R1, ID_R2;

    wire [31:0] unsignedext_16_out;
    wire [31:0] signedext_16_out;
    wire [31:0] ID_Imm16;
    wire [31:0] ID_Imm26;

    wire ID_R1_Used, ID_R2_Used;
    wire [1:0] ID_forward1;
    wire [1:0] ID_forward2;

    // --------------------     EX Variables     --------------------
    wire [31:0] EX_PC;
    wire [31:0] EX_pcand4;
    wire EX_jmp, EX_jr, EX_sh, EX_bltz;
    wire EX_beq, EX_bne, EX_memtoreg, EX_memwrite, EX_alusrcb, EX_regwrite, EX_jal, EX_syscall;
    wire [3:0] EX_aluop;

    wire [31:0] EX_R1;
    wire [31:0] EX_R2;
    wire [4:0] EX_WriteReg;

    wire EX_show;

    wire [31:0] EX_Imm16;
    wire [31:0] EX_Imm26;

    wire [1:0] EX_forward1, EX_forward2;
    wire [4:0] EX_shamt;

    wire EX_regenable;
    wire [31:0] forward1_out, forward2_out;
    wire [31:0] EX_LedData;

    wire EX_aluequal;
    wire [31:0] EX_AluResult;
    wire [31:0] Alu_y;

    wire stop1;

    // --------------------     MEM Variables     --------------------
    wire [31:0] MEM_PC;
    wire [31:0] MEM_pcand4;
    wire MEM_sh, MEM_show, MEM_syscall, MEM_memtoreg, MEM_memwrite, MEM_regwrite, MEM_jal;
    wire [31:0] MEM_LedData;
    wire [31:0] MEM_AluResult;
    wire [31:0] MEM_R2;
    wire [4:0] MEM_WriteReg;

    wire [3:0] ram_sel;
    wire [3:0] sh_sel;
    wire [31:0] sh_data;
    wire [31:0] RAM_Datain;
    wire [31:0] MEM_RAMData;

    wire stop2;

    // --------------------     WB Variables     --------------------
    wire [31:0] WB_PC;
    wire WB_show, WB_syscall;
    wire WB_memtoreg, WB_jal;
    wire WB_regwrite;
    wire [31:0] WB_LedData;
    wire [31:0] WB_AluResult;
    wire [31:0] WB_MemData;
    wire [31:0] WB_pcand4;
    wire [4:0] WB_WriteReg;

    wire [31:0] MemToRegData;
    wire [31:0] WB_WriteBackdata;

    // Global
    assign IF_ID_Rst = branchif | EX_jmp;
    assign ID_EX_Rst = load_use | IF_ID_Rst;

    assign IF_ID_Stall = load_use | ~pcEnable;
    assign ID_EX_Stall = ~pcEnable;
    assign EX_MEM_Stall = ~pcEnable;
    assign MEM_WB_Stall = ~pcEnable;

    FrequencyChange clock_divider(
        .rawClk(rawClk),
        .frequency(frequency),
        .clk(clk)
    );

    Display led_display(
        .leddata(LedData_out),
        .select(SW),
        .clk(rawClk),
        .rst(reset),
        .seg(SEG),
        .an(AN)
    );

    LedData_Pipeline Show_LedData(
        .leddata_in(WB_LedData),
        .rst(reset),
        .clk(clk),
        .pc_enable(pcEnable),
        .jmp(EX_jmp),
        .branchif(branchif),
        .stop1(stop1),
        .stop2(stop2),
        .load_use(load_use),
        .ShowLoadUse(SW15),
        .select(SW),
        .leddata_out(LedData_out)
    );

    // --------------------     IF     --------------------
    assign run = pcEnable & ~load_use;

    PC28_Pipeline Mips_PC(
        .Beq(EX_beq), .Bne(EX_bne), .JMP(EX_jmp), .JR(EX_jr), .JAL(EX_jal), .BLTZ(EX_bltz), .AluEqual(EX_aluequal),
        .enable(run), .clk(clk), .rst(reset),
        .R1(forward1_out), .I_imm(EX_Imm16), .J_imm(EX_Imm26), .pcand4(EX_pcand4),
        .branch_ok(branchif),
        .pc_out(IF_PC), .normal_pc(IF_pcand4),
        .addr(IF_Addr)
    );

    Rom28 Ins_ROM(
        .addr(IF_Addr), .data(IF_Instruction)
    );

    IF_ID Pipeline_IF_ID(
        .Din_ins(IF_Instruction),
        .Din_PCand4(IF_pcand4),
        .status_in(1),
        .clk(clk),
        .rst(IF_ID_Rst),
        .stall(IF_ID_Stall),
        .Dout_ins(ID_Instruction),
        .Dout_PCand4(ID_pcand4),
        .status_out(ID_status),

        .Din_PC(IF_PC),
        .Dout_PC(ID_PC)

    );


    // --------------------     ID     --------------------
    ControlUnit28 contorller(
        .opcode(ID_Instruction[31:26]), .func(ID_Instruction[5:0]),
        .JMP(ID_jmp), .JR(ID_jr), .SignedExt(ID_signedext), .SH(ID_sh), .BLTZ(ID_bltz),
        .Beq(ID_beq), .Bne(ID_bne), .MemToReg(ID_memtoreg), .MemWrite(ID_memwrite),
        .AluSrcB(ID_alusrcb), .RegWrite(ID_regwrite), .JAL(ID_jal),
        .RegDst(ID_regdst), .Syscall(ID_syscall),
        .R1_Used(ID_R1_Used), .R2_Used(ID_R2_Used),
        .AluOP(ID_aluop)
    );

    Mux #(5)sel_r1(
        .data_in1(ID_Instruction[25:21]), .data_in2(5'h4),
        .select(ID_syscall), .data_out(R1_in)
    );

    Mux #(5)sel_r2(
        .data_in1(ID_Instruction[20:16]), .data_in2(5'h2),
        .select(ID_syscall), .data_out(R2_in)
    );
    
    Mux #(5)sel_regdst(
        .data_in1(ID_Instruction[20:16]), .data_in2(ID_Instruction[15:11]),
        .select(ID_regdst), .data_out(sel_regdst_out)
    );

    Mux #(5)sel_regwrite(
        .data_in1(sel_regdst_out), .data_in2(5'h1f),
        .select(ID_jal), .data_out(ID_WriteReg)
    );

    RegFile mips_regfile(
        .Reg1(R1_in), .Reg2(R2_in),
        .RegWrite(WB_WriteReg), .Din(WB_WriteBackdata),
        .WE(WB_regwrite), .clk(clk),
        .R1(ID_R1), .R2(ID_R2)
    );

    SignExt unsignedext_16(
        .data_in(ID_Instruction[15:0]),
        .sign(0),
        .data_out(unsignedext_16_out)
    );

    SignExt signedext_16(
        .data_in(ID_Instruction[15:0]),
        .sign(1),
        .data_out(signedext_16_out)
    );

    Mux sel_signedext(
        .data_in1(unsignedext_16_out), .data_in2(signedext_16_out),
        .select(ID_signedext), .data_out(ID_Imm16)
    );

    SignExt #(26)signedext_26(
        .data_in(ID_Instruction[25:0]),
        .sign(1),
        .data_out(ID_Imm26)
    );

    Conflict LoadUse_Conflict(
        .EX_WriteReg(EX_WriteReg),
        .MEM_WriteReg(MEM_WriteReg),
        .ID_R1(R1_in),
        .ID_R2(R2_in),
        .EX_RegWrite(EX_regwrite),
        .EX_MemToReg(EX_memtoreg),
        .MEM_RegWrite(MEM_regwrite),
        .MEM_MemToReg(MEM_memtoreg),
        .R1_Used(ID_R1_Used),
        .R2_Used(ID_R2_Used),
        .load_use(load_use),
        .forward1(ID_forward1),
        .forward2(ID_forward2)
    );

    ID_EX Pipeline_ID_EX(
        .Din_BLTZ(ID_bltz),
        .Din_SH(ID_sh),
        .Din_JR(ID_jr),
        .Din_JMP(ID_jmp),
        .Din_Beq(ID_beq),
        .Din_Bne(ID_bne),
        .Din_MemToReg(ID_memtoreg),
        .Din_MemWrite(ID_memwrite),
        .Din_AluOP(ID_aluop),
        .Din_AluSrcB(ID_alusrcb),
        .Din_RegWrite(ID_regwrite),
        .Din_JAL(ID_jal),
        .Din_Syscall(ID_syscall),
        .Din_forward1(ID_forward1),
        .Din_R1(ID_R1),
        .Din_forward2(ID_forward2),
        .Din_R2(ID_R2),
        .Din_Imm16(ID_Imm16),
        .Din_Imm26(ID_Imm26),
        .Din_Shamt(ID_Instruction[10:6]),
        .Din_PCand4(ID_pcand4),
        .Din_WriteReg(ID_WriteReg),
        .status_in(ID_status),
        .clk(clk),
        .rst(ID_EX_Rst),
        .stall(ID_EX_Stall),
        .Dout_BLTZ(EX_bltz),
        .Dout_SH(EX_sh),
        .Dout_JR(EX_jr),
        .Dout_JMP(EX_jmp),
        .Dout_Beq(EX_beq),
        .Dout_Bne(EX_bne),
        .Dout_MemToReg(EX_memtoreg),
        .Dout_MemWrite(EX_memwrite),
        .Dout_AluOP(EX_aluop),
        .Dout_AluSrcB(EX_alusrcb),
        .Dout_RegWrite(EX_regwrite),
        .Dout_JAL(EX_jal),
        .Dout_Syscall(EX_syscall),
        .Dout_forward1(EX_forward1),
        .Dout_R1(EX_R1),
        .Dout_forward2(EX_forward2),
        .Dout_R2(EX_R2),
        .Dout_Imm16(EX_Imm16),
        .Dout_Imm26(EX_Imm26),
        .Dout_Shamt(EX_shamt),
        .Dout_PCand4(EX_pcand4),
        .Dout_WriteReg(EX_WriteReg),
        .status_out(EX_status),

        .Din_PC(ID_PC),
        .Dout_PC(EX_PC)
    );

    // --------------------     EX     --------------------
    assign EX_regenable = EX_show & EX_syscall;
    assign stop1 = EX_syscall & ~EX_show;

    Mux4 Sel_R1(
        .data_in1(EX_R1), .data_in2(WB_AluResult), .data_in3(WB_MemData), .data_in4(MEM_AluResult),
        .select(EX_forward1), .data_out(forward1_out)
    );

    Mux4 Sel_R2(
        .data_in1(EX_R2), .data_in2(WB_AluResult), .data_in3(WB_MemData), .data_in4(MEM_AluResult),
        .select(EX_forward2), .data_out(forward2_out)
    );

    Compare cmp_syscall(
        .data_in1(32'h22), .data_in2(forward2_out),
        .equal(EX_show)
    );

    Reg Reg_leddata(
        .data_in(forward1_out), .enable(EX_regenable),
        .clk(clk), .rst(reset),
        .data_out(EX_LedData)
    );

    Mux Sel_Alu_y(
        .data_in1(forward2_out), .data_in2(EX_Imm16),
        .select(EX_alusrcb), .data_out(Alu_y)
    );

    Alu mips_alu(
        .x(forward1_out), .y(Alu_y),
        .shamt(EX_shamt),
        .AluOP(EX_aluop),
        .result(EX_AluResult),
        .equal(EX_aluequal)
    );

    EX_MEM Pipeline_EX_MEM(
        .Din_SH(EX_sh),
        .Din_Show(EX_show),
        .Din_Syscall(EX_syscall),
        .Din_MemToReg(EX_memtoreg),
        .Din_MemWrite(EX_memwrite),
        .Din_RegWrite(EX_regwrite),
        .Din_JAL(EX_jal),
        .Din_LedData(EX_LedData),
        .Din_AluResult(EX_AluResult),
        .Din_R2(forward2_out),
        .Din_PCand4(EX_pcand4),
        .Din_WriteReg(EX_WriteReg),
        .status_in(EX_status),
        .clk(clk),
        .rst(0),
        .stall(EX_MEM_Stall),
        .Dout_SH(MEM_sh),
        .Dout_Show(MEM_show),
        .Dout_Syscall(MEM_syscall),
        .Dout_MemToReg(MEM_memtoreg),
        .Dout_MemWrite(MEM_memwrite),
        .Dout_RegWrite(MEM_regwrite),
        .Dout_JAL(MEM_jal),
        .Dout_LedData(MEM_LedData),
        .Dout_AluResult(MEM_AluResult),
        .Dout_R2(MEM_R2),
        .Dout_PCand4(MEM_pcand4),
        .Dout_WriteReg(MEM_WriteReg),
        .status_out(MEM_status),

        .Din_PC(EX_PC),
        .Dout_PC(MEM_PC)
    );

    // --------------------     MEM     --------------------
    assign stop2 = MEM_syscall & ~MEM_show;

    Mux sel_sh_data(
        .data_in1({{16{1'b0}}, MEM_R2[15:0]}), .data_in2({MEM_R2[15:0], {16{1'b0}}}),
        .select(MEM_AluResult[1]), .data_out(sh_data)
    );

    Mux sel_ram_datain(
        .data_in1(MEM_R2), .data_in2(sh_data),
        .select(MEM_sh), .data_out(RAM_Datain)
    );

    Mux #(4)sel_sh_sel(
        .data_in1(4'b0011), .data_in2(4'b1100),
        .select(MEM_AluResult[1]), .data_out(sh_sel)
    );

    Mux #(4)sel_ram_sel(
        .data_in1(4'b1111), .data_in2(sh_sel),
        .select(MEM_sh), .data_out(ram_sel)
    );

    RamSel data_ram(
        .clk(clk), .rst(reset), .str(MEM_memwrite),
        .sel(ram_sel),
        .addr(MEM_AluResult[11:2]), .data(RAM_Datain),
        .result(MEM_RAMData)
    );

    MEM_WB Pipeline_MEM_WB(
        .Din_Show(MEM_show),
        .Din_Syscall(MEM_syscall),
        .Din_MemToReg(MEM_memtoreg),
        .Din_RegWrite(MEM_regwrite),
        .Din_JAL(MEM_jal),
        .Din_LedData(MEM_LedData),
        .Din_AluResult(MEM_AluResult),
        .Din_MemData(MEM_RAMData),
        .Din_PCand4(MEM_pcand4),
        .Din_WriteReg(MEM_WriteReg),
        .status_in(MEM_status),
        .clk(clk),
        .rst(0),
        .stall(MEM_WB_Stall),
        .Dout_Show(WB_show),
        .Dout_Syscall(WB_syscall),
        .Dout_MemToReg(WB_memtoreg),
        .Dout_RegWrite(WB_regwrite),
        .Dout_JAL(WB_jal),
        .Dout_LedData(WB_LedData),
        .Dout_AluResult(WB_AluResult),
        .Dout_MemData(WB_MemData),
        .Dout_PCand4(WB_pcand4),
        .Dout_WriteReg(WB_WriteReg),

        .Din_PC(MEM_PC),
        .Dout_PC(WB_PC)
    );

    // --------------------     WB     --------------------
    Mux Sel_MemToReg(
        .data_in1(WB_AluResult), .data_in2(WB_MemData),
        .select(WB_memtoreg), .data_out(MemToRegData)
    );

    Mux Sel_JAL(
        .data_in1(MemToRegData), .data_in2(WB_pcand4),
        .select(WB_jal), .data_out(WB_WriteBackdata)
    );

    EnablePC_Pipeline enable_pc(
        .syscall(WB_syscall),
        .show(WB_show),
        .rst(reset),
        .go(go),
        .clk(clk),
        .pc_enable(pcEnable)
    );


endmodule
