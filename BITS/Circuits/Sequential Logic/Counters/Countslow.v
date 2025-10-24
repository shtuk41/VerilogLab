module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    reg [3:0] q_t;
    
    always @(posedge clk) begin
        if (reset) begin 
        	q_t <= 4'b0000;
        end else if (slowena == 1'b1) begin
            if (q_t == 4'b1001)
                q_t <= 4'b0000;
            else 
                q_t <= q_t + 1;
        end
    end

    assign q = q_t;
    
endmodule
