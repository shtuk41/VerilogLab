module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    reg [1:0] state, next_state;
    reg dfr_t, dfr_next;
 	
    
    always @(*) begin
        case(s)
            3'b111: next_state = A;
            3'b011: next_state = B;
            3'b001: next_state = C;
            3'b000: next_state = D;
			default: next_state = state;     
        endcase
        
        dfr_next = (next_state > state) | (dfr_t & (next_state == state));
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= D;
            dfr_t <= 1'b1;
        end else begin
            state <= next_state;
            dfr_t <= dfr_next;
        end
    end
    
    assign fr3 = state >= D;
    assign fr2 = state >= C;
    assign fr1 = state >= B;
    assign dfr = dfr_t;

endmodule
