module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    reg [7:0] q_t;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
           q_t <= 8'h00; 
        end else begin 
           q_t <= d; 
        end
    end
    
    assign q = q_t;

endmodule
