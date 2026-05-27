module register_file (
    input clk, RegWrite,
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister,
    input [31:0] WriteData,
    output [31:0] ReadData1, ReadData2
);
    reg [31:0] registradores [0:31];

    initial begin
        $readmemb("reg_init.txt", registradores); 
    end
    
    // Leitura assíncrona, se pedir o registrador 0, devolve 0 fixo
    assign ReadData1 = (ReadRegister1 == 5'b00000) ? 32'b0 : registradores[ReadRegister1];
    assign ReadData2 = (ReadRegister2 == 5'b00000) ? 32'b0 : registradores[ReadRegister2]; 

    // Escrita síncrona, trava de segurança para nunca sobrescrever o registrador zero.
    always@(posedge clk) begin
        if (RegWrite && WriteRegister != 5'b00000) begin
            registradores[WriteRegister] <= WriteData;
        end
    end
endmodule