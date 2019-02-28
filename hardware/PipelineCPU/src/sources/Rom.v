`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: Rom
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Rom #(
        parameter ADDR_WIDTH = 10,
        parameter DATA_WIDTH = 32,
        parameter ROM_SIZE = 1024
    )(
        input [ADDR_WIDTH - 1:0] addr,
        output [DATA_WIDTH - 1:0] data
    );

    reg [31:0] memory [ROM_SIZE - 1:0];

    initial begin
        $readmemh("instructions.txt", memory);
    end

    assign data = memory[addr];

endmodule
