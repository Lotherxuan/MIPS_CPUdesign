`timescale 1ns/1ps

module Test_mips;
    reg [9:0]pc;
    wire [31:0];

_mem _men(.pc(pc),.());

initial
begin
    #10 pc=10'b00000_00000;
    #10 pc=10'b00000_00001;
    #10 pc=10'b00000_00010;
    #10 $finish;
end

endmodule

