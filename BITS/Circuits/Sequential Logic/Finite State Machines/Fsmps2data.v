module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
     typedef enum logic [1:0]
    {
        NOT_FOUND = 2'b00,
        ONE = 2'b01,
        TWO = 2'b10,
        THREE = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] out_bytes_t;

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
            state <= NOT_FOUND;
        else
            state <= next_state;
         
        if (next_state == ONE)
            out_bytes_t[23:16] <= in;
        else if (next_state == TWO)
            out_bytes_t[15:8] <= in;
        else if (next_state == THREE)
            out_bytes_t[7:0] <= in;
        else
        	out_bytes_t <= 24'h000000;
     end            

    // Output logic
    assign done = (state == THREE);

    // New: Datapath to store incoming bytes.
    assign out_bytes = out_bytes_t;

endmodule
