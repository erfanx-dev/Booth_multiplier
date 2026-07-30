module counter_3bit(
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic load_cnt,
    output logic c_out,
    output logic [2:0] count
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 3'b000;
        end else if (load_cnt) begin
            count <= 3'b000;
        end else if (enable) begin
            count <= count + 1;
        end
    end

    assign c_out = (count == 3'b111) ? 1'b1 : 1'b0;
endmodule
