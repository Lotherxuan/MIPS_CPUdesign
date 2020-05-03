module IM(addr, instr);

input [31: 0] addr;
output reg[31: 0] instr;

reg[31: 0] Instrs[1023: 0];

initial
    begin
    //$readmemh("../test_codes/extendedtest.dat", Instrs, 0);
    //$readmemh("../test_codes/extendedtest.dat",Instrs,3000);
    //$readmemh("../test_codes/mipstest_extloop.dat",Instrs,0);
    //$readmemh("../test_codes/mipstest_extloop.dat",Instrs,3000);
    //$readmemh("../test_codes/mipstestloop_sim.dat",Instrs,0);
    //$readmemh("../test_codes/mipstestloop_sim.dat",Instrs,3000);
    //$readmemh("../test_codes/mipstestloopjal_sim.dat", Instrs, 0);
    //$readmemh("../test_codes/mipstestloopjal_sim.dat",Instrs,3000);
    $readmemh("../test_codes/mipstest_pipelinedloop.dat", Instrs, 0);
    //$readmemh("../test_codes/mipstest_pipelinedloop.dat",Instrs,3000);

    end

always@(addr)
    begin
    instr = Instrs[addr >> 2];
    //$display("Instrs[%4d]=0x%8h",pc,Instrs[pc]);
    end

endmodule
