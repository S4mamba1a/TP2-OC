module fpga_top_level (
    input wire [1:0] CHAVE,  // CHAVE[0] = Clock, CHAVE[1] = Reset
    output wire [6:0] HEX0,  // Display de 7 segmentos (PC Unidade)
    output wire [6:0] HEX1,  // Display de 7 segmentos (PC Dezena)
    output wire [6:0] HEX6,  // Display de 7 segmentos (Reg x1 Unidade) 
    output wire [6:0] HEX7   // Display de 7 segmentos (Reg x1 Dezena) 
);

    // Invertemos o sinal dependendo de como a chave opera na placa DE2-115
    wire clk = ~CHAVE[0]; 
    wire rst = ~CHAVE[1]; 

    wire [31:0] pc_out;
    wire [31:0] valor_x1;

    top_level cpu (
        .clk(clk),
        .reset(rst),
        .PC_out(pc_out),
        .saida_x1(valor_x1)
    );

    // Registrador x1 nos Displays (HEX7 e HEX6)
    wire [6:0] valor_x1_7bits = valor_x1[6:0]; 
    dec7seg displays_reg (
        .bin(valor_x1_7bits),
        .seg_dezena(HEX7),
        .seg_unidade(HEX6)
    );


    // PC nos Displays (HEX1 e HEX0)
    wire [4:0] pc_index = pc_out[6:2]; // Divide por 4 para saber a linha
    dec7seg displays_pc (
        .bin({2'b00, pc_index}), // Completa com zeros para dar os 7 bits do input
        .seg_dezena(HEX1),
        .seg_unidade(HEX0)
    );

endmodule
