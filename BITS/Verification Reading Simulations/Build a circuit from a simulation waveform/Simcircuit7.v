module top_module (
    input clk,
    input a,
    output q );
    
    reg q_t;
    
    always @(posedge clk) begin
        q_t <= ~a;
    end
    
    assign q = q_t;

endmodule
