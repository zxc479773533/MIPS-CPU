`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: Counter
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Counter #(
        parameter DATA_WIDTH = 32
    )(
        input clk,
        input rst,
        input enable,
        output reg [DATA_WIDTH - 1:0] data_out
    );
    
    initial begin
        data_out = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst == 1) begin
            data_out = 0;
        end
        else if (enable == 1) begin
            begin
                data_out <= data_out + 1;
            end
        end
    end
endmodule
