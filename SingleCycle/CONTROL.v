`include "ENCODE.v"
module CONTROL(Op, Func, RegDst, Jump, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, Shamt, Ext, PCSrc, MemControl);
//理论上来说PCSrc是来间接信号，但在现有设计中PCSrc由CONTROL产生

input [5: 0] Op;
input [5: 0] Func;

output reg[1: 0] RegDst; //写寄存器时的目标寄存器，为01时写rd,为00时写rt,为10时写第31号寄存器
output reg Jump; //跳转指令
output reg Branch; //分支指令
output reg MemRead; //读存储器
output reg[1: 0] MemtoReg; //为01时写入的数据来自数据存储器,为00时来自ALU计算的结果,为10时来自PC+4
output reg[4: 0] ALUop;
output reg MemWrite; //为1时数据存储器写使能有效
output reg ALUSrc; //为1时ALU的第二个操作数来自符号扩展，为0时来自rt 默认为0
output reg RegWrite; //为1时写入register有效
output reg Shamt; //为1时ALU的第一个操作数来自shamt字段
output reg[1: 0] Ext; //决定符号扩展的类型
output reg[2: 0] PCSrc;
output reg[3: 0] MemControl;

always@( * )
    begin
    RegDst <= 2'b01;
    Jump <= 1'b0;
    Branch <= 1'b0;
    MemRead <= 1'b0;
    MemtoReg <= 2'b00;
    ALUop <= `ALU_NOP;
    MemWrite <= 1'b0;
    ALUSrc <= 1'b0;
    RegWrite <= 1'b0;
    Shamt <= 1'b0;
    Ext <= `EXT_ZERO;
    PCSrc <= `NPC_PLUS4;
    MemControl <= `MEM_NOP;

      case (Op)
      `R_OP:
          begin
          RegDst <= 2'b01;
          RegWrite <= 1'b1;
            case (Func)
            `ADD_FUNCT:
                begin
                ALUop <= `ALU_ADD;
                end
            `ADDU_FUNCT:
                begin
                ALUop <= `ALU_ADDU;
                end
            `AND_FUNCT:
                begin
                ALUop <= `ALU_AND;
                end
            `SUB_FUNCT:
                begin
                ALUop <= `ALU_SUB;
                end
            `SUBU_FUNCT:
                begin
                ALUop <= `ALU_SUBU;
                end
            `NOR_FUNCT:
                begin
                ALUop <= `ALU_NOR;
                end
            `OR_FUNCT:
                begin
                ALUop <= `ALU_OR;
                end
            `XOR_FUNCT:
                begin
                ALUop <= `ALU_XOR;
                end
            `SLT_FUNCT:
                begin
                ALUop <= `ALU_SLT;
                end
            `SLTU_FUNCT:
                begin
                ALUop <= `ALU_SLTU;
                end
            `SLL_FUNCT:
                begin
                ALUop <= `ALU_SLL;
                Shamt <= 1'b1;
                end
            `SRL_FUNCT:
                begin
                ALUop <= `ALU_SRL;
                Shamt <= 1'b1;
                end
            `SRA_FUNCT:
                begin
                ALUop <= `ALU_SRA;
                Shamt <= 1'b1;
                end
            `SLLV_FUNCT:
                begin
                ALUop <= `ALU_SLLV;
                end
            `SRLV_FUNCT:
                begin
                ALUop <= `ALU_SRLV;
                end
            `SRAV_FUNCT:
                begin
                ALUop <= `ALU_SRAV;
                end
            `JALR_FUNCT:
                begin
                MemtoReg <= 2'b10;
                PCSrc <= `NPC_JALR;
                end
            `JR_FUNCT:
                begin
                PCSrc <= `NPC_JR;
                RegWrite <= 1'b0;
                end
            endcase
          end
      `ADDI_OP:
          begin
          RegDst <= 2'b00;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          end
      `ORI_OP:
          begin
          RegDst <= 2'b00;
          ALUop <= `ALU_OR;
          ALUSrc <= 1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          end
      `ANDI_OP:
          begin
          RegDst <= 2'b00;
          ALUop <= `ALU_AND;
          ALUSrc <= 1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          end
      `LUI_OP:
          begin
          RegDst <= 2'b00;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_HIGHPOS;
          end
      `SLTI_OP:
          begin
          RegDst <= 2'b00;
          ALUop <= `ALU_SLT;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          end
      `BEQ_OP:
          begin
          PCSrc <= `NPC_BRANCH;
          end
      `BNE_OP:
          begin
          PCSrc <= `NPC_BNE;
          end
      `SW_OP:
          begin
          ALUop <= `ALU_ADD;
          MemWrite <= 1'b1;
          ALUSrc <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_SW;
          end
      `SB_OP:
          begin
          ALUop <= `ALU_ADD;
          MemWrite <= 1'b1;
          ALUSrc <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_SB;
          end
      `SH_OP:
          begin
          ALUop <= `ALU_ADD;
          MemWrite <= 1'b1;
          ALUSrc <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_SH;
          end
      `LW_OP:
          begin
          RegDst <= 2'b00;
          MemRead <= 1'b1;
          MemtoReg <= 2'b01;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_LW;
          end
      `LB_OP:
          begin
          RegDst <= 2'b00;
          MemRead <= 1'b1;
          MemtoReg <= 2'b01;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_LB;
          end
      `LH_OP:
          begin
          RegDst <= 2'b00;
          MemRead <= 1'b1;
          MemtoReg <= 2'b01;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_LH;
          end
      `LBU_OP:
          begin
          RegDst <= 2'b00;
          MemRead <= 1'b1;
          MemtoReg <= 2'b01;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_LBU;
          end
      `LHU_OP:
          begin
          RegDst <= 2'b00;
          MemRead <= 1'b1;
          MemtoReg <= 2'b01;
          ALUop <= `ALU_ADD;
          ALUSrc <= 1'b1;
          RegWrite <= 1'b1;
          Ext <= `EXT_SIGNED;
          MemControl <= `MEM_LHU;
          end
      `J_OP:
          begin
          PCSrc <= `NPC_JUMP;
          end
      `JAL_OP:
          begin
          RegDst <= 2'b10;
          MemtoReg <= 2'b10;
          RegWrite <= 1'b1;
          PCSrc <= `NPC_JAL;
          end

      endcase
    end

endmodule
