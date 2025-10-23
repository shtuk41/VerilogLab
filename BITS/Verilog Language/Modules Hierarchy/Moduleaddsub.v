module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [31:0] b_to_use;
    
    assign b_to_use = {32{sub}} ^ b;
    
    
    wire [15:0] low_sum;
    wire low_cout;
    add16 low( .a(a[15:0]), .b(b_to_use[15:0]), .cin(sub), .sum(low_sum), .cout(low_cout) );
    
    wire [15:0]  high_sum;
    wire high_cout;
    add16 high( .a(a[31:16]), .b(b_to_use[31:16]), .cin(low_cout), .sum(high_sum), .cout(high_cout) );
    
    assign sum = {high_sum, low_sum};
    
    
    
endmodule
