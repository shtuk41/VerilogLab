module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );
    
    reg [3:0] q_t;
    
    always @(*) begin
        case (c)
            4'b0000: q_t = b;
            4'b0001: q_t = e;
            4'b0010: q_t = a;
            4'b0011: q_t = d;
            default: q_t = 4'hf;
        endcase
    end
            
    assign q = q_t;
 
endmodule
