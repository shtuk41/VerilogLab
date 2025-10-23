module top_module( 
    input a, b, cin,
    output cout, sum );

    wire [1:0] sum_t;
  	assign sum_t = a + b + cin;
    assign cout = sum_t[1];
    assign sum = sum_t[0];
    
endmodule
