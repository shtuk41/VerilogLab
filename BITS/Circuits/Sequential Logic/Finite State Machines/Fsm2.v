module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if (state == OFF && j == 1'b1)
        	next_state = ON;
        else if (state == OFF && j == 1'b0)
        	next_state = OFF;
        else if (state == ON && k == 1'b1)
            next_state = OFF;
        else if (state == ON && k == 1'b0)
            next_state = ON;
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == ON);
    

endmodule
