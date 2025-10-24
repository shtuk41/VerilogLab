module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    reg [3:0] q_t;
    
    always @(posedge clk) begin
        if (shift_ena)
            q_t = {q_t[2:0], data};
        else if (count_ena)
            q_t = q_t - 1'b1;
    end
    
    assign q = q_t;

endmodule
