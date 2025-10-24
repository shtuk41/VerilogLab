module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [7:0] Q;
    reg Z_t;
    
    always @(posedge clk)  begin
        if (enable) begin
            Q[0] <= S;
        	Q[1] <= Q[0];
            Q[2] <= Q[1];
            Q[3] <= Q[2];
            Q[4] <= Q[3];
            Q[5] <= Q[4];
            Q[6] <= Q[5];
            Q[7] <= Q[6];
        end
    end
    
    always @(*) begin
        case({A,B,C})
            3'b000: Z_t = Q[0];
            3'b001: Z_t = Q[1];
            3'b010: Z_t = Q[2];
            3'b011: Z_t = Q[3];
            3'b100: Z_t = Q[4];
            3'b101: Z_t = Q[5];
            3'b110: Z_t = Q[6];
            3'b111: Z_t = Q[7];
            default: Z_t = Z_t;
        endcase
    end

    assign Z = Z_t;        
            
endmodule
