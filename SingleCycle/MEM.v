`include "ENCODE.v"

module MEM(clk, rst, input_address, input_data, Wr, MemControl, output_data);

input clk;
input rst;
input[31: 0] input_address;
input[31: 0] input_data;
input Wr;
input[3: 0] MemControl;
output reg[31: 0] output_data;

reg [9: 0] word_addr;
reg [1: 0] byte_addr;
reg [31: 0] word;
reg [31: 0] data_memory[1023: 0];
integer i;

always@( * )
    begin
    word_addr = input_address[11: 2];
    byte_addr = input_address[1: 0];
    word = data_memory[word_addr[9: 0]];
      case (MemControl)
      `MEM_LW:
          begin
          output_data = data_memory[word_addr[9: 0]];
          end
      `MEM_LB:
          begin
            case (byte_addr)
            2'b00:
                begin
                output_data = {{24{word[7]}}, word[7: 0]};
                end
            2'b01:
                begin
                output_data = {{24{word[15]}}, word[15: 8]};
                end
            2'b10:
                begin
                output_data = {{24{word[23]}}, word[23: 16]};
                end
            2'b11:
                begin
                output_data = {{24{word[31]}}, word[31: 24]};
                end
            endcase
          end
      `MEM_LH:
          begin
            case (byte_addr)
            2'b00:
                begin
                output_data = {{16{word[15]}}, word[15: 0]};
                end
            2'b10:
                begin
                output_data = {{16{word[31]}}, word[31: 16]};
                end
            endcase
          end
      `MEM_LBU:
          begin
            case (byte_addr)
            2'b00:
                begin
                output_data = {{24{1'b0}}, word[7: 0]};
                end
            2'b01:
                begin
                output_data = {{24{1'b0}}, word[15: 8]};
                end
            2'b10:
                begin
                output_data = {{24{1'b0}}, word[23: 16]};
                end
            2'b11:
                begin
                output_data = {{24{1'b0}}, word[31: 24]};
                end
            endcase
          end
      `MEM_LHU:
          begin
            case (byte_addr)
            2'b00:
                begin
                output_data = {{16{1'b0}}, word[15: 0]};
                end
            2'b10:
                begin
                output_data = {{16{1'b0}}, word[31: 16]};
                end
            endcase
          end
      endcase
    end

always @(posedge clk or posedge rst)
    begin
    word_addr = input_address[11: 2];
    byte_addr = input_address[1: 0];
    word = data_memory[word_addr[9: 0]];
    if (rst)
        begin
        for (i = 0;i < 1024;i = i + 1)
          data_memory[i] <= 32'h0000_0000;
        end
    if (Wr == 1'b1)
        begin
          case (MemControl)
          `MEM_SW:
              begin
              data_memory[word_addr[9: 0]] <= input_data[31: 0];
              end
          `MEM_SH:
              begin
                case (byte_addr)
                2'b00:
                    begin
                    data_memory[word_addr[9: 0]] = {word[31: 16], input_data[15: 0]};
                    end
                2'b10:
                    begin
                    data_memory[word_addr[9: 0]] = {input_data[15: 0], word[15: 0]};
                    end
                endcase
              end
          `MEM_SB:
              begin
                case (byte_addr)
                2'b00:
                    begin
                    data_memory[word_addr[9: 0]] = {word[31: 8], input_data[7: 0]};
                    end
                2'b01:
                    begin
                    data_memory[word_addr[9: 0]] = {word[31: 16], input_data[7: 0], word[7: 0]};
                    end
                2'b10:
                    begin
                    data_memory[word_addr[9: 0]] = {word[31: 24], input_data[7: 0], word[15: 0]};
                    end
                2'b11:
                    begin
                    data_memory[word_addr[9: 0]] = {input_data[7: 0], word[23: 0]};
                    end
                endcase
              end
          endcase
        end
    end

endmodule
