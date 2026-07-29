import booth_types::*;

module controller (
    input logic clk,
    input logic rst,
    input logic start,
    input logic c_out,

    output logic eiAreg,
    output logic eiBreg,
    output logic eiACreg,
    output logic eiDreg,
    output logic do_shift,
    output logic do_cnt,
    output logic init_cnt,
    output logic load_A,
    output logic done,
);

    typedef enum logic [4:0] { 
        IDLE,
        START,
        INITIALIZE,
        EXECUTE,
        DONE,
    } state_t;
    state_t present_state, next_state;

    always_ff @(posedge clk or posedge rst ) begin : persent_state_ff
        if(rst) begin
            present_state <= IDLE;
        end 
        else 
        begin
            present_state <= next_state;
        end
    end

    always_comb begin : next_state_logic
        next_state = present_state;
        case(present_state)
            IDLE: begin
                next_state = (start) ? START : IDLE;
            end

            START: begin
                next_state = (~start) ? INITIALIZE : START;
            end

            INITIALIZE: begin
                eiAreg = 1;
                eiBreg = 1;
                eiACreg = 1;
                init_cnt = 1;
                load_A = 1;
                next_state = EXECUTE;
            end

            EXECUTE: begin
                case(booth_operation)
                    ZERO:
                    assign do_shift = 1;
                    assign do_count = 1;
                    assign send_zero = 2'b11;
                    next_state = (c_out) ? DONE : EXECUTE;

                    ONE_POS:

                        next_state = ONE_POS;

                    TWO_POS:
                        next_state = TWO_POS;

                    TWO_NEG:
                        next_state = TWO_NEG;

                    ONE_NEG:
                    default:
                        next_state = ONE_NEG;

                    default:
                        next_state = EXECUTE;
                endcase
            end

            ONE_POS,
            ONE_NEG,
            TWO_POS,
            TWO_NEG,
            ZERO: begin
                if(c_out) begin
                    next_state = IDLE;
                end else begin
                    next_state = EXECUTE;
                end
            end

        endcase
        
    end
endmodule