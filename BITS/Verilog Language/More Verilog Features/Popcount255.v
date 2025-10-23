module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    integer i;
    reg [7:0] adder;
    
    always @(*) begin
        adder = 8'd0;
        for (i = 0; i < 255; i = i+1) begin
            adder = adder + in[i];
        end
    end
        
  	assign out = adder;      

endmodule
