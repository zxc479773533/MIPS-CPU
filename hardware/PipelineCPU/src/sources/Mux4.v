`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-27
// Design Name: 
// Module Name: Mux4
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux4 #(
        parameter DATA_WIDTH = 32
    )(
        input [DATA_WIDTH - 1:0] data_in1,
        input [DATA_WIDTH - 1:0] data_in2,
        input [DATA_WIDTH - 1:0] data_in3,
        input [DATA_WIDTH - 1:0] data_in4,
        input [1:0] select,
        output [DATA_WIDTH - 1:0] data_out
    );
    reg [DATA_WIDTH - 1:0] result;
    initial begin
        result = 0;
    end
    always @(*) begin
        case (select)
            2'b00: result = data_in1;
            2'b01: result = data_in2;
            2'b10: result = data_in3;
            2'b11: result = data_in4;
            default: result = 0;
        endcase
    end
    assign data_out = result;
endmodule
