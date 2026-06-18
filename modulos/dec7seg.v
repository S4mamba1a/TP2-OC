module dec7seg (
    input [6:0] bin,          // Numero binario ate 127
    output reg [6:0] seg_dezena,
    output reg [6:0] seg_unidade
);
    reg [3:0] dezena;
    reg [3:0] unidade;

    // Logica para separar a Dezena da Unidade
    always @(*) begin
        if (bin >= 90) begin
            dezena = 9; unidade = bin - 90;
        end else if (bin >= 80) begin
            dezena = 8; unidade = bin - 80;
        end else if (bin >= 70) begin
            dezena = 7; unidade = bin - 70;
        end else if (bin >= 60) begin
            dezena = 6; unidade = bin - 60;
        end else if (bin >= 50) begin
            dezena = 5; unidade = bin - 50;
        end else if (bin >= 40) begin
            dezena = 4; unidade = bin - 40;
        end else if (bin >= 30) begin
            dezena = 3; unidade = bin - 30;
        end else if (bin >= 20) begin
            dezena = 2; unidade = bin - 20;
        end else if (bin >= 10) begin
            dezena = 1; unidade = bin - 10;
        end else begin
            dezena = 0; unidade = bin;
        end
    end

    // Logica para acender os segmentos 
    always @(*) begin
        case(dezena)
            4'd0: seg_dezena = 7'b1000000;
            4'd1: seg_dezena = 7'b1111001;
            4'd2: seg_dezena = 7'b0100100;
            4'd3: seg_dezena = 7'b0110000;
            4'd4: seg_dezena = 7'b0011001;
            4'd5: seg_dezena = 7'b0010010;
            4'd6: seg_dezena = 7'b0000010;
            4'd7: seg_dezena = 7'b1111000;
            4'd8: seg_dezena = 7'b0000000;
            4'd9: seg_dezena = 7'b0011000;
            default: seg_dezena = 7'b1111111;
        endcase
        
        case(unidade)
            4'd0: seg_unidade = 7'b1000000;
            4'd1: seg_unidade = 7'b1111001;
            4'd2: seg_unidade = 7'b0100100;
            4'd3: seg_unidade = 7'b0110000;
            4'd4: seg_unidade = 7'b0011001;
            4'd5: seg_unidade = 7'b0010010;
            4'd6: seg_unidade = 7'b0000010;
            4'd7: seg_unidade = 7'b1111000;
            4'd8: seg_unidade = 7'b0000000;
            4'd9: seg_unidade = 7'b0011000;
            default: seg_unidade = 7'b1111111;
        endcase
    end
endmodule
