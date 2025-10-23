module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
	wire [15:0] low_sum; 
    wire low_cout; 
    add16 low ( .a(a[15:0]), .b(b[15:0]), .cin(0), .sum(low_sum), .cout(low_cout) ); 
    
    wire [15:0] high_sum1; 
    wire high_cout1;
    add16 high1 ( .a(a[31:16]), .b(b[31:16]), .cin(0), .sum(high_sum1), .cout(high_cout1) ); 
    
    wire [15:0] high_sum2; 
    wire high_cout2; 
    add16 high2 ( .a(a[31:16]), .b(b[31:16]), .cin(1), .sum(high_sum2), .cout(high_cout2) ); 
    
    reg [15:0] high_bits;
    
    always @(*) begin
        case (low_cout)
            1'b0:high_bits = high_sum1;
            1'b1:high_bits = high_sum2;
            endcase
    end
    
    assign sum = {high_bits, low_sum};

endmodule
