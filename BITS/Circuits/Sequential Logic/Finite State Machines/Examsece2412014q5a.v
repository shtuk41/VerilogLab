module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	parameter A = 2'b01, B = 2'b10;
    
    reg [1:0] state, next_state;
    
    reg z_t;
    
    always @(*) begin
        case (state) 
            A: next_state = ~areset & x ? B : A;
            B: next_state = B;
        endcase
    end
    
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state = A;
            z_t = 1'b0;
        end else begin
            state <= next_state;
        
            case (state)
                A: z_t = x;
                B: z_t = ~x;
            endcase
        end
    end
    
    assign z = z_t;
    
endmodule
