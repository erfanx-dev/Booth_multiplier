module universal_shift_register #(
    parameter WIDTH = 16
)(
    input  logic                   clk,
    input  logic                   rst,

    input  logic [1:0]             mode,
    input  logic [$clog2(WIDTH):0] shift_amount,

    input  logic                   serial_left,
    input  logic                   serial_right,

    input  logic [WIDTH-1:0]       parallel_in,

    output logic [WIDTH-1:0]       q
);


    /*
        mode:
        00 : Hold
        01 : Shift Right
        10 : Shift Left
        11 : Parallel Load
    */


    always_ff @(posedge clk) begin
        if (rst)
            q <= '0;
        else begin
            case(mode)
                2'b00:
                    q <= q;
                2'b01:
                    q <= (q >> shift_amount);
                2'b10:
                    q <= (q << shift_amount);
                2'b11:
                    q <= parallel_in;
                default:
                    q <= q;
            endcase
        end
    end
endmodule