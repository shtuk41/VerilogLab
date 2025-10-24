`timescale 1ps/1ps

module top_module ();

    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff t1(clk, reset, t, q);
    
    initial begin
        clk = 0;
        reset = 0;
        t = 0;
        
        #1 reset = 1;
        #10 reset = 0; t = 1;
        
    end
    
    always #5 clk = ~clk;
    
endmodule
