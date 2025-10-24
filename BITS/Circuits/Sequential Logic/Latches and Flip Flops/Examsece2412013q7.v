module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    reg Q_old;
    
    always @(posedge clk) begin
        case ({j,k}) 
            2'b01:	Q_old <= 0;
            2'b10:	Q_old <= 1;
            2'b11:	Q_old <= ~Q_old;
        endcase
    end
                
   assign Q = Q_old;             
    
    
endmodule
