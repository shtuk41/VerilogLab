`timescale 1ps/1ps

module top_module();
    
    reg A, B;
    wire OUT;
    
    andgate agate({B, A}, OUT);
    
    initial begin
        A = 1'b0;
        B = 1'b0;
       
        #5 $display("Time=%0t A=%b B=%b OUT=%b", $time, A, B, OUT);
        #5 A = 1;	
        #1 $display("Time=%0t A=%b B=%b OUT=%b", $time, A, B, OUT);
        #9 B = 1; A = 0;
        #1 $display("Time=%0t A=%b B=%b OUT=%b", $time, A, B, OUT);
        #9 A = 1; 
        #1 $display("Time=%0t A=%b B=%b OUT=%b", $time, A, B, OUT);
    end

endmodule
