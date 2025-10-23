module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    wire [100:0] carry;
    assign carry[0] = cin;
   
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : adder_block
            adder u_adder (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i + 1])
            );
            assign cout[i] = carry[i+1]; // save each adder's carry
        end
    endgenerate
endmodule

module adder( 
    input a, 
    input b, 
    input cin,
	output sum,
	output cout);
    
    wire [1:0] sum_t;
    assign sum_t = a + b + cin;
    assign sum = sum_t[0];
    assign cout = sum_t[1];
    
    
endmodule
