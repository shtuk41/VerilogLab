module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    reg [15:0] q_t;
    
    assign ena[3] = (q_t[11:8] == 4'd9) & (q_t[7:4] == 4'd9) & (q_t[3:0] == 4'd9);
    assign ena[2] = (q_t[7:4] == 4'd9) & (q_t[3:0] == 4'd9);
    assign ena[1] = (q_t[3:0] == 4'd9);
   
    always @(posedge clk) begin
        if (reset) begin
           q_t <= 16'b0; 
        end else begin
            q_t[3:0] <= (q_t[3:0] == 4'd9) ? 4'd0 : q_t[3:0] + 4'd1; 
            
            if (ena[1])
                q_t[7:4] <= (q_t[7:4]  == 4'd9) ? 4'd0 : q_t[7:4] +  4'd1;
            
            if (ena[2])
                q_t[11:8] <= (q_t[11:8] == 4'd9) ? 4'd0 : q_t[11:8] + 4'd1;
            
            if (ena[3])
                q_t[15:12] <= (q_t[15:12] == 4'd9) ? 4'd0 : q_t[15:12] + 4'd1;
        end
    end
    
    assign q = q_t;

endmodule
