module top_module( 
    input a, b,
    output cout, sum );
    
    wire [1:0] sum_t;
    assign sum_t = a + b;
    assign sum = sum_t[0];
    assign cout = sum_t[1];

endmodule
