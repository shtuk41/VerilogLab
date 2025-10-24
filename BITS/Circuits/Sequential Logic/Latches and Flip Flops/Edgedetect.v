module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] mem, pledge_t;
        
    always @(posedge clk) begin
    	mem <= in;
        pledge_t <= in & ~mem;
    end
    
    assign pedge = pledge_t;
    

endmodule
