module register_file (
    input  logic        clk,
    input  logic        we,
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,
    input  logic [31:0] wd,
    output logic [31:0] rd1,
    output logic [31:0] rd2
);

    // Declaração do banco 32 x 32
    logic [31:0] registers [31:0];

    // Inicialização do banco
    initial begin
        // Lê os valores iniciais de um arquivo texto para dentro do vetor "registers".
        $readmemb("regs_init.txt", registers); 
    end

    // Leitura Assíncrona
    // Se o endereço pedido for 0, sairá 0. Caso contrário, sai o valor guardado.
    assign rd1 = (rs1 == 5'b0) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 5'b0) ? 32'b0 : registers[rs2];

    // Escrita Síncrona
    always_ff @(posedge clk) begin
        // Só permite a escrita se o controle mandar (we == 1) E o destino NÃO for x0
        if (we && (rd != 5'b0)) begin
            registers[rd] <= wd;
        end
    end

endmodule