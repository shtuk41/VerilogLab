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
        DIG_RIGHT = 3'b101,
        FALL = 3'b110,
        SPLATTER = 3'b111
    } state_t;
    
    state_t state, next_state;
    reg [4:0] counter = 5'b00000;
    reg time_up_r;
    wire time_up;
   
    always @(*) begin
        case (state)
            LEFT: next_state = ground & dig ? DIG_LEFT : ~ground ? FALL_LEFT : (bump_left ? RIGHT : LEFT);
            RIGHT: next_state = ground & dig ? DIG_RIGHT : ~ground ? FALL_RIGHT : (bump_right ? LEFT : RIGHT);
            FALL_LEFT: next_state = time_up & ground ? SPLATTER : time_up ? FALL : (ground ? LEFT : FALL_LEFT);
            FALL_RIGHT: next_state = time_up & ground ? SPLATTER : time_up ? FALL :  (ground ? RIGHT : FALL_RIGHT);
            DIG_LEFT: next_state = ~ground ? FALL_LEFT : DIG_LEFT;
            DIG_RIGHT: next_state = ~ground ? FALL_RIGHT : DIG_RIGHT;
            FALL: next_state = ground ? SPLATTER : FALL;
            SPLATTER:  next_state = SPLATTER;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        counter <= 5'b00000;
        time_up_r <= 1'b0; // Cleared only on reset
    end else begin
        state <= next_state;

        // COUNTER LOGIC
        if (state == FALL_LEFT || state == FALL_RIGHT)
            counter <= counter + 1'b1;
        else
            counter <= 5'b00000;

        // STICKY TIME_UP_R LOGIC: Sets the flag when counter hits 19 (20th cycle).
        // The OR operation keeps it set until areset.
        time_up_r <= time_up_r | ((state == FALL_LEFT || state == FALL_RIGHT) && (counter == 5'd19));
    end
end
    
    assign time_up = time_up_r;
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) | (state == FALL_RIGHT) | (state == FALL);
    assign digging = (state == DIG_LEFT) | (state == DIG_RIGHT);
    

endmodule
