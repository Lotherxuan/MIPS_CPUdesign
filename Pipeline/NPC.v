`include "ENCODE.v"

module NPC(PC, ID_PC, NPCop, Zero, IMM, Imm16, rs, harzard, NPC);  // next pc module

input [31: 0] PC;        // pc
input [31: 0] ID_PC;       //ID_pc
input [2: 0] NPCop;     // next pc operation
input Zero;
input [25: 0] IMM;       // immediate
input [15: 0] Imm16;
input [31: 0] rs;
input harzard;
output reg [31: 0] NPC;   // next pc

wire [31: 0] PCPLUS4;
wire [31: 0] ID_PCPLUS4;

assign PCPLUS4 = PC + 4; // pc + 4
assign ID_PCPLUS4 = ID_PC + 4; // ID_pc + 4

always @( * )
    begin
    if (harzard)
        begin
        NPC <= PC;
        end
    else
        begin
          case (NPCop)
          `NPC_PLUS4:
            NPC = PCPLUS4;
          `NPC_BRANCH:
              begin
              if (Zero === 1'b1)
                NPC = ID_PCPLUS4 + {{14{Imm16[15]}}, Imm16[15: 0], 2'b00};
              else
                NPC = ID_PCPLUS4;
              end
          `NPC_BNE:
              begin
              if (Zero != 1'b1)
                NPC = ID_PCPLUS4 + {{14{Imm16[15]}}, Imm16[15: 0], 2'b00};
              else
                NPC = ID_PCPLUS4;
              end
          `NPC_JUMP:
            NPC = {ID_PCPLUS4[31: 28], IMM[25: 0], 2'b00};
          `NPC_JAL:
            NPC = {ID_PCPLUS4[31: 28], IMM[25: 0], 2'b00};
          `NPC_JALR:
            NPC = rs;
          `NPC_JR:
            NPC = rs;
          default:
            NPC = PCPLUS4;
          endcase
        end

    end // end always

endmodule
