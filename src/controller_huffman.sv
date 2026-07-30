module controller_huffman (
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic c_out,

    output logic eiAreg,
    output logic eiBreg,
    output logic eiACreg,
    output logic eiDreg,
    output logic do_shift,
    output logic do_cnt,
    output logic init_cnt,
    output logic load_A,
    output logic done
);



    logic Q2, Q1, Q0;
    logic D2, D1, D0;

    always_comb begin
        D0 = ~Q1 & (Q0 | start);

        D1 = (~start & Q0) |
             (~Q2 & Q1);

        D2 = c_out &
             ~Q2 &
              Q1 &
             ~Q0;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            Q2 <= 1'b0;
            Q1 <= 1'b0;
            Q0 <= 1'b0;
        end
        else begin
            Q2 <= D2;
            Q1 <= D1;
            Q0 <= D0;
        end
    end


    logic idle;
    logic start_state;
    logic initialize;
    logic execute;
    logic done_state;

    assign idle        = ~Q2 & ~Q1 & ~Q0;   //000
    assign start_state = ~Q2 & ~Q1 &  Q0;   //001
    assign initialize  = ~Q2 &  Q1 &  Q0;   //011
    assign execute     = ~Q2 &  Q1 & ~Q0;   //010
    assign done_state  =  Q2 &  Q1 & ~Q0;   //110


    assign eiAreg  = initialize;
    assign eiBreg  = initialize;

    assign eiACreg = initialize | execute;

    assign eiDreg  = done_state;

    assign do_shift = execute;
    assign do_cnt   = execute;

    assign init_cnt = initialize;

    assign load_A = initialize;

    assign done = done_state;

endmodule