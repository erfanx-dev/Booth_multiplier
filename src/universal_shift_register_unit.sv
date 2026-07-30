module right_double_shift_register_32bit (
    input  logic        clk,
    input  logic        rst,
    input  logic        enable,
    input  logic [31:0] parallel_in,

    output logic [31:0] q
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        q <= 32'b0;
    else if (enable)
        q <= {2'b00, parallel_in[31:2]};
end

endmodule