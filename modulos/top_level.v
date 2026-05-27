module top_level (
    input clk, reset
);
    reg [31:0] PC;
    wire [31:0] ALUResult;
    wire [31:0] MemReadData;
    wire [31:0] PC_NEXT;
    wire [31:0] instruction;
    wire [31:0] WriteData;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] imediato;
    wire [31:0] ALUSrcB;
    wire [31:0] PC_4;
    wire [31:0] PC_BRANCH;
    wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire PCSrc;

    // Atualização do PC
    always@(posedge clk) begin
        if (reset) 
            PC <= 32'b0;
        else
            PC <= PC_NEXT;
    end

    // Memória de Instruções
    instruction_memory inst_mem (
        .ReadAddress(PC),
        .instruction(instruction)
    );

    // Unidade de Controle
    control ctrl(
        .opcode(instruction[6:0]),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    // Banco de Registradores
    register_file reg_file (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadRegister1(instruction[19:15]),
        .ReadRegister2(instruction[24:20]),
        .WriteRegister(instruction[11:7]),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Gerador de Imediatos
    imm_gen imm_g(
        .instrucao(instruction),
        .imediato(imediato)
    );

    // Controle da ULA
    ALUControl alu_ctrl(
        .funct7bit(instruction[30]),
        .funct3(instruction[14:12]),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    // MUX do segundo operando da ULA
    assign ALUSrcB = (ALUSrc) ? imediato : ReadData2;

    // ULA
    alu ALU(
        .a(ReadData1),
        .b(ALUSrcB),
        .alu_control(ALUControl),
        .result(ALUResult),
        .zero(Zero)
    );

    // Memória de Dados
    data_memory data_mem(
        .clk(clk),
        .address(ALUResult),
        .WriteData(ReadData2),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ReadData(MemReadData)
    );

    // MUX de Write Back (Memória para Registro)
    assign WriteData = (MemtoReg) ? MemReadData : ALUResult;

    // Lógica do Próximo PC
    assign PC_4 = PC + 32'd4;
    assign PC_BRANCH = PC + imediato;
    
    // Lógica do BNE: Pula se for um Branch e a ULA NÃO deu Zero (valores diferentes)
    assign PCSrc = Branch & (~Zero);
    assign PC_NEXT = (PCSrc) ? PC_BRANCH : PC_4;

endmodule