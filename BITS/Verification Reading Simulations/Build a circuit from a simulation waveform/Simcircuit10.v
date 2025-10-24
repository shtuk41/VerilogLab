module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    reg state_t;
    
    always @(posedge clk) begin
        if (a & b)
            state_t <= 1'b1;
        else if (~a & ~b)
            state_t <= 1'b0;
    end
    
    assign state = state_t;
    assign q = a ^ b ^ state;
    
    

endmodule
