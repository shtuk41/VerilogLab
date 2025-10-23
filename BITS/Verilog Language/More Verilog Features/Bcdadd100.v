module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
   
    genvar i;
    generate 
        for (i = 0; i < 100; i = i + 1) begin : adder_block
            bcd_fadd fadd(
                .a(a[i * 4 + 3 : i * 4]),
                .b(b[i * 4 + 3 : i * 4]),
                .cin(carry[i]),
                .cout(carry[i + 1]),
                .sum(sum[i * 4 + 3 : i * 4]));
        end
    endgenerate

    assign cout = carry[100];        
endmodule
