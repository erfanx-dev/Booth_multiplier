module multiplexer_32bit_unit ( 
    input [3:0] select,
    input [31:0] data_in,
    output logic [31:0] data_out
);
    assign data_out = data_in[select];
endmodule