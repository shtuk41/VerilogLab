module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    typedef enum logic [3:0]
    {
        A = 4'b0000,
        B = 4'b0001,
        C = 4'b0010,
        D = 4'b0011,
        E = 4'b0100,
        F = 4'b0101,
        G = 4'b0110,
        H = 4'b0111,
        I = 4'b1000,
        J = 4'b1001
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case(state) 
            A: next_state = B;
            B: next_state = C; //f up
            C: next_state = x ? D : C;
            D: next_state = ~x ? E : D;
            E: next_state = x ? F : C;
            F: next_state = y ? H : G;
            G: next_state = y ? H : I;
            H: next_state = H; 
            I: next_state = I;
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    assign f = state == B;
    assign g = (state == F) || (state == G) || (state == H);

endmodule
