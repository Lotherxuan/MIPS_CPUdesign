module IM(addr,instr);

input [11:2] addr;
output reg[31:0] instr;

reg[31:0] Instrs[1023:0];

initial
begin
    $readmemh("mipstestloop_sim.dat",Instrs,0);
end

always@(pc)
begin
    instr=Instrs[pc];
    //$display("Instrs[%4d]=0x%8h",pc,Instrs[pc]);
end

endmodule
