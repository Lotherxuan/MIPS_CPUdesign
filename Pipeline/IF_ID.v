module IF_ID(clk, rst, PC, Instr, harzard, PC_out, Instr_out);

input clk;
input rst;
input[31: 0] PC;
input[31: 0] Instr;
input harzard;
output reg[31: 0] PC_out;
output reg[31: 0] Instr_out;

initial
    begin
    PC_out <= 0;
    Instr_out <= 0;
    end

always @(posedge rst)
    begin
    PC_out <= 0;
    Instr_out <= 0;
    end

always @(posedge clk)
  if (harzard)
      begin
      PC_out = 0;
      Instr_out = 0;
      end
  else
      begin
      PC_out = PC;
      Instr_out = Instr;
      end

endmodule
