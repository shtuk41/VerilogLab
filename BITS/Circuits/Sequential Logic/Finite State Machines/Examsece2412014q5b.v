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
            A: next_state = (x == 1'b1) ? B : A;
            B: next_state = B;    
        endcase
    end
    
    
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
           state <= A;
           z_t <= 1'b0;
        end else begin
           state <= next_state;
        end
    end

    assign z = state == A ? x : ~x;

endmodule
