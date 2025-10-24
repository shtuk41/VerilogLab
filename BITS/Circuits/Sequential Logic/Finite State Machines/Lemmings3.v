module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    typedef enum reg [2:0] {
        LEFT = 3'b000, 
        RIGHT =  3'b001, 
        FALL_LEFT = 3'b010, 
        FALL_RIGHT = 3'b011, 
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101 
    } state_t;
    
    state_t state, next_state;
   
    always @(*) begin
        case (state)
            LEFT: next_state = ground & dig ? DIG_LEFT : ~ground ? FALL_LEFT : (bump_left ? RIGHT : LEFT);
            RIGHT: next_state = ground & dig ? DIG_RIGHT : ~ground ? FALL_RIGHT : (bump_right ? LEFT : RIGHT);
            FALL_LEFT: next_state = ground ? LEFT : FALL_LEFT;
            FALL_RIGHT: next_state = ground ? RIGHT : FALL_RIGHT;
            DIG_LEFT: next_state = ~ground ? FALL_LEFT : DIG_LEFT;
            DIG_RIGHT: next_state = ~ground ? FALL_RIGHT : DIG_RIGHT;
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
    assign digging = (state == DIG_LEFT) | (state == DIG_RIGHT);

endmodule
