`include "ENCODE.v"

module ALU(A, B, ALUOp, C, Zero);
           
   input  signed [31:0] A, B;
   input         [4:0]  ALUOp;
   output signed [31:0] C;
   output Zero;
   //ALU的输入和输出均为有符号数，在ALU内部运算的时候会根据情况转换成无符号数

   reg [31:0] C;
   integer    i;
       
   always @( A or B or ALUOp ) begin
      case ( ALUOp )
          `ALU_NOP:  C = A; 
          `ALU_ADDU:  C = $unsigned(A) + $unsigned(B);
          `ALU_ADD:  C = A + B;
          `ALU_SUBU:  C=$unsigned(A)-$unsigned(B);
          `ALU_SUB:   C=A-B;
          `ALU_AND:  C=A&B;
          `ALU_OR:C=A|B;
          `ALU_NOR:C=~(A|B);
          `ALU_XOR:C=(A^B);
          `ALU_SLT:C=A<B?1:0;
          `ALU_SLTU:C=$unsigned(A)<$unsigned(B)?1:0;
          //`ALU_EQL:
          //`ALU_BNE:
          //`ALU_GT0:
          //`ALU_GE0:
          //`ALU_LT0:
          //`ALU_LE0:
          `ALU_SLL:C=A << B;
          `ALU_SRL:C=A >> B;
          `ALU_SRA:C=A >>> B;
          //其中>>>是verilog原生运算符，表示算术右移

          default:   C = A;                          // Undefined
      endcase
   end
   
   assign Zero = (C == 32'b0);

endmodule
    
