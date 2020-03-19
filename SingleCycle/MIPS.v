`include "ENCODE.v"

module MIPS(clk,rst);

input clk;
input rst;

//控制器相关
wire RegDst;
wire Jump;
wire Branch;//TODO branch和jump好像都不需要？？
wire MemRead;
wire MemtoReg;
wire[4:0] ALUop;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire[1:0] Ext;
wire[1:0] PCsrc;

//数据内存相关
wire [31:0] DM_out;
wire [9:0] DM_addr;

//算术运算相关
wire [31:0] AluMux_Result;
//算术运算相关
wire zero;
wire [31:0] ALU_Result;

//符号扩展相关
wire [31:0] Imm32;

//寄存器相关
wire [31:0] RD1;
wire [31:0] RD2;//从RF中读出来的数据
wire [31:0] RF_wd;//等待写入RF的数据

//目标寄存器相关
wire [4:0] RF_rd;

//指令本体
wire [31:0]AnInsturction;

//拆分指令
wire [5:0] Op;
wire [5:0] Funct;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [15:0] Imm16;
wire [25:0] IMM;

assign Op=AnInsturction[31:26];
assign Funct=AnInsturction[5:0];
assign rs=AnInsturction[25:21];
assign rt=AnInsturction[20:16];
assign rd=AnInsturction[15:11];
assign Imm16=AnInsturction[15:0];
assign IMM=AnInsturction[25:0];


//指令地址相关
wire [31:0] PC;
wire [31:0] NPC;
wire [9:0] PCAddr;
assign PCAddr= PC[11:2];

NPC npc (.PC(PC),.NPCop(PCsrc),.Zero(zero),.IMM(IMM),.Imm16(Imm16),.NPC(NPC));

PC pc(.clk(clk),.rst(rst),.NPC(NPC),.PC(PC));

IM im(.addr(PCAddr),.instr(AnInsturction));

assign RF_wd=(MemtoReg===1)?DM_out:ALU_Result;
assign RF_rd=(RegDst===0)?rt:rd;
RF rf(.clk(clk),.rst(rst),.RFWr(RegWrite),.A1(rs),.A2(rt),.A3(RF_rd),.WD(RF_wd),.RD1(RD1),.RD2(RD2));

EXT ext(.Imm16(Imm16),.EXTOp(Ext),.Imm32(Imm32));

assign AluMux_Result=(ALUSrc===0)? RD2:Imm32;
ALU alu(.A(RD1),.B(AluMux_Result),.ALUOp(ALUop),.C(ALU_Result),.Zero(zero));

assign DM_addr=ALU_Result[11:2];
MEM mem(.clk(clk),.rst(rst),.input_address(DM_addr),.input_data(RD2),.Wr(MemWrite),.output_data(DM_out));

CONTROL control(.Op(Op),.Func(Funct),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUop(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.Ext(Ext),.PCSrc(PCsrc));

endmodule