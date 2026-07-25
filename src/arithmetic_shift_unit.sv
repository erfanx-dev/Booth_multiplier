module double_shift_register(
    input  logic                    clk,
    input  logic                    rst,
    input  logic                    enable,
    input  logic signed [WIDTH-1:0] data_in,

    output logic signed [WIDTH-1:0] data_out
);


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            data_out <= '0;
        end

        else if (enable) begin
            data_out <= data_in >>> 2;
        end

    end

endmodule