module datapath (
    input logic clk,
    input logic reset,
    input logic start,
    input logic [15:0] multiplicand,
    input logic [15:0] multiplier,
    output logic [31:0] product,
    output logic done
);

    logic [15:0] Areg_out, Breg_out;
    logic [31:0] a, b, p, na, nb;
    logic [31:0] adder_sum;
    logic [31:0] shift_out;
    logic [2:0] counter_count;
    logic [2:0] A;
    logic zero, one_pos, two_pos, two_neg, one_neg;
    logic c_out;
    logic eiAreg, eiBreg, eiACreg, eiDreg;
    logic do_shift, do_cnt, init_cnt, load_A;
    logic ctrl_done;

    assign a = {{16{Areg_out[15]}}, Areg_out};
    assign b = {{16{Breg_out[15]}}, Breg_out};
    assign product = p;
    assign done = ctrl_done;
    assign A = counter_count;

    register_unit #(.width(16)) uut_a (
        .clk(clk),
        .rst(reset),
        .write_enable(eiAreg),
        .data_in(multiplicand),
        .data_out(Areg_out)
    );

    register_unit #(.width(16)) uut_b (
        .clk(clk),
        .rst(reset),
        .write_enable(eiBreg),
        .data_in(multiplier),
        .data_out(Breg_out)
    );

    twos_complement_unit uut_a_twos (
        .data_in(a),
        .enable(1'b1),
        .data_out(na)
    );

    twos_complement_unit uut_b_twos (
        .data_in(b),
        .enable(1'b1),
        .data_out(nb)
    );

    adder_32bit_3_input_unit uut_adder (
        .a(a),
        .b(na),
        .c(nb),
        .sum(adder_sum)
    );

    right_double_shift_register_32bit uut_shift (
        .clk(clk),
        .rst(reset),
        .enable(do_shift),
        .parallel_in(p),
        .q(shift_out)
    );

    counter_3bit uut_cnt (
        .clk(clk),
        .rst(reset),
        .enable(do_cnt),
        .load_cnt(init_cnt),
        .c_out(c_out),
        .count(counter_count)
    );

    booth_encoder uut_booth (
        .A(A),
        .zero(zero),
        .one_pos(one_pos),
        .two_pos(two_pos),
        .two_neg(two_neg),
        .one_neg(one_neg)
    );

    controller_huffman uut_ctrl (
        .clk(clk),
        .rst(reset),
        .start(start),
        .c_out(c_out),
        .eiAreg(eiAreg),
        .eiBreg(eiBreg),
        .eiACreg(eiACreg),
        .eiDreg(eiDreg),
        .do_shift(do_shift),
        .do_cnt(do_cnt),
        .init_cnt(init_cnt),
        .load_A(load_A),
        .done(ctrl_done)
    );

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            p <= 32'b0;
        end else if (load_A) begin
            p <= a;
        end else if (do_shift) begin
            p <= shift_out;
        end else begin
            p <= adder_sum;
        end
    end

endmodule
