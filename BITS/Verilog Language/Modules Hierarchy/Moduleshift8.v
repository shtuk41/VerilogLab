module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] md1_q;
    my_dff8 instance1 ( .clk(clk), .d(d), .q(md1_q));
    
    wire  [7:0] md2_q;
    my_dff8 instance2 ( .clk(clk), .d(md1_q), .q(md2_q));
    
    wire  [7:0] md3_q;
    my_dff8 instance3 ( .clk(clk), .d(md2_q), .q(md3_q));
    
    always @(*) begin
    case(sel)
    	2'b00: q = d;
        2'b01: q = md1_q;
        2'b10: q = md2_q;
       2'b11:  q = md3_q;
    endcase
   	end

 

endmodule
