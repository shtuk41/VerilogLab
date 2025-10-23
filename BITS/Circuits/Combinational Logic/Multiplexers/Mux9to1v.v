module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    
    reg [15:0] out_r;
    
    always @(*) begin
        out_r = 16'h0000;
 
        case(sel)
            4'b0000: out_r = a;
            4'b0001: out_r = b;
            4'b0010: out_r = c;
            4'b0011: out_r = d;
            4'b0100: out_r = e;
            4'b0101: out_r = f;
            4'b0110: out_r = g;
            4'b0111: out_r = h;
            4'b1000: out_r = i;
            default:  out_r = 16'hffff;  
        endcase
    end
    
    assign out = out_r;

endmodule
