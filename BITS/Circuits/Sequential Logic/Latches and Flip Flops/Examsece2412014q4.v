module top_module (
    input clk,
    input x,
    output z
); 
    reg Q1;
    reg Q2;
    reg Q3;
    wire d1 = x ^ Q1;
    wire d2 = x & ~Q2;
    wire d3 = x | ~Q3;
        
    FF f1(clk, d1, Q1);
    FF f2(clk, d2, Q2);
    FF f3(clk, d3, Q3);
    
    assign z = ~(Q1 | Q2 | Q3);

endmodule

module FF(input clk, input D, output reg Q);
    always @(posedge clk) begin
       Q <= D; 
    end
endmodule
