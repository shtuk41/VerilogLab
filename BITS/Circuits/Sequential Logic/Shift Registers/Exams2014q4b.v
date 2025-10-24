module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    
    wire [3:0] Q;
    wire [3:0] D;
    
    assign D[3] = KEY[2] ? SW[3] : KEY[1] ? KEY[3] : Q[3];
    assign D[2] = KEY[2] ? SW[2] : KEY[1] ? Q[3] : Q[2];
    assign D[1] = KEY[2] ? SW[1] : KEY[1] ? Q[2] : Q[1];
    assign D[0] = KEY[2] ? SW[0] : KEY[1] ? Q[1] : Q[0];

    MUXDFF m3(KEY[0],D[3],Q[3]);
    MUXDFF m2(KEY[0],D[2],Q[2]);
    MUXDFF m1(KEY[0],D[1],Q[1]);
    MUXDFF m0(KEY[0],D[0],Q[0]);
    
    assign LEDR = Q;
    
    
endmodule

module MUXDFF (input clk, input D, output reg Q);

    always @(posedge clk) begin
       Q <= D;        
    end
    
endmodule
