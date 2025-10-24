module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    typedef enum logic [1:0]
    {
        NOT_FOUND = 2'b00,
        ONE = 2'b01,
        TWO = 2'b10,
        THREE = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            NOT_FOUND: next_state = (in[3] ? ONE : NOT_FOUND);
            ONE :  next_state = TWO;
            TWO : next_state = THREE;
            THREE : next_state = in[3] ? ONE : NOT_FOUND;
			default: next_state = state;       
        endcase
    end
    

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state = NOT_FOUND;
        else
            state = next_state;
    end            

    // Output logic
    assign done = (state == THREE);

endmodule
