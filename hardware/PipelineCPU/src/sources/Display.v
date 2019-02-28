`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: Display
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module Display(
        input [31:0] leddata,
        input [1:0] select,
        input clk,
        input rst,
        output reg [7:0] seg,
        output reg [7:0] an
    );
    wire clk_N;
    reg [31:0] displayData;
    reg [2:0] counter;

    Divider #(10000)display_divider(.clk(clk), .clk_N(clk_N));

    initial begin
        seg = 8'b11111111;
        an = 0;
        displayData = 0;
        counter = 0;
    end

    always @(posedge clk_N) begin
        an <= ~(8'h1 << counter);
        case (displayData[counter * 4+:4])
            4'b0000: seg <= 8'b11000000;
            4'b0001: seg <= 8'b11111001;
            4'b0010: seg <= 8'b10100100;
            4'b0011: seg <= 8'b10110000;
            4'b0100: seg <= 8'b10011001;
            4'b0101: seg <= 8'b10010010;
            4'b0110: seg <= 8'b10000010;
            4'b0111: seg <= 8'b11111000;
            4'b1000: seg <= 8'b10000000;
            4'b1001: seg <= 8'b10010000;
            4'b1010: seg <= 8'b10001000;
            4'b1011: seg <= 8'b10000011;
            4'b1100: seg <= 8'b11000110;
            4'b1101: seg <= 8'b10100001;
            4'b1110: seg <= 8'b10000110;
            4'b1111: seg <= 8'b10001110;
            default: seg <= 8'b11111111;
        endcase

        counter <= counter + 1;

        displayData[3: 0] <= select != 2'b00 ? (leddata % 10) : leddata[3: 0];
        displayData[7: 4] <= select != 2'b00 ? (leddata / 10 % 10) : leddata[7: 4];
        displayData[11: 8] <= select != 2'b00 ? (leddata / 100 % 10) : leddata[11: 8];
        displayData[15: 12] <= select != 2'b00 ? (leddata / 1000 % 10) : leddata[15: 12];
        displayData[19: 16] <= select != 2'b00 ? (leddata / 10000 % 10) : leddata[19: 16];
        displayData[23: 20] <= select != 2'b00 ? (leddata / 100000 % 10) : leddata[23: 20];
        displayData[27: 24] <= select != 2'b00 ? (leddata / 1000000 % 10) : leddata[27: 24];
        displayData[31: 28] <= select != 2'b00 ? (leddata / 10000000 % 10) : leddata[31: 28];

        if (rst) begin
            displayData <= 0;
            counter <= 0;
            seg <= 8'b11111111;
            an <= 0;
        end
    end

endmodule
