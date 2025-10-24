module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    reg [4:0] q_t;
    
    always @(posedge clk) begin
        if (reset) begin
           q_t <= 5'b00001;
        end else begin
            q_t <= {q_t[0], q_t[4], q_t[3] ^ q_t[0], q_t[2], q_t[1]};
        end
    end
    
    assign q = q_t;

endmodule
