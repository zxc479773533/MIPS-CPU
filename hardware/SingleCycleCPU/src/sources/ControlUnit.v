`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: zxcpyp
// 
// Create Date: 2019-02-19
// Design Name: 
// Module Name: ControlUnit
// Project Name: MIPS CPU
// Target Devices: Nexys 4 DDR
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnit(
    input [5:0] opcode,
    input [5:0] func,
    output reg JMP, JR, SignedExt, Beq, Bne, MemToReg, MemWrite, AluSrcB, RegWrite, JAL, RegDst, Syscall,
    output reg [3:0] AluOP
);
initial begin
    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
    MemWrite = 0; AluSrcB = 0; RegWrite = 0; JAL = 0; RegDst = 0; Syscall = 0;
    AluOP = 4'b0000;
end

always @(opcode or func) begin
    case (opcode)
        6'b000000:begin // 0; J and R type
            case(func)
                6'b000000:begin // 0; sll
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0000;
                end
                6'b000010:begin // 2; srl
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0010;
                end
                6'b000011:begin // 3; sra
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0001;
                end
                6'b001000:begin // 8; jr
                    JMP = 1; JR = 1; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 0; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0000;
                end
                6'b001100:begin // 12; syscall
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 0; JAL = 0; RegDst = 0; Syscall = 1;
                    AluOP = 4'b0000;
                end
                6'b100000:begin // 32; add
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0101;
                end
                6'b100001:begin // 33; addu
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0101;
                end
                6'b100010:begin // 34; sub
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0110;
                end
                6'b100011:begin // 35; subu
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0110;
                end
                6'b100100:begin // 36; and
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b0111;
                end
                6'b100101:begin // 37; or
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b1000;
                end
                6'b100110:begin // 38; xor
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b1001;
                end
                6'b100111:begin // 39; nor
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b1010;
                end
                6'b101010:begin // 42; slt
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b1011;
                end
                6'b101011:begin // 43; sltu
                    JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
                    MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 0; RegDst = 1; Syscall = 0;
                    AluOP = 4'b1100;
                end
            endcase
        end
        6'b000010:begin // 2; j
            JMP = 1; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 0; RegWrite = 0; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0000;
        end
        6'b000011:begin // 3; jal
            JMP = 1; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 0; RegWrite = 1; JAL = 1; RegDst = 0; Syscall = 0;
            AluOP = 4'b0000;
        end
        6'b000100:begin // 4; beq
            JMP = 0; JR = 0; SignedExt = 0; Beq = 1; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 0; RegWrite = 0; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0000;
        end
        6'b000101:begin // 5; bne
            JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 1; MemToReg = 0;
            MemWrite = 0; AluSrcB = 0; RegWrite = 0; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0000;
        end
        6'b001000:begin // 8; addi
            JMP = 0; JR = 0; SignedExt = 1; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 1; RegWrite = 1; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0101;
        end
        6'b001001:begin // 9; addiu
            JMP = 0; JR = 0; SignedExt = 1; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 1; RegWrite = 1; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0101;
        end
        6'b001010:begin // 10; slti
            JMP = 0; JR = 0; SignedExt = 1; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 1; RegWrite = 1; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b1011;
        end
        6'b001100:begin // 12; andi
            JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 1; RegWrite = 1; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0111;
        end
        6'b001101:begin // 13; ori
            JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 0; AluSrcB = 1; RegWrite = 1; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b1000;
        end
        6'b100011:begin // 35; lw
            JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 1;
            MemWrite = 0; AluSrcB = 1; RegWrite = 1; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0101;
        end

        6'b101011:begin // 43; sw
            JMP = 0; JR = 0; SignedExt = 0; Beq = 0; Bne = 0; MemToReg = 0;
            MemWrite = 1; AluSrcB = 1; RegWrite = 0; JAL = 0; RegDst = 0; Syscall = 0;
            AluOP = 4'b0101;
        end
    endcase
end

endmodule
