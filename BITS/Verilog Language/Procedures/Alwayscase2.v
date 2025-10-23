// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    always @(*) begin
        case (in)
            4'b0000: pos = 2'b00;//0
            4'b0001: pos = 2'b00;//1
            4'b0010: pos = 2'b01;//2
            4'b0011: pos = 2'b00;//3
            4'b0100: pos = 2'b10;//4
            4'b0101: pos = 2'b00;//5
            4'b0110: pos = 2'b01;//6
            4'b0111: pos = 2'b00;//7
            4'b1000: pos = 2'b11;//8
            4'b1001: pos = 2'b00;//9
            4'b1010: pos = 2'b01;//a
            4'b1011: pos = 2'b00;//b
            4'b1100: pos = 2'b10;//c
            4'b1101: pos = 2'b00;//d
            4'b1110: pos = 2'b01;//e
            4'b1111: pos = 2'b00;//f
            default:  pos = 2'b00;
        endcase
    end

endmodule
