`timescale 1ns/1ps

module Test;

reg clk;
reg rst;

MIPS mips(.clk(clk),.rst(rst));

initial
begin
    #10 clk=0;
        rst=0;
    #10 clk=1;
        rst=0;
    #10 clk=0;
        rst=0;
    #10 clk=1;
        rst=0;
    #10 $finish;
end

endmodule

