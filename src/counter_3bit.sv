module counter_3bit(
    input  logic clk,
    input  logic rst,
    input  logic enable,
    output logic [2:0] count
);

    always@(posedge clk) begin
        if (rst)
            count <= 3'b000;
        else if (enable)
            count <= count + 1;
    end
endmodule