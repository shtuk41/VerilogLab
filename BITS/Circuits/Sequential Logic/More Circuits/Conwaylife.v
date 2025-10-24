module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    wire [255:0] q_t;
    
    genvar i;
    
    generate
        for (i = 0; i <= 255; i = i + 1) begin : loop
            state #(.INDEX(i)) s(clk, load, data[i], q_t, q_t[i]);
        end
    endgenerate
    
    assign q = q_t;
endmodule

module state #(parameter [7:0] INDEX = 8'd0)(input clk, input load, input data, input [255:0] q, output reg out);
   
    reg [7:0] left, right, topleft, topright, bottomleft, bottomright, top, bottom;
    reg [3:0] sum;
   
    always @(posedge clk) begin
        if (load) begin
           out <= data; 
        end else begin
             
            if ((INDEX + 8'b1) % 16 == 8'b0)
            	left = INDEX - 8'd15;
            else
                left = INDEX + 8'b1;
            
            if ((INDEX) % 16 == 8'b0)
            	right = INDEX + 8'd15;
            else
                right = INDEX - 8'b1;
            
            if (INDEX >= 8'd0 && INDEX <= 8'd15)
                bottom = INDEX + 8'd240;
            else
                bottom = INDEX - 8'd16;
            
            if (INDEX >= 8'd240 && INDEX <= 8'd255)
                top = INDEX - 8'd240;
            else
                top = INDEX + 8'd16;
            
            if (INDEX == 8'd255)
                topleft = 8'd0;
            else if (INDEX >= 8'd240 && INDEX <= 8'd254)
                topleft = INDEX - 8'd239;
            else if ((INDEX + 8'b1) % 16 == 8'b0)
            	topleft = INDEX + 8'd1;
            else
                topleft = INDEX + 8'd17;
        
        	if (INDEX == 8'd240)
                topright = 8'd15;
            else if (INDEX >= 8'd241 && INDEX <= 8'd255)
                topright = INDEX - 8'd241;
            else if (INDEX % 16 == 8'b0)
            	topright = INDEX + 8'd31;
            else
                topright = INDEX + 8'd15;
    
    		if (INDEX == 8'd15)
                bottomleft = 8'd240;
    		else if (INDEX >= 8'd0 && INDEX <= 8'd14)
                bottomleft = INDEX + 8'd241;
            else if ((INDEX + 8'b1) % 16 == 8'b0)
            	bottomleft = INDEX - 8'd31;
            else
                bottomleft = INDEX - 8'd15;
        
    		if (INDEX == 8'd0)
                bottomright = 8'd255;
            else if ((INDEX >= 8'd1) && (INDEX <= 8'd15))
                bottomright = INDEX + 8'd239;
            else if (INDEX % 16 == 8'b0)
            	bottomright = INDEX - 8'd1;
            else
                bottomright = INDEX - 8'd17;
           
            sum = 	q[left] + q[right] + q[topleft] + q[topright] + 
            		q[bottomleft] + q[bottomright] + q[top] + q[bottom];
            
            case (sum)
                4'b0000: out <= 0;
                4'b0001: out <= 0;
                4'b0011: out <= 1;
                4'b0100: out <= 0;
                4'b0101: out <= 0;
                4'b0110: out <= 0;
                4'b0111: out <= 0;
                4'b1000: out <= 0;
                default: out <= q[INDEX];
             endcase
        end
    end
endmodule
