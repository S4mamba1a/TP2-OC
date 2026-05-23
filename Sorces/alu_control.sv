module alu_control (
    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic       funct7_bit,
    output logic [3:0] alu_ctrl
);

    always_comb begin
        case (ALUOp)
            2'b00: alu_ctrl = 4'b0000;
            2'b01: alu_ctrl = 4'b0001;
            
            2'b10: begin // Tipo R (add, xor, sll)
                case (funct3)
                    3'b000: alu_ctrl = 4'b0000; // ADD
                    3'b100: alu_ctrl = 4'b0010; // XOR
                    3'b001: alu_ctrl = 4'b0011; // SLL
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            2'b11: begin // Tipo I (addi)
                case (funct3)
                    3'b000: alu_ctrl = 4'b0000; // ADDI faz SOMA
                    default: alu_ctrl = 4'b0000;
                endcase
            end
            
            default: alu_ctrl = 4'b0000;
        endcase
    end
endmodule