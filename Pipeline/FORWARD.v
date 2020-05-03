module FORWARD(ID_rs, ID_rt, EX_rs, EX_rt, EX_RF_rd, MEM_RF_rd, WB_RF_rd, EX_RegWrite, MEM_RegWrite, WB_RegWrite, MEM_MemRead, ForwardA, ForwardB, ForwardC, ForwardD);

input [4: 0] ID_rs;
input [4: 0] ID_rt;
input [4: 0] EX_rs;
input [4: 0] EX_rt;
input [4: 0] EX_RF_rd;
input [4: 0] MEM_RF_rd;
input [4: 0] WB_RF_rd;
input EX_RegWrite;
input MEM_RegWrite;
input WB_RegWrite;
input MEM_MemRead;

output reg [1: 0] ForwardA;
output reg [1: 0] ForwardB;
output reg [1: 0] ForwardC;
output reg [1: 0] ForwardD;
//ForwardA=00时，第一个操作数来自寄存器堆，ForwardA=01时，第一个操作数从上一个ALU运算结果旁路获得，ForwardA=10时，第一个操作数从WB阶段数据存储器或者前面的ALU结果中旁路获得,ForwardA=11时,第一个操作数从MEM阶段数据存储器中获得，其他的Forward信号同理

always@( * )
    begin
    if (MEM_RegWrite && (MEM_RF_rd != 0) && (MEM_RF_rd == EX_rs))
        begin
        if (MEM_MemRead)
          ForwardA <= 2'b11;
        else
          ForwardA <= 2'b01;
        end
    else if (WB_RegWrite && (WB_RF_rd != 0) && (WB_RF_rd == EX_rs))
      ForwardA <= 2'b10;
    else
      ForwardA <= 2'b00;

    if (MEM_RegWrite && (MEM_RF_rd != 0) && (MEM_RF_rd == EX_rt))
        begin
        if (MEM_MemRead)
          ForwardB <= 2'b11;
        else
          ForwardB <= 2'b01;
        end
    else if (WB_RegWrite && (WB_RF_rd != 0) && (WB_RF_rd == EX_rt))
      ForwardB <= 2'b10;
    else
      ForwardB <= 2'b00;

    if (EX_RegWrite && (EX_RF_rd != 0) && (EX_RF_rd == ID_rs))
      ForwardC <= 2'b01;
    else if (MEM_RegWrite && (MEM_RF_rd != 0) && (MEM_RF_rd == ID_rs))
      ForwardC <= 2'b10;
    else if (WB_RegWrite && (WB_RF_rd != 0) && (WB_RF_rd == ID_rs))
      ForwardC <= 2'b11;
    else
      ForwardC <= 2'b00;

    if (EX_RegWrite && (EX_RF_rd != 0) && (EX_RF_rd == ID_rt))
      ForwardD <= 2'b01;
    else if (MEM_RegWrite && (MEM_RF_rd != 0) && (MEM_RF_rd == ID_rt))
      ForwardD <= 2'b10;
    else if (WB_RegWrite && (WB_RF_rd != 0) && (WB_RF_rd == ID_rt))
      ForwardD <= 2'b11;
    else
      ForwardD <= 2'b00;



    end
endmodule

