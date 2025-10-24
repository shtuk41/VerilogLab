module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    reg [7:0] hh_t;
    reg [7:0] mm_t;
    reg [7:0] ss_t;
    reg pm_t;
    
    wire h1, h2, h1_reset, h2_reset;
    wire m1, m2, m1_reset, m2_reset;
    wire s1, s2, s1_reset, s2_reset;
    wire p; 
    
    assign h1 = (hh_t[3:0] == 4'h9) & (mm_t == 8'h59) & (ss_t == 8'h59);
    assign h2 = (mm_t == 8'h59) & (ss_t == 8'h59);
    assign h1_reset = (hh_t == 8'h12) & (mm_t == 8'h59) & (ss_t == 8'h59);
    assign h2_reset = (hh_t[3:0] == 4'h9) & (mm_t == 8'h59) & (ss_t == 8'h59);
    
    assign m1 = (mm_t[3:0] == 4'h9) & (ss_t == 8'h59);
    assign m2 = (ss_t == 8'h59);
    assign m1_reset = (mm_t == 8'h59) & (ss_t == 8'h59); 
    assign m2_reset = (mm_t[3:0] == 4'h9) & (ss_t == 8'h59); 
    
    assign s1 = (ss_t[3:0] == 4'h9);
    assign s1_reset = (ss_t == 8'h59);
    assign s2_reset = (ss_t[3:0] == 4'h9);
    
    assign p = (hh_t == 8'h11) & (mm_t == 8'h59) & (ss_t == 8'h59);

    always @(posedge clk) begin
        if (reset) begin
            hh_t <= 8'h12;
            mm_t <= 8'h00;
            ss_t <= 8'h00;
            pm_t <= 1'b0;
        end else if (ena) begin
            if (p)
                pm_t <= ~pm_t;
            
            if (h1_reset) begin
                hh_t[7:4] <= 4'h0;
            end else if (h1) begin
                hh_t[7:4] <= hh_t[7:4] + 1'b1;
            end
            
            if (h1_reset) begin
            	hh_t[3:0] <= 4'h1;
            end else if (h2_reset) begin
                hh_t[3:0] <= 4'h0;
            end else if (h2) begin
                hh_t[3:0] <= hh_t[3:0] + 1'b1;
            end
            
            if (m1_reset) begin
                mm_t[7:4] <= 4'h0;
            end else if (m1) begin
                mm_t[7:4] <= mm_t[7:4] + 1'b1;
            end
            
            if (m2_reset) begin
                mm_t[3:0] <= 4'h0;
            end else if (m2) begin
                mm_t[3:0] <= mm_t[3:0] + 1'b1;
            end
            
            if (s1_reset) begin
                ss_t[7:4] <= 4'h0;
            end else if (s1) begin
                ss_t[7:4] <= ss_t[7:4] + 1'b1;
            end
            
            if (s2_reset) begin
                ss_t[3:0] <= 4'h0;
            end else begin
                ss_t[3:0] <= ss_t[3:0] + 1'b1;
            end
        end
    end
    
    assign pm = pm_t;
    assign hh = hh_t;
    assign mm = mm_t;
    assign ss = ss_t;
     
endmodule
