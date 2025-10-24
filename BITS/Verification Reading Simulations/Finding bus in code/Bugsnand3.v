module top_module (input a, input b, input c, output out);//

    wire out_t;
    andgate inst1 ( out_t, a, b, c, 1'b1, 1'b1);
    
    assign out = ~out_t;

endmodule
