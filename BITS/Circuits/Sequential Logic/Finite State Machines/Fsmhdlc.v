module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    typedef enum logic [3:0]
    {
    	IDLE = 4'b0000,
        ONE = 4'b0001,
        TWO = 4'b0010,
        THREE = 4'b0011,
        FOUR = 4'b0100,
        FIVE = 4'b0101,
        SIX = 4'b0110,
       	FLAG = 4'b0111,
        DISC = 4'b1000,
        ERROR = 4'b1001,
        START = 4'b1010
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case(state)
            IDLE: next_state = in ? ONE : IDLE;
            ONE: next_state = in? TWO: IDLE;
            TWO: next_state = in? THREE : IDLE;
            THREE: next_state = in? FOUR: IDLE;
            FOUR: next_state = in? FIVE : IDLE ;
            FIVE: next_state = in? SIX: DISC;
            SIX: next_state = ~in ? FLAG : ERROR;
            FLAG: next_state = ~in ? IDLE : ONE;
            ERROR: next_state = in ? ERROR : IDLE;
            DISC: next_state = in ? ONE : IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
     end
    
    assign disc = state == DISC;
    assign flag = (state == FLAG);
    assign err = (state == ERROR);

endmodule
