`include "ENCODE.v"

module MIPS(clk, rst);

input clk;
input rst;

//IF阶段
wire [31: 0] IF_PC;
wire [31: 0] IF_NPC;
wire [31: 0] IF_Instr;

//ID阶段
wire [31: 0] ID_PC;
wire [31: 0] ID_Instr;
wire [31: 0] ID_Imm32;
wire [31: 0] ID_RD1;
wire [31: 0] ID_RD2;
//拆分指令
wire [5: 0] ID_Op;
wire [5: 0] ID_Funct;
wire [4: 0] ID_rs;
wire [4: 0] ID_rt;
wire [4: 0] ID_rd;
wire [4: 0] ID_RF_rd;
wire [15: 0] ID_Imm16;
wire [25: 0] ID_IMM;
wire [4: 0] ID_shamt;
//由控制器产生的控制信号
wire[1: 0] ID_RegDst;
wire ID_MemRead;
wire[1: 0] ID_MemtoReg;
wire[4: 0] ID_ALUop;
wire ID_MemWrite;
wire ID_ALUSrc;
wire ID_RegWrite;
wire ID_Shamt;
wire[1: 0] ID_Ext;
wire[2: 0] ID_PCSrc;
wire[3: 0] ID_MemControl;
wire ID_Jump;
wire ID_Branch;

wire IF_ID_flush;
wire PC_unchanged;
wire ID_zero;

wire [31: 0] ID_RD1_forward;
wire [31: 0] ID_RD2_forward;

//EX阶段
//从ID/EX寄存器中读取出来的控制信号和两个源操作数
wire [31: 0] EX_PC;
wire [31: 0] EX_RD1;
wire [31: 0] EX_RD2;
wire [31: 0] EX_IMM32;
wire [4: 0] EX_rs;
wire [4: 0] EX_rt;
wire [4: 0] EX_RF_rd;
wire [4: 0] EX_shamt;
wire[1: 0] EX_RegDst;
wire EX_MemRead;
wire[1: 0] EX_MemtoReg;
wire[4: 0] EX_ALUop;
wire EX_MemWrite;
wire EX_ALUSrc;
wire EX_RegWrite;
wire EX_Shamt;
wire[2: 0] EX_PCSrc;
wire[3: 0] EX_MemControl;

wire [31: 0] EX_RD1_forward;
wire [31: 0] EX_RD2_forward;
wire [31: 0] EX_ALU_Result;
wire EX_zero;

wire [1: 0] ForwardA;
wire [1: 0] ForwardB;
wire [1: 0] ForwardC;
wire [1: 0] ForwardD;
wire [31: 0] EX_ALU1_forward;
wire [31: 0] EX_ALU2_forward;

//MEM阶段
//从EX/MEM寄存器中读取出来的控制信号,ALU运算结果和第二个源操作数
wire [31: 0] MEM_PC;
wire [31: 0] MEM_ALU_result;
wire [31: 0] MEM_RD2;
wire [4: 0] MEM_RF_rd;
wire MEM_MemRead;
wire[1: 0] MEM_MemtoReg;
wire MEM_MemWrite;
wire MEM_RegWrite;
wire[2: 0] MEM_PCSrc;
wire[3: 0] MEM_MemControl;

wire [31: 0] MEM_Mem_data;

//WB阶段
//从MEM/WB寄存器中读取出来的控制信号,ALU运算结果和从MEM中读取出来的数据
wire [31: 0] WB_PC;
wire [31: 0] WB_ALU_result;
wire [31: 0] WB_Mem_data;
wire [4: 0] WB_RF_rd;
wire [1: 0] WB_MemtoReg;
wire WB_RegWrite;
wire [2: 0] WB_PCSrc;

wire [31: 0] WB_RF_wd;

//拆分指令
assign ID_Op = ID_Instr[31: 26];
assign ID_Funct = ID_Instr[5: 0];
assign ID_rs = ID_Instr[25: 21];
assign ID_rt = ID_Instr[20: 16];
assign ID_rd = ID_Instr[15: 11];
assign ID_Imm16 = ID_Instr[15: 0];
assign ID_IMM = ID_Instr[25: 0];
assign ID_shamt = ID_Instr[10: 6];

assign ID_zero = (ID_RD1_forward == ID_RD2_forward);

NPC npc(
      .PC(IF_PC),
      .ID_PC(ID_PC),
      .NPCop(ID_PCSrc),
      .Zero(ID_zero),
      .IMM(ID_IMM),
      .Imm16(ID_Imm16),
      .rs(ID_RD1_forward),
      .harzard(PC_unchanged),
      .NPC(IF_NPC)
    );

PC pc(
     .clk(clk),
     .rst(rst),
     .NPC(IF_NPC),
     .PC(IF_PC)
   );

IM im(
     .addr(IF_PC),
     .instr(IF_Instr)
   );

IF_ID if_id(
        .clk(clk),
        .rst(rst),
        .PC(IF_PC),
        .Instr(IF_Instr),
        .harzard(IF_ID_flush),
        .PC_out(ID_PC),
        .Instr_out(ID_Instr)
      );

CONTROL control(
          .Op(ID_Op),
          .Func(ID_Funct),
          .RegDst(ID_RegDst),
          .Jump(ID_Jump),
          .Branch(ID_Branch),
          .MemRead(ID_MemRead),
          .MemtoReg(ID_MemtoReg),
          .ALUop(ID_ALUop),
          .MemWrite(ID_MemWrite),
          .ALUSrc(ID_ALUSrc),
          .RegWrite(ID_RegWrite),
          .Shamt(ID_Shamt),
          .Ext(ID_Ext),
          .PCSrc(ID_PCSrc),
          .MemControl(ID_MemControl)
        );

EXT ext(
      .Imm16(ID_Imm16),
      .EXTOp(ID_Ext),
      .Imm32(ID_Imm32)
    );

RF rf(
     .clk(clk),
     .rst(rst),
     .RFWr(WB_RegWrite),
     .A1(ID_rs),
     .A2(ID_rt),
     .A3(WB_RF_rd),
     .WD(WB_RF_wd),
     .RD1(ID_RD1),
     .RD2(ID_RD2)
   );

MUX4 #(32) mux4_RD1_forward(
       .d0(ID_RD1),
       .d1(EX_ALU_Result),
       .d2(MEM_ALU_result),
       .d3(WB_RF_wd),
       .select(ForwardC),
       .dout(ID_RD1_forward)
     );

MUX4 #(32) mux4_RD2_forward(
       .d0(ID_RD2),
       .d1(EX_ALU_Result),
       .d2(MEM_ALU_result),
       .d3(WB_RF_wd),
       .select(ForwardD),
       .dout(ID_RD2_forward)
     );

HARZARD hardzard(
          .ID_rs(ID_rs),
          .ID_rt(ID_rt),
          .EX_rt(EX_rt),
          .ID_PCSrc(ID_PCSrc),
          .EX_MemRead(EX_MemRead),
          .IF_ID_flush(IF_ID_flush),
          .PC_unchanged(PC_unchanged)
        );

MUX4 #(5) mux4_RFRD(
       .d0(ID_rt),
       .d1(ID_rd),
       .d2(5'd31),
       .d3(5'd0),
       .select(ID_RegDst),
       .dout(ID_RF_rd)
     );

ID_EX id_ex(
        .clk(clk),
        .rst(rst),
        .PC(ID_PC),
        .RD1(ID_RD1),
        .RD2(ID_RD2),
        .IMM32(ID_Imm32),
        .rs(ID_rs),
        .rt(ID_rt),
        .RF_rd(ID_RF_rd),
        .shamt(ID_shamt),
        .MemRead(ID_MemRead),
        .MemtoReg(ID_MemtoReg),
        .ALUop(ID_ALUop),
        .MemWrite(ID_MemWrite),
        .ALUSrc(ID_ALUSrc),
        .RegWrite(ID_RegWrite),
        .Shamt(ID_Shamt),
        .PCSrc(ID_PCSrc),
        .MemControl(ID_MemControl),
        .PC_out(EX_PC),
        .RD1_out(EX_RD1),
        .RD2_out(EX_RD2),
        .IMM32_out(EX_IMM32),
        .rs_out(EX_rs),
        .rt_out(EX_rt),
        .RF_rd_out(EX_RF_rd),
        .shamt_out(EX_shamt),
        .MemRead_out(EX_MemRead),
        .MemtoReg_out(EX_MemtoReg),
        .ALUop_out(EX_ALUop),
        .MemWrite_out(EX_MemWrite),
        .ALUSrc_out(EX_ALUSrc),
        .RegWrite_out(EX_RegWrite),
        .Shamt_out(EX_Shamt),
        .PCSrc_out(EX_PCSrc),
        .MemControl_out(EX_MemControl)
      );

MUX2 #(32) mux2_ALUA(
       .d0(EX_RD1_forward),
       .d1({27'd0, EX_shamt[4: 0]}),
       .select(EX_Shamt),
       .dout(EX_ALU1_forward)
     );

MUX2 #(32) mux2_ALUB(
       .d0(EX_RD2_forward),
       .d1(EX_IMM32),
       .select(EX_ALUSrc),
       .dout(EX_ALU2_forward)
     );

FORWARD forward(
          .ID_rs(ID_rs),
          .ID_rt(ID_rt),
          .EX_rs(EX_rs),
          .EX_rt(EX_rt),
          .EX_RF_rd(EX_RF_rd),
          .MEM_RF_rd(MEM_RF_rd),
          .WB_RF_rd(WB_RF_rd),
          .EX_RegWrite(EX_RegWrite),
          .MEM_RegWrite(MEM_RegWrite),
          .WB_RegWrite(WB_RegWrite),
          .MEM_MemRead(MEM_MemRead),
          .ForwardA(ForwardA),
          .ForwardB(ForwardB),
          .ForwardC(ForwardC),
          .ForwardD(ForwardD)
        );

MUX4 #(32) mux4_ALUA_forward(
       .d0(EX_RD1),
       .d1(MEM_ALU_result),
       .d2(WB_RF_wd),
       .d3(MEM_Mem_data),
       .select(ForwardA),
       .dout(EX_RD1_forward)
     );

MUX4 #(32) mux4_ALUB_forward(
       .d0(EX_RD2),
       .d1(MEM_ALU_result),
       .d2(WB_RF_wd),
       .d3(MEM_Mem_data),
       .select(ForwardB),
       .dout(EX_RD2_forward)
     );

ALU alu(
      .A(EX_ALU1_forward),
      .B(EX_ALU2_forward),
      .ALUOp(EX_ALUop),
      .C(EX_ALU_Result),
      .Zero(EX_zero)
    );

EX_MEM ex_mem(
         .clk(clk),
         .rst(rst),
         .PC(EX_PC),
         .ALU_result(EX_ALU_Result),
         .RD2(EX_RD2_forward),
         .RF_rd(EX_RF_rd),
         .MemRead(EX_MemRead),
         .MemtoReg(EX_MemtoReg),
         .MemWrite(EX_MemWrite),
         .RegWrite(EX_RegWrite),
         .PCSrc(EX_PCSrc),
         .MemControl(EX_MemControl),
         .PC_out(MEM_PC),
         .ALU_result_out(MEM_ALU_result),
         .RD2_out(MEM_RD2),
         .RF_rd_out(MEM_RF_rd),
         .MemRead_out(MEM_MemRead),
         .MemtoReg_out(MEM_MemtoReg),
         .MemWrite_out(MEM_MemWrite),
         .RegWrite_out(MEM_RegWrite),
         .PCSrc_out(MEM_PCSrc),
         .MemControl_out(MEM_MemControl)
       );

MEM mem(
      .clk(clk),
      .rst(rst),
      .input_address(MEM_ALU_result),
      .input_data(MEM_RD2),
      .Wr(MEM_MemWrite),
      .MemControl(MEM_MemControl),
      .output_data(MEM_Mem_data)
    );

MEM_WB mem_wb(
         .clk(clk),
         .rst(rst),
         .PC(MEM_PC),
         .ALU_result(MEM_ALU_result),
         .Mem_data(MEM_Mem_data),
         .RF_rd(MEM_RF_rd),
         .MemtoReg(MEM_MemtoReg),
         .RegWrite(MEM_RegWrite),
         .PCSrc(MEM_PCSrc),
         .PC_out(WB_PC),
         .ALU_result_out(WB_ALU_result),
         .Mem_data_out(WB_Mem_data),
         .RF_rd_out(WB_RF_rd),
         .MemtoReg_out(WB_MemtoReg),
         .RegWrite_out(WB_RegWrite),
         .PCSrc_out(WB_PCSrc)
       );

MUX4 #(32) mux4_RFWD(
       .d0(WB_ALU_result),
       .d1(WB_Mem_data),
       .d2((WB_PC + 4)),
       .d3(32'd0),
       .select(WB_MemtoReg),
       .dout(WB_RF_wd)
     );



endmodule
