`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: Mux
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux #(
        parameter DATA_WIDTH = 32
    )(
        input [DATA_WIDTH - 1:0] data_in1,
        input [DATA_WIDTH - 1:0] data_in2,
        input select,
        output [DATA_WIDTH - 1:0] data_out
    );
    assign data_out = (select == 0 ? data_in1 : data_in2);
endmodule
