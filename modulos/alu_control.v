module ALUControl (
    input wire funct7bit, 
    input wire [2:0] funct3, 
    input wire [1:0] ALUOp, 
    output reg [3:0] ALUControl
);

always@(*) begin

    // ALUOp: 00=mem, 01=branch, 10=tipo-R, 11=tipo-I
    case (ALUOp) 
    2'b00: ALUControl= 4'b0010; // SW, LW (ULA soma para achar endereço)
    2'b01: ALUControl= 4'b0110; // BNE (ULA subtrai para testar igualdade)
    2'b10: begin
        case (funct3)
            3'b100: ALUControl= 4'b0011; // XOR
            3'b001: ALUControl= 4'b0100; // SLL
            3'b000: ALUControl= 4'b0010; // ADD 
            default: ALUControl= 4'b0010; 
        endcase
    end
    2'b11: begin
        case(funct3) 
            3'b000: ALUControl= 4'b0010; // ADDI
            default: ALUControl= 4'b0010;
        endcase
    end
    default: ALUControl= 4'b0010; 
    endcase
end

endmodule