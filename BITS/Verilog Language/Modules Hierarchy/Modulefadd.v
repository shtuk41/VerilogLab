module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//

    wire [15:0] low_sum; 
    wire low_cout; 
    
    add16 low ( .a(a[15:0]), .b(b[15:0]), .cin(0), .sum(low_sum), .cout(low_cout) ); 
    wire [15:0] high_sum; 
    wire high_cout; 
    
    add16 high ( .a(a[31:16]), .b(b[31:16]), .cin(low_cout), .sum(high_sum), .cout(high_cout) ); 
    
    assign sum = {high_sum, low_sum};
    
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
    wire [1:0] t;
    assign t = a + b + cin;
    assign sum = t[0];
    assign cout = t[1];
    

endmodule
