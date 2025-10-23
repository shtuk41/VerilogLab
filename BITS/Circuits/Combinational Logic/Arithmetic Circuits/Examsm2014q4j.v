module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0] carry;
    
    fadd a1 (x[0], y[0], 0, carry[0], sum[0]);
    fadd a2 (x[1], y[1], carry[0], carry[1], sum[1]);
    fadd a3 (x[2], y[2], carry[1], carry[2], sum[2]);
    fadd a4 (x[3], y[3], carry[2], sum[4], sum[3]);
 endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );

    wire [1:0] sum_t;
  	assign sum_t = a + b + cin;
    assign cout = sum_t[1];
    assign sum = sum_t[0];
    
endmodule
