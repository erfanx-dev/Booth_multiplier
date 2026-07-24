module register_unit #(width) ( 
    input logic clk,
    input logic rst,
    input logic write_enable,
    input logic [width-1:0] data_in,
    output logic [width-1:0] data_out
);

    reg [width-1:0] register;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            register <= ({width{1'b0}});
        end
        else if (write_enable) begin
            register <= data_in;
        end
    end

    assign data_out = register;
endmodule