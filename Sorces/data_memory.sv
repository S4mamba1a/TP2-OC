module data_memory (
    input  logic        clk,
    input  logic        we,
    input  logic        re,
    input  logic [31:0] address,
    input  logic [31:0] wd,
    output logic [31:0] rd
);

    // Declaração da Memória RAM: 64 x 32
    logic [31:0] memory [63:0];

    // Inicialização da Memória de Dados
    initial begin
        $readmemb("data_init.txt", memory); 
    end

    wire [29:0] word_addr = address[31:2];

    // Leitura Assíncrona
    assign rd = (re) ? memory[word_addr] : 32'b0;

    // Escrita Síncrona
    always_ff @(posedge clk) begin
        if (we) begin
            memory[word_addr] <= wd;
        end
    end

endmodule