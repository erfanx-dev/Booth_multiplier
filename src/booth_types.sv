package booth_types;
    typedef enum logic [2:0] {
        ZERO        = 3'b000,
        ONE_POS     = 3'b001,
        ONE_NEG     = 3'b010,
        TWO_POS     = 3'b011,
        TWO_NEG     = 3'b100
    } booth_encoding_t;
endpackage
