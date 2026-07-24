module decoder_3_to_8_unit (
    input  logic [2:0]    data_in,
    input  logic          enable,
    output logic [7:0]    data_out
);
    assign data_out = enable ? (1 << data_in) : 8'b00000000;
endmodule