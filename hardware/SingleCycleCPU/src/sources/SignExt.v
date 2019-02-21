`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: SignExt
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module SignExt #(
        parameter DATA_WIDTH_IN = 16
    )(
        input [DATA_WIDTH_IN - 1:0] data_in,
        input sign,
        output [31:0] data_out
    );
    wire [31:0] signext_data;
    wire [31:0] unsignext_data;
    assign signext_data = {{(32 - DATA_WIDTH_IN){data_in[DATA_WIDTH_IN - 1]}}, data_in};
    assign unsignext_data = {{(32 - DATA_WIDTH_IN){1'b0}}, data_in};
    assign data_out = sign == 1 ? signext_data : unsignext_data;
endmodule
