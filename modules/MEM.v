module(clk,rst,input_address,input_data,Wr,output_data);

input clk;
input rst;
input[9:0] input_address;
input[31:0] input_data;
input Wr;
output reg[31:0] output_data;

reg [31:0] data_memory[1023:0];
integer i;

always@(*)
begin
    output_data=data_memory[input_address[9:0]];
end

always@(posedge clk or posedge rst)
begin
    if(rst)
    begin
        for(i=0;i<1024;i=i+1)
           data_memory[i]<=32'h0000_0000;
    end
    if(Wr==1'b1)
    data_memory[input_address[11:2]]<=input_data[31:0];
end
endmodule