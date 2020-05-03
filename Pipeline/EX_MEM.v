`include "ENCODE.v"

module EX_MEM(clk, rst, PC, ALU_result, RD2, RF_rd, MemRead, MemtoReg, MemWrite, RegWrite, PCSrc, MemControl, PC_out, ALU_result_out, RD2_out, RF_rd_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, PCSrc_out, MemControl_out);

input clk;
input rst;
input [31: 0] PC;
input [31: 0] ALU_result;
input [31: 0] RD2;
input [4: 0] RF_rd;
input MemRead;
input [1: 0] MemtoReg;
input MemWrite;
input RegWrite;
input [2: 0] PCSrc;
input [3: 0] MemControl;

output reg[31: 0] PC_out;
output reg[31: 0] ALU_result_out;
output reg[31: 0] RD2_out;
output reg[4: 0] RF_rd_out;
output reg MemRead_out;
output reg[1: 0] MemtoReg_out;
output reg MemWrite_out;
output reg RegWrite_out;
output reg[2: 0] PCSrc_out;
output reg[3: 0] MemControl_out;

initial
    begin
    PC_out <= 0;
    ALU_result_out <= 0;
    RD2_out <= 0;
    RF_rd_out <= 0;
    MemRead_out <= 1'b0;
    MemtoReg_out <= 2'b00;
    MemWrite_out <= 1'b0;
    RegWrite_out <= 1'b0;
    PCSrc_out <= `NPC_PLUS4;
    MemControl_out <= `MEM_NOP;
    end

always @(posedge rst)
    begin
    PC_out <= 0;
    ALU_result_out <= 0;
    RD2_out <= 0;
    RF_rd_out <= 0;
    MemRead_out <= 1'b0;
    MemtoReg_out <= 2'b00;
    MemWrite_out <= 1'b0;
    RegWrite_out <= 1'b0;
    PCSrc_out <= `NPC_PLUS4;
    MemControl_out <= `MEM_NOP;
    end

always @(posedge clk)
    begin
    PC_out <= PC;
    ALU_result_out <= ALU_result;
    RD2_out <= RD2;
    RF_rd_out <= RF_rd;
    MemRead_out <= MemRead;
    MemtoReg_out <= MemtoReg;
    MemWrite_out <= MemWrite;
    RegWrite_out <= RegWrite;
    PCSrc_out <= PCSrc;
    MemControl_out <= MemControl;
    end

endmodule
