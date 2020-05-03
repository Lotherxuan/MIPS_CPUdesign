`include "ENCODE.v"

module ID_EX(clk, rst, PC, RD1, RD2, IMM32, rs, rt, RF_rd, shamt, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, Shamt, PCSrc, MemControl, PC_out, RD1_out, RD2_out, IMM32_out, rs_out, rt_out , RF_rd_out, shamt_out, MemRead_out, MemtoReg_out, ALUop_out, MemWrite_out, ALUSrc_out, RegWrite_out, Shamt_out, PCSrc_out, MemControl_out);

input clk;
input rst;
input [31: 0] PC;
input [31: 0] RD1;
input [31: 0] RD2;
input [31: 0] IMM32;
input [4: 0] rs;
input [4: 0] rt;
input [4: 0] RF_rd;
input [4: 0] shamt;
input MemRead;
input [1: 0] MemtoReg;
input [4: 0] ALUop;
input MemWrite;
input ALUSrc;
input RegWrite;
input Shamt;
input [2: 0] PCSrc;
input [3: 0] MemControl;

output reg[31: 0] PC_out;
output reg[31: 0] RD1_out;
output reg[31: 0] RD2_out;
output reg[31: 0] IMM32_out;
output reg[4: 0] rs_out;
output reg[4: 0] rt_out;
output reg[4: 0] RF_rd_out;
output reg[4: 0] shamt_out;
output reg MemRead_out;
output reg[1: 0] MemtoReg_out;
output reg[4: 0] ALUop_out;
output reg MemWrite_out;
output reg ALUSrc_out;
output reg RegWrite_out;
output reg Shamt_out;
output reg[2: 0] PCSrc_out;
output reg[3: 0] MemControl_out;

initial
    begin
    PC_out <= 0;
    RD1_out <= 0;
    RD2_out <= 0;
    IMM32_out <= 0;
    rs_out <= 0;
    rt_out <= 0;
    RF_rd_out <= 0;
    shamt_out <= 0;
    MemRead_out <= 1'b0;
    MemtoReg_out <= 2'b00;
    ALUop_out <= `ALU_NOP;
    MemWrite_out <= 1'b0;
    ALUSrc_out <= 1'b0;
    RegWrite_out <= 1'b0;
    Shamt_out <= 1'b0;
    PCSrc_out <= `NPC_PLUS4;
    MemControl_out <= `MEM_NOP;
    end

always @(posedge rst)
    begin
    PC_out <= 0;
    RD1_out <= 0;
    RD2_out <= 0;
    IMM32_out <= 0;
    rs_out <= 0;
    rt_out <= 0;
    RF_rd_out <= 0;
    shamt_out <= 0;
    MemRead_out <= 1'b0;
    MemtoReg_out <= 2'b00;
    ALUop_out <= `ALU_NOP;
    MemWrite_out <= 1'b0;
    ALUSrc_out <= 1'b0;
    RegWrite_out <= 1'b0;
    Shamt_out <= 1'b0;
    PCSrc_out <= `NPC_PLUS4;
    MemControl_out <= `MEM_NOP;
    end

always @(posedge clk)
    begin
    PC_out <= PC;
    RD1_out <= RD1;
    RD2_out <= RD2;
    IMM32_out <= IMM32;
    rs_out <= rs;
    rt_out <= rt;
    RF_rd_out <= RF_rd;
    shamt_out <= shamt;
    MemRead_out <= MemRead;
    MemtoReg_out <= MemtoReg;
    ALUop_out <= ALUop;
    MemWrite_out <= MemWrite;
    ALUSrc_out <= ALUSrc;
    RegWrite_out <= RegWrite;
    Shamt_out <= Shamt;
    PCSrc_out <= PCSrc;
    MemControl_out <= MemControl;
    end

endmodule
