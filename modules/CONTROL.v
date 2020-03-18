`include "ENCODE.v"
module (Op,Func,RegDst,Jump,Branch,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite,Ext);
//理论上来说PCSrc是来间接信号，并不来自Control,在现有设计中暂时没有加入PCSrc

input [5:0] Op;
input [5:0] Func;

output reg RegDst;
output reg Jump;
output reg Branch;
output reg MemRead;
output reg MemtoReg;
output reg[4:0] ALUop;
output reg MemWrite;
output reg ALUSrc;
output reg RegWrite;
output reg[1:0] Ext;

always@(Op or Func)
begin
    RegDst<=1'b1;
    Jump<=1'b0;
    Branch<=1'b0;
    MemRead<=1'b0;
    MemtoReg<=1'b0;
    ALUop<=`ALU_NOP;
    MemWrite<=1'b0;
    ALUSrc<=1'b0;
    RegWrite<=1'b0;
    Ext<=`EXT_ZERO;

    case(Op)
        `R_OP:
        begin
            RegDst<=1'b1;
            RegWrite<=1'b1;
            case(Func)
            `ADD_FUNCT:
            begin
                ALUop<=`ALU_ADD;
            end
            `ADDU_FUNCT:
            begin
                ALUop<=`ALU_ADDU;
            end
            `SUB_FUNCT:
            begin
                ALUop<=`ALU_SUB;
            end
            `SUBU_FUNCT:
            begin
                ALUop<=`ALU_SUBU;
            end
            `NOR_FUNCT:
            begin
                ALUop<=`ALU_NOR;
            end
            `OR_FUNCT:
            begin
                ALUop<=`ALU_OR;
            end
            `XOR_FUNCT:
            begin
                ALUop<=`ALU_XOR;
            end
            `SLT_FUNCT:
            begin
                ALUop<=`ALU_SLT;
            end
            `SLTU_FUNCT:
            begin
                ALUop<=`ALU_SLTU;
            end
            `SLL_FUNCT:
            begin
                ALUop<=`ALU_SLL;
            end
            `SRL_FUNCT:
            begin
                ALUop<=`ALU_SRL;
            end
            `SRA_FUNCT:
            begin
                ALUop<=`ALU_SRA;
            end
            `SLLV_FUNCT:
            begin
                ALUop<=`ALU_SLL;
            end
            `SRLV_FUNCT:
            begin
                ALUop<=`ALU_SRL;
            end
            `SRAV_FUNCT:
            begin
                ALUop<=`ALU_SRA;
            end
            endcase
        end
        //TODO:修改移位操作中目标寄存器
        
        end
end