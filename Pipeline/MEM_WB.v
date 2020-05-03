`include "ENCODE.v"

module MEM_WB(clk, rst, PC, ALU_result, Mem_data, RF_rd, MemtoReg, RegWrite, PCSrc, PC_out, ALU_result_out, Mem_data_out, RF_rd_out, MemtoReg_out, RegWrite_out, PCSrc_out);

input clk;
input rst;
input [31: 0] PC;
input [31: 0] ALU_result;
input [31: 0] Mem_data;
input [4: 0] RF_rd;
input [1: 0] MemtoReg;
input RegWrite;
input [2: 0] PCSrc;

output reg[31: 0] PC_out;
output reg[31: 0] ALU_result_out;
output reg[31: 0] Mem_data_out;
output reg[4: 0] RF_rd_out;
output reg[1: 0] MemtoReg_out;
output reg RegWrite_out;
output reg[2: 0] PCSrc_out;

initial
    begin
    PC_out <= 0;
    ALU_result_out <= 0;
    Mem_data_out <= 0;
    RF_rd_out <= 0;
    MemtoReg_out <= 2'b00;
    RegWrite_out <= 1'b0;
    PCSrc_out <= `NPC_PLUS4;
    end

always @(posedge rst)
    begin
    PC_out <= 0;
    ALU_result_out <= 0;
    Mem_data_out <= 0;
    RF_rd_out <= 0;
    MemtoReg_out <= 2'b00;
    RegWrite_out <= 1'b0;
    PCSrc_out <= `NPC_PLUS4;
    end

always @(posedge clk)
    begin
    PC_out <= PC;
    ALU_result_out <= ALU_result;
    Mem_data_out <= Mem_data;
    RF_rd_out <= RF_rd;
    MemtoReg_out <= MemtoReg;
    RegWrite_out <= RegWrite;
    PCSrc_out <= PCSrc;
    end

endmodule
