`timescale 1ps/1ps

module top_module();

    reg clk;
    reg in;
    reg [2:0] s;
    wire out;
   
    q7 q(clk, in, s, out);
    
    initial begin 
        clk = 0;
        in = 0;
        s = 3'b010;
        
        $monitor("T=%0t clk=%b in=%b s=%b out=%b", $time, clk, in, s, out);
        
        #10 s= 3'b110;
        #10 in = 1; s= 3'b010;
        #10 in = 0; s= 3'b111;
        #10 in = 1; s= 3'b000;
        #30 in = 0;
    end
    
    always #5 clk = ~clk;
    
endmodule
