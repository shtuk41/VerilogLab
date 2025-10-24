module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
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
        G = 3'b110,
        H = 3'b111
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case (state) 
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = ~data ? D : C;
            D: next_state = data ? E : A;
            E: next_state = readingTime == 3'b001 ? F : E;
            F: next_state = delayWire ? F : G;
            G: next_state = doneCounting ? H : G;
            H: next_state = ack ? A : H;
            default: next_state = A;
        endcase
    end
    
    wire [2:0] readingTime;
    wire [3:0] delayWire;
    wire doneCounting;
    
    reg [2:0] counter;
    reg [3:0] delay;
    reg done_counting;
    
    reg [9:0] milliseconds_counter;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        	counter <= 3'b100;
    		milliseconds_counter <= 10'd999;
            done_counting <= 1'b0; 
            delay <= 4'b0000;
        end else begin
            state <= next_state;
           
            if (state == E) begin
            	counter <= counter - 1'b1;
                delay <= {delay[2:0], data};
            end else if (state == F) begin
                 milliseconds_counter <= milliseconds_counter - 1'b1;
                    
                 if (milliseconds_counter == 10'd0) begin
                 	delay <= delay - 1'b1;
                    milliseconds_counter <= 10'd999;
                 end
            end else if (state == G) begin
                milliseconds_counter <= milliseconds_counter - 1'b1;
                        
                if (milliseconds_counter == 10'd1)
                	done_counting <= 1'b1;
            end else begin
                
                
  				if (state == A) begin
                	counter <= 3'b100;
                    done_counting <= 1'b0;
                    milliseconds_counter <= 10'd999;
                    delay <= 4'b0000;
                end
            end
        end
    end
    
    assign doneCounting = done_counting;
    assign delayWire = delay;
    assign readingTime = counter;
    assign counting = state >= F && state < H;
    assign count = delayWire;
    assign done = state == H;

endmodule
