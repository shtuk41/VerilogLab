module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    typedef enum logic [2:0]
    {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case (state) 
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = ~data ? D : C;
            D: next_state = data ? E : A;
            E: next_state = counter == 3'b000 ? F : E;
            F: next_state = done_counting ? G : F;
            G: next_state = ack ? A : G;
            default: next_state = A;
        endcase
    end
    
    reg [2:0] counter;
   
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        	counter <= 3'b011;
        end else begin
            state <= next_state;
            
            if (state == E & counter > 3'b000)
            	counter <= counter - 1'b1;
            else if (state == A)
                counter <= 3'b011;
        end
    end
   
	assign shift_ena = state == E; 
    assign counting = state == F;
    assign done = state == G;
endmodule
