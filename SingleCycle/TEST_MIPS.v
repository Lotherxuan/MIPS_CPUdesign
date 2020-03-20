`timescale 1ns/1ps

module Test;

reg clk;
reg rst;

reg [7:0]count;//TODO count变量是用于调试
MIPS mips(.clk(clk),.rst(rst));

initial
begin
        count<=0;
        clk<=0;
        rst<=1;
        #10;
end

always@(*)
begin
        #5
        clk<=~clk;
        rst<=0;
        count<=count+1;
        if(count>=100)
        begin
        $finish;
        end
end

endmodule

