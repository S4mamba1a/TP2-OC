module instruction_memory (
    input  logic [31:0] address,
    output logic [31:0] instruction
);

    // Declaração da ROM: 64 x 32 
    logic [31:0] rom [63:0];

    initial begin
        // Lê o arquivo gerado pelo seu montador (TP01)
        // Crie um arquivo "inst_init.txt" contendo o binário do programa
        $readmemb("inst_init.txt", rom);
    end

    // Alinhamento de palavra: O PC pula de 4 em 4 bytes
    wire [29:0] word_addr = address[31:2];

    // Leitura assíncrona imediata
    assign instruction = rom[word_addr];

endmodule