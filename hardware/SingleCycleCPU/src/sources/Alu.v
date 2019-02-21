`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-20
// Design Name: 
// Module Name: Alu
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Alu(
        input [31:0] x,
        input [31:0] y,
        input [4:0] shamt,
        input [3:0] AluOP,
        output reg [31:0] result,
        output reg [31:0] result2,
        output wire equal
    );

    initial begin
        result = 0;
        result2 = 0;
    end

    always @(x, y, AluOP) begin
        case (AluOP)
            4'd0: result = y << shamt;
            4'd1: result = y[31] ? ((~(32'hffff_ffff >> shamt)) | (y >> shamt)) : (y >> shamt);
            4'd2: result = y >> shamt;
            4'd3: result = x * y;
            4'd4: result = x / y;
            4'd5: result = x + y;
            4'd6: result = x - y;
            4'd7: result = x & y;
            4'd8: result = x | y;
            4'd9: result = x ^ y;
            4'd10: result = ~(x | y);
            4'd11: result = {31'd0, ($signed(x) < $signed(y))};
            4'd12: result = {31'd0, (x < y)};
            default: result = 0;
        endcase
    end

    assign equal = (x == y);

endmodule