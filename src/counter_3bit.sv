module counter_3bit(
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input logic load_cnt,
    output logic [2:0] count
);

    always@(posedge clk) begin
        if (rst)
            count <= 3'b000;
        else if (load_cnt)
            count <= 3'b000;
        else if (enable)
            count <= count + 1;
    end

    assign done = (count == 3'b111) ? 1'b1 : 1'b0;
endmodule