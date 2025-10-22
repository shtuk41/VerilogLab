module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] state_t;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state_t <= 2'b01;
        else if (~train_valid)
            state_t <= state_t;
        else if (train_taken)
            state_t <= (state_t == 2'b11) ? state_t : state_t  + 1'b1;  
        else
            state_t <= (state_t == 2'b00) ? state_t : state_t - 1'b1;  
    end
            
    assign state = state_t;
            

endmodule
