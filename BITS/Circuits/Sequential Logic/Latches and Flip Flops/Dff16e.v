module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    reg [15:0] q_t;
    
    always @(posedge clk) begin
        if (~resetn) begin 
            q_t <= 16'h0000;
        end else begin
            if (byteena[0]) begin
                q_t[7:0] <= d[7:0];
        	end
            if (byteena[1]) begin
            q_t[15:8] <= d[15:8];
    		end
    	end
    end
    
    assign q = q_t;
    

endmodule
