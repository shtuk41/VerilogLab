module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    typedef enum logic [2:0]
    {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case (state) 
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = ~data ? D : C;
            D: next_state = data ? E : B;
            E: next_state = E;
            default: next_state = state;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    assign start_shifting = (state == E);

endmodule
