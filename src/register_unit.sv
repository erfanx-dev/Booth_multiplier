module register_unit #(parameter width = 16) (
    input logic clk,
    input logic rst,
    input logic write_enable,
    input logic [width-1:0] data_in,
    output logic [width-1:0] data_out
);

    logic [width-1:0] register;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            register <= {width{1'b0}};
        end else if (write_enable) begin
            register <= data_in;
        end
    end

    assign data_out = register;
endmodule
