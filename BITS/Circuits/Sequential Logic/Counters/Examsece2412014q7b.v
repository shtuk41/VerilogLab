module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
   
    wire [3:0] hundreds, tens, ones;
    
    assign c_enable[2] = (tens == 4'b1001) & (ones == 4'b1001);
    assign c_enable[1] = (ones == 4'b1001);
    assign c_enable[0] = 1'b1;
    
    bcdcount counter0 (clk, reset, c_enable[2],hundreds);
    bcdcount counter1 (clk, reset, c_enable[1],tens);
    bcdcount counter2 (clk, reset, c_enable[0],ones);
    
    assign OneHertz = (hundreds == 4'b1001) & (tens == 4'b1001) & (ones == 4'b1001);

endmodule
