`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: Compare
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Compare #(
        parameter DATA_WIDTH = 32
    )(
        input [DATA_WIDTH - 1:0] data_in1,
        input [DATA_WIDTH - 1:0] data_in2,
        output more, equal, less
    );
    assign more = ($signed(data_in1) > $signed(data_in2)) ? 1 : 0;
    assign equal = ($signed(data_in1) == $signed(data_in2)) ? 1 : 0;
    assign less = ($signed(data_in1) < $signed(data_in2)) ? 1 : 0;
endmodule
