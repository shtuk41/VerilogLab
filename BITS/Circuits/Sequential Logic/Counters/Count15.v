module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] q_t;
    
    always @(posedge clk) begin
        if (reset) begin
            q_t <= 4'b0000;
        end else begin
            q_t <= q_t + 1;
        end
    end
    
    assign q = q_t;
    
endmodule
