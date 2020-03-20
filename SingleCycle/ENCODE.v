//instrution operation code
`define R_OP        6'b000000

`define LB_OP         6'b100000
`define LH_OP         6'b100001
`define LBU_OP        6'b100100
`define LHU_OP        6'b100101
`define LW_OP         6'b100011

`define SB_OP         6'b101000
`define SH_OP         6'b101001
`define SW_OP         6'b101011

`define ADDI_OP       6'b001000
`define ADDIU_OP      6'b001001
`define ANDI_OP       6'b001100
`define ORI_OP        6'b001101 
`define XORI_OP       6'b001110
`define LUI_OP        6'b001111
`define SLTI_OP       6'b001010
`define SLTIU_OP      6'b001011

`define BEQ_OP        6'b000100
`define BNE_OP        6'b000101
`define BGEZ_OP       6'b000001
`define BGTZ_OP       6'b000111
`define BLEZ_OP       6'b000110
`define BLTZ_OP       6'b000001

`define J_OP          6'b000010
`define JAL_OP        6'b000011

//R type Instruction Funct
`define ADD_FUNCT     6'b100000
`define ADDU_FUNCT    6'b100001
`define SUB_FUNCT     6'b100010
`define SUBU_FUNCT    6'b100011
`define AND_FUNCT     6'b100100
`define NOR_FUNCT     6'b100111
`define OR_FUNCT      6'b100101
`define XOR_FUNCT     6'b100110
`define SLT_FUNCT     6'b101010
`define SLTU_FUNCT    6'b101011
`define SLL_FUNCT     6'b000000
`define SRL_FUNCT     6'b000010
`define SRA_FUNCT     6'b000011
`define SLLV_FUNCT    6'b000100
`define SRLV_FUNCT    6'b000110
`define SRAV_FUNCT    6'b000111      
`define JR_FUNCT      6'b001000
`define JALR_FUNCT    6'b001001

//ALU control signal
`define ALU_NOP   5'b00000 
`define ALU_ADDU  5'b00001
`define ALU_ADD   5'b00010
`define ALU_SUBU  5'b00011
`define ALU_SUB   5'b00100 
`define ALU_AND   5'b00101
`define ALU_OR    5'b00110
`define ALU_NOR   5'b00111
`define ALU_XOR   5'b01000
`define ALU_SLT   5'b01001
`define ALU_SLTU  5'b01010 
`define ALU_EQL   5'b01011
`define ALU_BNE   5'b01100
`define ALU_GT0   5'b01101
`define ALU_GE0   5'b01110
`define ALU_LT0   5'b01111
`define ALU_LE0   5'b10000
`define ALU_SLL   5'b10001
`define ALU_SRL   5'b10010
`define ALU_SRA   5'b10011

//NPC control signal
`define NPC_PLUS4   3'b000
`define NPC_BRANCH  3'b001
`define NPC_JUMP    3'b010
`define NPC_JAL     3'b011
`define NPC_JALR    3'b100
`define NPC_BNE     3'b101
`define NPC_JR      3'b110

//Extend control signal
`define EXT_ZERO    2'b01
`define EXT_SIGNED  2'b00
`define EXT_HIGHPOS 2'b10