module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] q_t;
    
    always @(posedge clk) begin
        if (reset)
            q_t <= 4'b0000;
        else if (q_t == 4'd9)
            q_t <= 4'b0000;
        else
            q_t <= q_t + 1;
    end
    
    assign q = q_t;
    
endmodule
