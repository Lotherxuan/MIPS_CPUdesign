`include "ENCODE.v"

module MIPS(clk,rst);

input clk;
input rst;

//output [15:0] temp_control_out;
//output [31:0] temp_data_out;

wire RegDst;
wire Jump;
wire Branch;
wire MemRead;
wire MemtoReg;
wire[4:0] ALUop;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire [1:0] Ext;

//算术运算相关
wire zero;
wire [31:0] ALU_Result;

//指令地址相关

wire [31:0] PC;
wire [31:0] NPC;
wire [9:0] PCAddr;
assign PCAddr= PC[11:2];
assign PCSel=((Branch && zero)===1)?1:0;

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

//寄存器相关
wire [4:0] RF_rd;
assign RF_rd=(RegDst===0)?rd:rt;

//符号扩展相关
wire [31:0] Imm32;

//数据内存相关
wire [31:0] DM_out;
wire [11:2] DM_addr;

//寄存器相关
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] RF_WD;
assign RF_WD=(MemtoReg===1)?DM_out:ALU_Result;

//算术运算相关
wire [31:0] AluMux_Result;
assign AluMux_Result=(ALUSrc===0)? RD2:Imm32;

//指令计数器模块
NPC npc (.PC(PC),.NPCop(NPCop));

PC pc(.clk(clk),.rst(rst),.NPC(NPC),.PC(PC));

//指令模块
IM im(.addr(PCAddr),.dout(AnInsturction));

endmodule