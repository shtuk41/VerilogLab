module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    typedef enum logic [2:0]
    {
     	S1 = 3'b000,
        S2 = 3'b001,
        S3 = 3'b010,
        S4 = 3'b011,
        S5 = 3'b100
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case (state)
            S1 : next_state = x ? S2 : S1;
            S2 : next_state = x ? S5 : S2;
            S3 : next_state = x ? S2 : S3;
            S4 : next_state = x ? S3 : S2;
            S5 : next_state = x ? S5 : S4;
         endcase
    end
 
    always @(posedge clk) begin
        if (reset)
            state <= S1;
        else
            state <=  next_state;
    end
    
    assign z = (state == S4) | (state == S5);
endmodule
