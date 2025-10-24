module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    typedef enum logic [1:0]
    {
        A = 2'b01,
        B = 2'b10
    } states_t;
    
    states_t state, next_state;
    reg [1:0] cycle_count;
    reg [1:0] occurances;
    
    always @(*) begin
        case(state) 
            A: next_state = s ? B : A;
            default: next_state = state;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            cycle_count <= 2'b00;
            occurances <= 2'b00;
        end else begin
            state <= next_state; 
            
            if (state == B) begin
                cycle_count <= cycle_count == 2'b10 ? 2'b00 : cycle_count + 1'b1;
                occurances <=  cycle_count == 2'b00 ? w : (w ? occurances + 1'b1: occurances);
            end else begin
                cycle_count <= 2'b00;
            end
        end
    end
    
    assign z = (cycle_count == 2'b00) & (occurances == 2'b10) & (state == B);
endmodule
