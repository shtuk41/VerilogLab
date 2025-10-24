module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
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
            A: state_next = w ? A : B;
            B: state_next = w ? D : C;
            C: state_next = w ? D : E;
            D: state_next = w ? A : F;
            E: state_next = w ? D : E;
            F: state_next = w ? D : C;
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
