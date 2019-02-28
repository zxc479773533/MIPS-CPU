`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: LedData
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module LedData_Pipeline (
        input [31:0] leddata_in,
        input rst,
        input clk,
        input pc_enable,
        input jmp,
        input branchif,
        input stop1,
        input stop2,
        input load_use,
        input ShowLoadUse,
        input [1:0] select,
        output reg [31:0] leddata_out
    );
    wire load_use_count;
    wire [31:0] cycles;
    wire [31:0] jmp_clcyes;
    wire [31:0] branch_clcyes;
    wire [31:0] loaduse_clcyes;

    Counter cycle_counter(.clk(clk), .rst(rst), .enable(pc_enable), .data_out(cycles));

    Counter jmp_counter(.clk(clk), .rst(rst), .enable(jmp), .data_out(jmp_clcyes));

    Counter branchif_counter(.clk(clk), .rst(rst), .enable(branchif), .data_out(branch_clcyes));

    Counter loaduse_counter(.clk(clk), .rst(rst), .enable(load_use_count), .data_out(loaduse_clcyes));

    always @(*) begin
        if (ShowLoadUse == 1) begin
            leddata_out <= loaduse_clcyes;
        end
        else begin
            case (select)
                2'b00: leddata_out <= leddata_in;
                2'b01: leddata_out <= cycles;
                2'b10: leddata_out <= jmp_clcyes;
                2'b11: leddata_out <= branch_clcyes;
            endcase
        end
    end

    assign load_use_count = load_use & pc_enable & ~(stop1 | stop2);

endmodule