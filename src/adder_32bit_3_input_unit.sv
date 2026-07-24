module adder_32bit_3_input_unit(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [31:0] c,
    output logic [31:0] sum
);
    assign sum = a + b + c;
endmodule