module imm_gen (
    input  logic [31:0] inst, // A instrução de 32 bits completa vinda da ROM
    output logic [31:0] imm   // O imediato extraído e com sinal estendido para 32 bits
);

    logic [6:0] opcode;
    assign opcode = inst[6:0]; // O opcode sempre está nos 7 bits menos significativos

    // Bloco combinacional para decidir como montar o imediato baseado no opcode
    always_comb begin
        case (opcode)
            // Tipo I: lw (0000011) e addi (0010011)
            // Extrai os bits de 31 a 20.
            7'b0000011, 7'b0010011: 
                imm = {{20{inst[31]}}, inst[31:20]};
            
            // Tipo S: sw (0100011)
            // O imediato é quebrado em duas partes na instrução.
            7'b0100011: 
                imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            
            // Tipo B: bne (1100011)
            // O imediato é embaralhado e o bit 0 é sempre 0 (salto em múltiplos de 2 bytes).
            7'b1100011: 
                imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            
            // Padrão: para instruções Tipo R (add, xor, sll) que não usam imediato.
            default: 
                imm = 32'b0;
        endcase
    end

endmodule