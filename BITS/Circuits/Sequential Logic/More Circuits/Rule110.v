module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    reg [511:0] q_t;
    
   	genvar i;
    
    oneten t110_0(clk, load, data[0], q_t[1], q_t[0], 1'b0, q_t[0]);
    oneten t110_511(clk, load, data[511], 1'b0, q_t[511], q_t[510], q_t[511]);
  	
    generate 
        for (i = 1; i < 511; i = i + 1) begin : loop
            oneten t110(clk, load, data[i], q_t[i + 1], q_t[i],q_t[i - 1], q_t[i]);
        end    
    endgenerate
    
    assign q = q_t;
endmodule

module oneten(input clk, input load, input d_i, input left, input center, input right, output reg out);
    
    always @(posedge clk) begin
        if (load) begin
            out <= d_i;
        end else begin     
            case ({left, center, right})
                3'b111:	out <= 1'b0;
                3'b110:	out <= 1'b1;
                3'b101:	out <= 1'b1;
                3'b100:	out <= 1'b0;
                3'b011:	out <= 1'b1;
                3'b010:	out <= 1'b1;
                3'b001:	out <= 1'b1;
                3'b000:	out <= 1'b0;
             endcase
        end
    end
    
endmodule
