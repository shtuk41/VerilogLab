module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    reg [31:0] predict_history_t;
    
    always @(posedge clk or posedge areset)  begin
        if (areset)
            predict_history_t <= 32'h0000;
        else if (train_mispredicted)
            predict_history_t <= {train_history[30:0], train_taken};
        else if (predict_valid)
            predict_history_t <= {predict_history_t[30:0], predict_taken};
     end
    
    assign predict_history = predict_history_t;

endmodule
