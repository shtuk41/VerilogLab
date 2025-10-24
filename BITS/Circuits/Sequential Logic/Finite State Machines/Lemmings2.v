module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter [1:0] LEFT = 2'b00, RIGHT =  2'b01, FALL_LEFT = 2'b10, FALL_RIGHT = 2'b11; 
    reg [1:0] state,  next_state;
    
    always @(*) begin
        case (state)
            LEFT: next_state = ~ground ? FALL_LEFT : (bump_left ? RIGHT : LEFT);
            RIGHT: next_state = ~ground ? FALL_RIGHT : (bump_right ? LEFT : RIGHT);
            FALL_LEFT: next_state = ground ? LEFT : FALL_LEFT;
            FALL_RIGHT: next_state = ground ? RIGHT : FALL_RIGHT;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state; 
        end
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) | (state == FALL_RIGHT);
    
endmodule
