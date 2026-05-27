module alu(
    input wire [31:0] a, 
    input wire [31:0] b, 
    input wire [3:0] alu_control, 
    output reg [31:0] result, 
    output wire zero 
);

always@(*) begin
    case (alu_control)
        4'b0010: result = a + b;       // ADD, ADDI, LW, SW
        4'b0110: result = a - b;       // Usado pelo BNE para comparar
        4'b0011: result = a ^ b;       // XOR
        4'b0100: result = a << b[4:0]; // SLL, só 5 bits pois deslocamento nao pode ser maior que 31 bits
        default: result = 32'b0; 
    endcase
end

// Flag zero para auxiliar no branch
assign zero = (result == 32'b0) ? 1'b1 : 1'b0;

endmodule