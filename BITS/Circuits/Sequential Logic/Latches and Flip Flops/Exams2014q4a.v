module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    reg q_t;
    
    always @(posedge clk) begin
        q_t <= L ? R : (E ? w : q_t);
    end
    
    assign Q = q_t;

endmodule
