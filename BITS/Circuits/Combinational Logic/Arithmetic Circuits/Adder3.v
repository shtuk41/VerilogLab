module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    wire sum1, sum2, sum3;
    fadd add1 (a[0], b[0], cin, cout[0], sum1);
    fadd add2 (a[1], b[1], cout[0], cout[1], sum2);
    fadd add3 (a[2], b[2], cout[1], cout[2], sum3);
    
    assign sum = {sum3, sum2, sum1};
   
endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );

    wire [1:0] sum_t;
  	assign sum_t = a + b + cin;
    assign cout = sum_t[1];
    assign sum = sum_t[0];
    
endmodule
