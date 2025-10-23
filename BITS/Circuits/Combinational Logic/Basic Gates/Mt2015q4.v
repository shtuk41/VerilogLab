module top_module (input x, input y, output z);
	wire a1_out;
    wire a2_out;
    wire b1_out;
    wire b2_out;
    
    a a1(x, y, a1_out);
    a a2(x, y, a2_out);
    b b1(x, y, b1_out);
    b b2(x, y, b2_out);
    
    wire ab1, ab2;
    
    assign ab1 = a1_out | b1_out;
    assign ab2 = a2_out & b2_out;
    
    assign z = ab1 ^ ab2;
   
endmodule

module a (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module b (input x, input y, output z);
    assign z = !(x^y);
endmodule


