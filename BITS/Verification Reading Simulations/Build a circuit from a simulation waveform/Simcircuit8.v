module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    reg q_t;
  
    always @(negedge clock) begin
        q_t <= a;
    end
    
    assign q = q_t;
    assign p = clock ? a : q_t;
        

endmodule
