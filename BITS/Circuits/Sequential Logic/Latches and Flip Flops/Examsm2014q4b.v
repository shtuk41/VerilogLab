module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    
    reg q_t;
    
    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q_t <= 1'b0;
        end else begin
            q_t <= d;
        end
    end
    
    assign q = q_t;

endmodule
\