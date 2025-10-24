module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    reg [7:0] q_t;
    always @(negedge clk) begin
        q_t <= reset ? 8'h34 : d;
    end
    
    assign q = q_t;

endmodule
