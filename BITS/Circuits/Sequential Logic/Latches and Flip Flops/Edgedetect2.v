module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
   	
    reg [7:0] mem, anyedge_t;
    integer i;
    
    always @(posedge clk) begin
    	mem <= in;
        
        for (i = 0; i < 8; i = i + 1) begin
            anyedge_t[i] <= mem[i] != in[i];
        end
    end
    
    assign anyedge = anyedge_t;
    
    

endmodule
