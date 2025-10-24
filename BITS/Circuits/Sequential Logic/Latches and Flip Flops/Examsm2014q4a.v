module top_module (
    input d, 
    input ena,
    output q);

    reg q_mem;
    
    always @(*) begin
        if (ena) begin
        	q_mem = d;    
        end
    end
    
    assign q = q_mem;
    
endmodule
