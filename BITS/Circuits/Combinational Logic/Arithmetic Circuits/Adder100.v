module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    wire [100:0] sum_t;
    
    assign sum_t = a + b + cin;
    assign sum = sum_t[99:0];
    assign cout = sum_t[100];
    
endmodule
