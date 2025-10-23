module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    //0	0	0	0	0
    //1	0	0	1	0
    //2	0	1	0	1
    //3	0	1	1	1
    //4	1	0	0	0
    //5	1	0	1	1
    //6	1	1	0	0
    //7	1	1	1	1  
    
    reg f_out;
    
    always @(*) begin
        case ({x3,x2,x1})
            3'b000: f_out = 0;
            3'b001: f_out = 0;
            3'b010: f_out = 1;
            3'b011: f_out = 1;
            3'b100: f_out = 0;
            3'b101: f_out = 1;
            3'b110: f_out = 0;
            3'b111: f_out = 1;
        endcase
    end
    
	assign f = f_out;
endmodule
