module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
	
    reg q_t;
    
    always @(posedge clk) begin
        if (r) begin
           q_t <= 1'b0; 
        end else begin
           q_t <= d; 
        end
    end
    
    assign q = q_t;
    
endmodule
