module twos_complement_unit (
    input  logic [32:0]    data_in,
    input  logic          enable,
    output logic [32:0]    data_out
);
    assign data_out = enable ? (~data_in + 1) : data_in;
endmodule