module control (
    input  logic [6:0] opcode,
    output logic       Branch,
    output logic       MemRead,
    output logic       MemtoReg,
    output logic [1:0] ALUOp,
    output logic       MemWrite,
    output logic       ALUSrc,
    output logic       RegWrite
);

    always_comb begin
        // Valores padrão
        Branch   = 1'b0;
        MemRead  = 1'b0;
        MemtoReg = 1'b0;
        ALUOp    = 2'b00;
        MemWrite = 1'b0;
        ALUSrc   = 1'b0;
        RegWrite = 1'b0;

        case (opcode)
            7'b0110011: begin // TIPO R (add, xor, sll)
                ALUSrc   = 1'b0;  // ALU usa o rs2
                MemtoReg = 1'b0;  // Registrador recebe da ALU
                RegWrite = 1'b1;  // Salva no rd
                ALUOp    = 2'b10; // Deixa o ALU Control decidir a conta
            end

            7'b0010011: begin // TIPO I (addi)
                ALUSrc   = 1'b1;  // ALU usa o Imediato
                MemtoReg = 1'b0;  // Registrador recebe da ALU
                RegWrite = 1'b1;  // Salva no rd
                ALUOp    = 2'b11; // Código especial para I-Type Aritmético
            end

            7'b0000011: begin // TIPO I (lw)
                ALUSrc   = 1'b1;  // ALU usa o Imediato para calcular endereço
                MemRead  = 1'b1;  // Lê da memória
                MemtoReg = 1'b1;  // Registrador recebe da Memória
                RegWrite = 1'b1;  // Salva no rd
                ALUOp    = 2'b00; // ALU deve fazer SOMA (calculo de endereço)
            end

            7'b0100011: begin // TIPO S (sw)
                ALUSrc   = 1'b1;  // ALU usa o Imediato para calcular endereço
                MemWrite = 1'b1;  // Escreve na memória
                ALUOp    = 2'b00; // ALU deve fazer SOMA (calculo de endereço)
            end

            7'b1100011: begin // TIPO B (bne)
                Branch   = 1'b1;  // Avisa que é uma instrução de salto
                ALUSrc   = 1'b0;  // ALU compara rs1 com rs2
                ALUOp    = 2'b01; // ALU deve fazer SUBTRAÇÃO para comparar
            end
        endcase
    end
endmodule