module top_module (
    input clk,
    input in, 
    output out);
    
    reg out_t;
	    
    always @(posedge clk) begin
       out_t <= in ^ out_t;
     end
    
 	assign out = out_t;   

endmodule
