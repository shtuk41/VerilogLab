module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    typedef enum logic [1:0]
    {
        FIRST = 2'b00,
        SECOND = 2'b01,
        THIRD = 2'b10
    } state_t;
    
  	state_t state, next_state;
    
    always @(*) begin
        case(state)
            FIRST:	next_state = x ? SECOND : FIRST;
            SECOND: next_state = ~x ? THIRD : SECOND; 
            THIRD: next_state = x ? SECOND : FIRST;
        endcase
    end
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= FIRST;
        end else begin
           state <= next_state; 
        end
    end
        
    assign z = x & (state == THIRD);

endmodule
