module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    
    reg [31:0] q_t;
    reg [31:0] q_mem;
    
    always @(posedge clk) begin
        if (reset) begin
           q_t <= 32'h0001; 
        end else begin
           q_t <= q_mem;
        end
    end
    
    always @(*) begin
         q_mem = {q_t[0], q_t[31:1]};
        q_mem[21] = (q_t[22] ^ q_t[0]); 
        q_mem[1] = (q_t[2] ^ q_t[0]); 
        q_mem[0] = (q_t[1] ^ q_t[0]); 
    end    
    
    
    assign q = q_t;
endmodule
