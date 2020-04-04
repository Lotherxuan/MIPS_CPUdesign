module MUX2_32(d0,d1,select,dout);

input [31:0] d0,d1;
input select;
output [31:0] dout;

reg [31:0] dout_temp;

always@(*)
begin
    case(select)
        1'b0:dout_temp=d0;
        1'b1:dout_temp=d1;
        default: ;
    endcase
end

assign dout=dout_temp;

endmodule


module MUX4_32(d0,d1,d2,d3,select,dout);

input [31:0] d0,d1,d2,d3;
input [1:0] select;
output [31:0] dout;

reg [31:0] dout_temp;

always@(*)
begin
    case(select)
        2'b00:dout_temp=d0;
        2'b01:dout_temp=d1;
        2'b10:dout_temp=d2;
        2'b11:dout_temp=d3;
        default: ;
    endcase
end

assign dout=dout_temp;

endmodule


module MUX4_5(d0,d1,d2,d3,select,dout);

input [4:0] d0,d1,d2,d3;
input [1:0] select;
output [4:0] dout;

reg [4:0] dout_temp;

always@(*)
begin
    case(select)
        2'b00:dout_temp=d0;
        2'b01:dout_temp=d1;
        2'b10:dout_temp=d2;
        2'b11:dout_temp=d3;
        default: ;
    endcase
end

assign dout=dout_temp;

endmodule

