module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    typedef enum logic [3:0]
    {
        IDLE = 4'b0000,
    	ONE = 4'b0001,
        TWO = 4'b0010,
        THREE = 4'b0011, 
        FOUR = 4'b0100,
        FIVE = 4'b0101,
        SIX = 4'b0110,
        SEVEN = 4'b1000,
        EIGHT = 4'b1001,
        WAIT_STOP = 4'b1010,
        STOP = 4'b1011,
        INVALID_FRAME = 4'b1100
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case (state)
            IDLE: next_state = ~in ? ONE : IDLE;
            ONE: next_state = TWO;
            TWO: next_state = THREE;
            THREE: next_state = FOUR;
            FOUR: next_state = FIVE;
            FIVE: next_state = SIX;
            SIX: next_state = SEVEN;
            SEVEN: next_state = EIGHT;
            EIGHT: next_state = WAIT_STOP;
            WAIT_STOP: next_state = in ? STOP : INVALID_FRAME;
            STOP: next_state = ~in ? ONE : IDLE;
            INVALID_FRAME: next_state = in ? IDLE : INVALID_FRAME;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    assign done = (state == STOP);

endmodule
