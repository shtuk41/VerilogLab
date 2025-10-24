module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = ~(a | b | c | d) || 
        		(~a & ~b & c & d) || 
        		(~a & ~c & d & b) || 
        		(~a & ~d & b & c) || 
        		(~c & ~b & d & a) || 
        		(c & a & ~b & ~d) || 
        		(a & b & ~c & ~d) || 
        		(a & b & c & d); // Fix me

endmodule
