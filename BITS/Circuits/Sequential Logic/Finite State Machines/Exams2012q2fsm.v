module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    
    typedef enum logic [2:0]
    {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t state, state_next;
    
    always @(*) begin
        case (state)
            A: state_next = w ? B : A;
            B: state_next = w ? C : D;
            C: state_next = w ? E : D;
            D: state_next = w ? F : A;
            E: state_next = w ? E : D;
            F: state_next = w ? C : D;
            default: state_next = state;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= state_next;
    end
    
    assign z = (state == E | state == F);

endmodule
