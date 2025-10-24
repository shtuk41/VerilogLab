module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    reg [9:0] q_t;
    
    always @(posedge clk) begin
        if (reset)
            q_t <= 10'd0;
        else if (q_t == 10'd999)
            q_t <= 10'd0;
        else
            q_t <= q_t + 1'b1;
    end
    
    assign q = q_t;

endmodule
