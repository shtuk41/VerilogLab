module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
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
    reg [7:0] out_byte_t;
    
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
        if (reset) begin
            state <= IDLE;
            out_byte_t <= 8'h00;
        end else begin
            state <= next_state;
        end
        
        case (state)
            ONE:out_byte_t <= {7'b0000000, in};
            TWO:out_byte_t <= out_byte_t | (in << 1);
            THREE:out_byte_t <= out_byte_t | (in << 2); 
            FOUR:out_byte_t <= out_byte_t | (in << 3);
            FIVE:out_byte_t <= out_byte_t | (in << 4);
            SIX:out_byte_t <= out_byte_t | (in << 5);
            SEVEN:out_byte_t <= out_byte_t | (in << 6);
            EIGHT:out_byte_t <= out_byte_t | (in << 7);
            INVALID_FRAME: out_byte_t <= 8'h00;
        endcase
    end
    
    assign done = (state == STOP);
    // New: Datapath to latch input bits.
	assign out_byte = out_byte_t;
    
endmodule
