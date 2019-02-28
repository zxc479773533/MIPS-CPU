`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: Conflict
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Conflict(
        input [4:0] EX_WriteReg,
        input [4:0] MEM_WriteReg,
        input [4:0] ID_R1,
        input [4:0] ID_R2,
        input EX_RegWrite,
        input EX_MemToReg,
        input MEM_RegWrite,
        input MEM_MemToReg,
        input R1_Used,
        input R2_Used,
        output load_use,
        output conflict,
        output [1:0] forward1,
        output [1:0] forward2
    );

    wire R1_Equal_EX_WriteReg;
    wire R2_Equal_EX_WriteReg;

    wire R1_confict;
    wire R1_num_confict;
    wire R2_confict;
    wire R2_num_confict;
    wire load_use_conflict;

    wire [1:0] forward1_tmp1;
    wire [1:0] forward1_tmp2;
    wire [1:0] forward2_tmp1;
    wire [1:0] forward2_tmp2;

    assign R1_Equal_EX_WriteReg = (ID_R1 == EX_WriteReg);
    assign R2_Equal_EX_WriteReg = (ID_R2 == EX_WriteReg);

    assign R1_num_confict = ((MEM_WriteReg != 0) & (MEM_RegWrite) & (ID_R1 == MEM_WriteReg)) | ((EX_WriteReg != 0) & (EX_RegWrite) & (ID_R1 == EX_WriteReg));
    assign R1_confict = (ID_R1 != 0) & (R1_Used) & (R1_num_confict);

    assign R2_num_confict = ((MEM_WriteReg != 0) & (MEM_RegWrite) & (ID_R2 == MEM_WriteReg)) | ((EX_WriteReg != 0) & (EX_RegWrite) & (ID_R2 == EX_WriteReg));
    assign R2_confict = (ID_R2 != 0) & (R2_Used) & (R2_num_confict);

    assign conflict = R1_confict | R2_confict;

    assign load_use_conflict = ((ID_R1 != 0) & (R1_Used) & (ID_R1 == EX_WriteReg) & (EX_RegWrite) & (EX_WriteReg != 0)) | ((ID_R2 != 0) & (R2_Used) & (ID_R2 == EX_WriteReg) & (EX_RegWrite) & (EX_WriteReg != 0));
    assign load_use = EX_MemToReg & load_use_conflict;

    Mux #(2)forward1_1(
        .data_in1(2'b01),
        .data_in2(2'b10),
        .select(MEM_MemToReg),
        .data_out(forward1_tmp1)
    );

    Mux #(2)forward1_2(
        .data_in1(forward1_tmp1),
        .data_in2(2'b11),
        .select(R1_Equal_EX_WriteReg),
        .data_out(forward1_tmp2)
    );

    Mux #(2)forward1_3(
        .data_in1(2'b00),
        .data_in2(forward1_tmp2),
        .select(R1_confict),
        .data_out(forward1)
    );

    Mux #(2)forward2_1(
        .data_in1(2'b01),
        .data_in2(2'b10),
        .select(MEM_MemToReg),
        .data_out(forward2_tmp1)
    );

    Mux #(2)forward2_2(
        .data_in1(forward2_tmp1),
        .data_in2(2'b11),
        .select(R2_Equal_EX_WriteReg),
        .data_out(forward2_tmp2)
    );

    Mux #(2)forward2_3(
        .data_in1(2'b00),
        .data_in2(forward2_tmp2),
        .select(R2_confict),
        .data_out(forward2)
    );

endmodule