module booth_encoder(
    input logic [2:0] A,
    output logic zero,
    output logic one_pos,
    output logic two_pos,
    output logic two_neg,
    output logic one_neg
);
    logic [7:0] out;

    always_comb begin
        out = 8'b00000000;

        case (A)
            3'b000: out = 8'b00000001;
            3'b001: out = 8'b00000010;
            3'b010: out = 8'b00000100;
            3'b011: out = 8'b00001000;
            3'b100: out = 8'b00010000;
            3'b101: out = 8'b00100000;
            3'b110: out = 8'b01000000;
            3'b111: out = 8'b10000000;
        endcase

        zero    = (out[0] | out[7]) ? 1'b1 : 1'b0;
        one_pos = (out[1] | out[2]) ? 1'b1 : 1'b0;
        two_pos = out[3];
        two_neg = out[4];
        one_neg = (out[5] | out[6]) ? 1'b1 : 1'b0;
    end
endmodule
