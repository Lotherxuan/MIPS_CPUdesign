`include "ENCODE.v"

module MIPS(clk,rst);

input clk;
input rst;

//控制器相关
wire[1:0] RegDst;
wire Jump;
wire Branch;//在本cpu设计中所有地址相关操作都由PCsrc控制，branch和jump都为冗余信号，可以去掉
wire MemRead;
wire[1:0] MemtoReg;
wire[4:0] ALUop;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire Shamt;
wire[1:0] Ext;
wire[2:0] PCsrc;
wire[3:0] MemControl;

//数据内存相关
wire [31:0] DM_out;

//算术运算相关
wire [31:0] Alu1;//第一个操作数
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
wire [31:0]Instruction;

//拆分指令
wire [5:0] Op;
wire [5:0] Funct;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [15:0] Imm16;
wire [25:0] IMM;
wire [5:0] shamt;

//指令地址相关
wire [31:0] PC;
wire [31:0] NPC;

assign Op=Instruction[31:26];
assign Funct=Instruction[5:0];
assign rs=Instruction[25:21];
assign rt=Instruction[20:16];
assign rd=Instruction[15:11];
assign Imm16=Instruction[15:0];
assign IMM=Instruction[25:0];
assign shamt=Instruction[10:6];


NPC npc (.PC(PC),.NPCop(PCsrc),.Zero(zero),.IMM(IMM),.Imm16(Imm16),.rs(RD1),.NPC(NPC));

PC pc(.clk(clk),.rst(rst),.NPC(NPC),.PC(PC));

IM im(.addr(PC),.instr(Instruction));

MUX4_32 mux4_32(.d0(ALU_Result),.d1(DM_out),.d2((PC+4)),.d3(32'd0),.select(MemtoReg),.dout(RF_wd));
//assign RF_wd0=(MemtoReg===1)?DM_out:ALU_Result;
//assign RF_wd=((PCsrc===`NPC_JAL)||(PCsrc==`NPC_JALR))?(PC+4):RF_wd0;
MUX4_5 mux4_5(.d0(rt),.d1(rd),.d2(5'd31),.d3(5'd0),.select(RegDst),.dout(RF_rd));

RF rf(.clk(clk),.rst(rst),.RFWr(RegWrite),.A1(rs),.A2(rt),.A3(RF_rd),.WD(RF_wd),.RD1(RD1),.RD2(RD2));

EXT ext(.Imm16(Imm16),.EXTOp(Ext),.Imm32(Imm32));

MUX2_32 mux2_32_0(.d0(RD2),.d1(Imm32),.select(ALUSrc),.dout(AluMux_Result));

MUX2_32 mux2_32_1(.d0(RD1),.d1({26'd0,shamt[5:0]}),.select(Shamt),.dout(Alu1));

ALU alu(.A(Alu1),.B(AluMux_Result),.ALUOp(ALUop),.C(ALU_Result),.Zero(zero));

MEM mem(.clk(clk),.rst(rst),.input_address(ALU_Result),.input_data(RD2),.Wr(MemWrite),.MemControl(MemControl),.output_data(DM_out));

CONTROL control(.Op(Op),.Func(Funct),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUop(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.Shamt(Shamt),.Ext(Ext),.PCSrc(PCsrc),.MemControl(MemControl));

endmodule