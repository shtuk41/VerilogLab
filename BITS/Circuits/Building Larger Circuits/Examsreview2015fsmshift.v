module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [2:0] counter;
    
    always @(posedge clk) begin
        if (reset)
            counter <= 3'b100;
        else if (counter > 3'b000)
            counter <= counter - 1'b1;
        else
            counter <= 3'b000;
    end
    
	assign shift_ena = counter > 3'b000;    

endmodule
