module top_module (
    input [3:1] y,
    input w,
    output Y2);
    //A,  B,  C,  D,  E,  F
    //000,001,010,011,100,101
    
    
    assign Y2 = ((y == 3'b001 | y == 3'b010 | y == 3'b100 | y == 3'b101) & w) | ((y == 3'b001 | y == 3'b101)& ~w);

endmodule
