module MUX2#(parameter WIDTH = 32)(d0, d1, select, dout);

input [WIDTH - 1: 0] d0, d1;
input select;
output [WIDTH - 1: 0] dout;

reg [WIDTH - 1: 0] dout_temp;

always@( * )
    begin
      case (select)
      1'b0:
        dout_temp = d0;
      1'b1:
        dout_temp = d1;
      default:
        ;
      endcase
    end

assign dout = dout_temp;

endmodule


  module MUX4#(parameter WIDTH = 32)(d0, d1, d2, d3, select, dout);

input [WIDTH - 1: 0] d0, d1, d2, d3;
input [1: 0] select;
output [WIDTH - 1: 0] dout;

reg [WIDTH - 1: 0] dout_temp;

always@( * )
    begin
      case (select)
      2'b00:
        dout_temp = d0;
      2'b01:
        dout_temp = d1;
      2'b10:
        dout_temp = d2;
      2'b11:
        dout_temp = d3;
      default:
        ;
      endcase
    end

assign dout = dout_temp;

endmodule



