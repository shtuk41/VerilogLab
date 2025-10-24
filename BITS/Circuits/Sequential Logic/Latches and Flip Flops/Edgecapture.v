module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
   
	integer i;
    reg [31:0] mem, out_t;
    
    always @(posedge clk) begin
        mem <= in;
        
        if (reset) begin
        	out_t <= 32'h00000000;
        end else begin
                       
            for (i = 0; i < 32; i = i + 1)
                 if (~in[i] & mem[i])
                     out_t[i] <= 1'b1;  
        end
    end
    
    assign out = out_t;
    
endmodule
