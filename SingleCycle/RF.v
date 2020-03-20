
  module RF(   input         clk, 
               input         rst,
               input         RFWr, 
               input  [4:0]  A1, A2, A3, 
               input  [31:0] WD, 
               output [31:0] RD1, RD2
	   );
  //clk是时钟信号，WD是写会寄存器的数据，reset是清零信号,RFWr是写使能信号，A3是写入的寄存器号，reg_sel和reg_data是作为调试信号，主要是用于读出某一个寄存器中的值

  reg [31:0] rf[31:0];

  integer i;

  always @(posedge clk or posedge rst)
    if (rst) begin    //  reset
      for (i=0; i<32; i=i+1)
        rf[i] <= 0; 
    end
      
    else 
      if (RFWr) begin
        rf[A3] <= WD;
      end
    

  assign RD1 = (A1 != 0) ? rf[A1] : 0;
  assign RD2 = (A2 != 0) ? rf[A2] : 0;

endmodule 
