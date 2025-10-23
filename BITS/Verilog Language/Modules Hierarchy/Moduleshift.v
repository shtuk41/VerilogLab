module top_module ( input clk, input d, output q );

    wire md1_q;
    my_dff instance1 ( .clk(clk), .d(d), .q(md1_q) );
    
	wire md2_q;
    
    my_dff instance2 ( .clk(clk), .d(md1_q), .q(md2_q) );
    my_dff instance3 ( .clk(clk), .d(md2_q), .q(q) );
endmodule
