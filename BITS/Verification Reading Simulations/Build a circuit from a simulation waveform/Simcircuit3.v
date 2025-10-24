module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = 	(d || c) & (a || b); // Fix me

endmodule
