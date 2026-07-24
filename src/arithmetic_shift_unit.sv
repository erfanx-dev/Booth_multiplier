module arithmetic_shift_unit # (
    parameter WIDTH = 16
) (
    input  logic                   clk,
    input  logic                   rst,
    input  logic [1:0]             mode,
    input  logic [$clog2(WIDTH):0] shift_amount,
    input  logic [WIDTH-1:0]       data_in,
    output logic [WIDTH-1:0]       data_out
)                    q <= data_in; 

    /*
        mode:
        00 : Hold
        01 : Arithmetic Shift Right
        10 : Arithmetic Shift Left
        11 : Parallel Load
    */

    always@(posedge clk) begin
        if (rst)
            data_out <= '0;
        else begin
            case(mode)
                2'b00:
                    data_out <= data_out;
                2'b01:
                    data_out <= (data_out >>> shift_amount);
                2'b10:
                    data_out <= (data_out <<< shift_amount);
                2'b11:
                    data_out <= data_in;
                default:
                    data_out <= data_out;
            endcase
        end
    end