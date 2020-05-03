`include "ENCODE.v"

module HARZARD(ID_rs, ID_rt, EX_rt, ID_PCSrc, EX_MemRead, IF_ID_flush, PC_unchanged);

input [4: 0] ID_rs;
input [4: 0] ID_rt;
input [4: 0] EX_rt;
input [2: 0] ID_PCSrc;
input EX_MemRead;

output reg IF_ID_flush;
output reg PC_unchanged;
initial
    begin
    IF_ID_flush <= 1'b0;
    PC_unchanged <= 1'b0;
    end
always @( * )
    begin
    if (EX_MemRead && ((EX_rt == ID_rt) || (EX_rt == ID_rs)))
        begin
        IF_ID_flush <= 1'b1;
        PC_unchanged <= 1'b1;
        end
    else if (ID_PCSrc != `NPC_PLUS4)
        begin
        IF_ID_flush <= 1'b1;
        PC_unchanged <= 1'b0;
        end
    else
        begin
        IF_ID_flush <= 1'b0;
        PC_unchanged <= 1'b0;
        end
    end

endmodule
