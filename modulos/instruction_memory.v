module instruction_memory(
    input [31:0] ReadAddress,
    output [31:0] instruction
);

    reg [31:0] memoria_inst[0:255];
    initial begin
        $readmemb("inst_init.txt", memoria_inst);
    end
    
    // O PC anda de 4 em 4. O [9:2] converte endereço de byte para índice do vetor.
    assign instruction = memoria_inst[ReadAddress[9:2]];

endmodule