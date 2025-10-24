module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=1'b0, RIGHT=1'b1;
    reg state = LEFT, next_state;

    always @(*) begin
        // State transition logic
        if (bump_left & (state == LEFT)) 
            next_state = RIGHT;
        else if (bump_right & (state == RIGHT)) 
            next_state = LEFT;
        else 
            next_state = state;
    end

    always @(posedge clk or posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
