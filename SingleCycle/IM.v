module IM(addr,instr);

input [9:0] addr;
output reg[31:0] instr;

reg[31:0] Instrs[1023:0];

initial
begin
    $readmemh("../test_codes/mipstest_extloop.dat",Instrs,0);
end

always@(addr)
begin
    instr=Instrs[addr];
    //$display("Instrs[%4d]=0x%8h",pc,Instrs[pc]);
end

endmodule
