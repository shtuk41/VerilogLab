module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    
    reg [7:0] q_temp;
    
    always @(posedge clk) begin
    	q_temp <= reset ? 1'b0 : d;
    end
    
    assign q = q_temp;

endmodule
