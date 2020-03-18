`include "ENCODE.v"

module EXT( Imm16, EXTOp, Imm32 );
    
   input  [15:0] Imm16;
   input  [1:0]  EXTOp;
   output [31:0] Imm32;

   reg [31:0] Imm32;
   
   always@(*)
   begin
      case(EXTop)
         `EXT_ZERO:Imm32={16'd0,Imm16};
         `EXT_SIGNED:{{16{Imm16[15]}},Imm16};
         `EXT_HIGHPOS:{Imm16,16'd0};
         default:;
      endcase
   end
endmodule
