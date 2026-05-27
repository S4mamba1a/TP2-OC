module data_memory(
    input clk, MemRead, MemWrite,
    input [31:0] address, WriteData,
    output [31:0] ReadData
);

    reg [31:0] memoria[0:255];
    initial begin
        $readmemb("mem_init.txt", memoria);
    end
    
    // Converte endereço de bytes pra índice de palavra (/4)
    assign ReadData = (MemRead == 1'b1) ? memoria[address[9:2]] : 32'b0;
    
    always@(posedge clk) begin
        if (MemWrite) begin
            memoria[address[9:2]] <= WriteData;
        end
    end
endmodule

