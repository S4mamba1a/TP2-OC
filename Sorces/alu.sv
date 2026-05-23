module alu (
    input  logic [31:0] a,           // Operando 1 (Vindo do registrador rs1)
    input  logic [31:0] b,           // Operando 2 (Vindo do rs2 ou do Imediato)
    input  logic [3:0]  alu_control, // Sinal de controle que diz qual operação fazer
    output logic [31:0] result,      // Resultado da operação
    output logic        zero         // Flag se o resultado é zero
);

    // Bloco combinacional: qualquer mudança nas entradas atualiza a saída imediatamente
    always_comb begin
        case (alu_control)
            4'b0000: result = a + b;       // ADD
            4'b0001: result = a - b;       // SUB
            4'b0010: result = a ^ b;       // XOR 
            4'b0011: result = a << b[4:0]; // SLL
            default: result = 32'b0;       // Sinal desconhecido
        endcase
    end

    // A flag Zero recebe 1 se o resultado for zero, e 0 caso contrário.
    assign zero = (result == 32'b0) ? 1'b1 : 1'b0;

endmodule