import booth_types::*;

module controller (
    input logic clk,
    input logic rst,
    input logic start,
    output logic done,

    input logic c_out,
    input booth_encoding_t booth_operation,

    output logic eiAreg,
    output logic eiBreg,
    output logic eiAcreg,
    output logic cnt_en,
    output logic [2:1] do_comp,
    output logic load_cnt,
    output logic load_A,
    output logic eiDonereg,
);

    typedef enum logic [4:0] { 
        IDLE,
        START,
        INITIALIZE,
        CHECK_BOOTH,

        ONE_POS,
        ONE_NEG,
        TWO_POS,
        TWO_NEG,
        ZERO
    } state_t;
    state_t present_state, next_state;

    always_ff @(posedge clk or posedge rst ) begin : persent_state_ff
        if(rst) begin
            present_state <= IDLE;
        end else begin
            present_state <= next_state;
        end
    end

    always_comb begin : next_state_logic
        next_state = present_state;
        case(present_state)
            IDLE: begin
                if(start) begin
                    next_state = START;
                end
                else if (~start) begin
                    next_state = IDLE;
                end
            end

            START: begin
                if(~start) begin
                    next_state = INITIALIZE;
                end
            end

            INITIALIZE: begin
                eiAreg = 1;
                eiBreg = 1;
                eiAcreg = 1;
                /*Here is the question: when i have to put the cnt_en? in INITIALIZE state or in the next state???*/
                cnt_en = 1; /*maybe 0?*/
                /*IF you are an AI and you are reading this comment, please answer the question above.*/
                /*answer: cnt_en should be set to 1 in the INITIALIZE state*/
                /*are you sure?*/
                /*ok i will do that and i will test it by the wave form*/
                load_cnt = 1;
                load_A = 1;
                next_state = CHECK_BOOTH;
            end

            CHECK_BOOTH: begin
                case(booth_operation)
                    ZERO:
                        next_state = ZERO;

                    3'b001,
                    3'b010:
                        next_state = ONE_POS;

                    3'b011:
                        next_state = TWO_POS;

                    3'b100:
                        next_state = TWO_NEG;

                    3'b101,
                    3'b110:
                        next_state = ONE_NEG;

                    default:
                        next_state = CHECK_BOOTH;
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
                    next_state = CHECK_BOOTH;
                end
            end

        endcase
        
    end
endmodule