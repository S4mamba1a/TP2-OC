module imm_gen(
    input [31:0] instrucao,
    output reg [31:0] imediato
);

always@(*) begin

    // Extrai os pedaços da instrução e faz a Extensão de Sinal replicando o bit 31
    case (instrucao[6:0])
        7'b0010011, 7'b0000011: imediato = { {20{instrucao[31]}}, instrucao[31:20] }; // I
        7'b0100011: imediato = { {20{instrucao[31]}}, instrucao[31:25], instrucao[11:7]}; // S
        7'b1100011: imediato = { {19{instrucao[31]}}, instrucao[31], instrucao[7], instrucao[30:25], instrucao[11:8], 1'b0}; // B
        default: imediato = 32'b0;
    endcase
end

endmodule