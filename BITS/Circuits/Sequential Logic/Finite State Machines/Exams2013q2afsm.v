module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    typedef enum logic [1:0] 
    {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, state_next;

    always @(*) begin
        case (state)
            A: state_next = (r[1] ? B : (r[2] ? C : (r[3] ? D : A)));
            B: state_next = r[1] ? B : A;
            C: state_next = r[2] ? C : A;
            D: state_next = r[3] ? D : A;
            default: state_next = state;
        endcase
    end
    
    always @(posedge clk) begin
        if (~resetn)
           	state <= A;
        else
            state <= state_next; 
    end
    
    assign g[1] = state == B;
    assign g[2] = state == C;
    assign g[3] = state == D;
    
endmodule
