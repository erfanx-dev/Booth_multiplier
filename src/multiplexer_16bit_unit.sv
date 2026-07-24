module multiplexer_16bit_unit(
    input  logic [3:0]    select,
    input  logic [15:0]    data_in,
    output logic           data_out
);
    assign data_out = data_in[select];
endmodule