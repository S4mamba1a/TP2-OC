`timescale 1ns/1ps

module testbench;

    reg clk, reset;

    top_level uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock com período de 10ns
    always #5 clk = ~clk;

    integer i;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;

        // 100 ciclos é mais que suficiente para qualquer programa curto
        #1000;

        $display("=== Registradores ===");
        for (i = 0; i < 32; i = i + 1) begin
            $display("Register [%2d]: %12d", i, uut.reg_file.registradores[i]);
        end

        $display("");
        $display("=== Memoria de Dados (primeiras 32 posicoes) ===");
        for (i = 0; i < 32; i = i + 1) begin
            $display("Mem      [%2d]: %12d", i, uut.data_mem.memoria[i]);
        end

        $finish;
    end

endmodule
