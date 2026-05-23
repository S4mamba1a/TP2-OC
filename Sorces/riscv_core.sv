module riscv_core (
    input logic clk,
    input logic reset
);

    // ==========================================
    // Declaração dos fios
    // ==========================================
    logic [31:0] pc_reg, pc_next, pc_plus_4, pc_branch;
    logic [31:0] instruction;
    logic [31:0] read_data_1, read_data_2, write_data;
    logic [31:0] imm_ext;
    logic [31:0] alu_result;
    logic [31:0] mem_read_data;
    
    // Sinais de Controle
    logic        Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    logic [1:0]  ALUOp;
    logic [3:0]  alu_ctrl;
    logic        zero_flag;

    // ==========================================
    // Program Counter
    // ==========================================
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_reg <= 32'b0; // Zera o PC se apertar o botão de reset
        else
            pc_reg <= pc_next;
    end

    // Lógica de avanço do PC
    assign pc_plus_4 = pc_reg + 32'd4;
    assign pc_branch = pc_reg + imm_ext;

    // AND Gate para o Branch
    logic do_branch;
    assign do_branch = Branch & (~zero_flag); 
    
    // Mux do PC
    assign pc_next = (do_branch) ? pc_branch : pc_plus_4;

    // ==========================================
    // Instanciação dos módulos
    // ==========================================

    instruction_memory inst_mem (
        .address(pc_reg),
        .instruction(instruction)
    );

    control ctrl_unit (
        .opcode(instruction[6:0]),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    register_file reg_file (
        .clk(clk),
        .we(RegWrite),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .wd(write_data),
        .rd1(read_data_1),
        .rd2(read_data_2)
    );

    imm_gen ig (
        .inst(instruction),
        .imm(imm_ext)
    );

    alu_control alu_ctrl_unit (
        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7_bit(instruction[30]),
        .alu_ctrl(alu_ctrl)
    );

    // Mux da ALU
    logic [31:0] alu_operand_b;
    assign alu_operand_b = (ALUSrc) ? imm_ext : read_data_2;

    alu main_alu (
        .a(read_data_1),
        .b(alu_operand_b),
        .alu_control(alu_ctrl),
        .result(alu_result),
        .zero(zero_flag)
    );

    data_memory data_mem (
        .clk(clk),
        .we(MemWrite),
        .re(MemRead),
        .address(alu_result),
        .wd(read_data_2),
        .rd(mem_read_data)
    );

    // Mux do Write Back
    assign write_data = (MemtoReg) ? mem_read_data : alu_result;

endmodule