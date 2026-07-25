import booth_types::*;

module booth_encoder_unit(
    input  logic [2:0] data_in,
    input  logic       enable,
    output booth_encoding_t operation
);

always_comb begin

    operation = ZERO;

    if(enable) begin

        case(data_in)

            3'b000,
            3'b111:
                operation = ZERO;


            3'b001,
            3'b010:
                operation = ONE_POS;


            3'b011:
                operation = TWO_POS;


            3'b100:
                operation = TWO_NEG;


            3'b101,
            3'b110:
                operation = ONE_NEG;


            default:
                operation = ZERO;

        endcase
    end
end
endmodule