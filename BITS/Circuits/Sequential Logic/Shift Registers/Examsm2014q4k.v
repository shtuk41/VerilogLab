module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire q0, q1, q2;
    
    ff f0(clk, resetn, in, q0);
    ff f1(clk, resetn, q0, q1);
    ff f2(clk, resetn, q1, q2);
    ff f3(clk, resetn, q2, out);

endmodule

module ff(input clk, input R, input D, output reg Q);
    
    always @(posedge clk) begin
        if (~R) begin
           Q <= 1'b0; 
        end else begin
           Q <= D;
        end
    end
    
endmodule
\