module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    reg [511:0] q_t;
   	integer i;
    
    always @(posedge clk) begin
        if (load) begin
            q_t <= data;
        end else begin
            
            q_t[0] <= q_t[1];
            q_t[511] <= q_t[510];
            
        	for (i = 1; i < 511; i = i + 1) begin
                q_t[i] <= q_t[i + 1] ^ q_t[i - 1];
        	end

        end
    end

    assign q = q_t;
endmodule
