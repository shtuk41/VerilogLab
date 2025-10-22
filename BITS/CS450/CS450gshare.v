module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    
    reg [1:0] PHT [0:127] = '{default: 2'b01};
    reg [6:0] predict_history_global;
    
    wire [6:0] predict_index;
    assign predict_index = predict_pc ^ predict_history_global;
    
    wire [6:0] train_index;
    assign train_index = train_pc ^ train_history;
    
    integer i;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history_global <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01;
           
       end else begin 
           
           if (train_valid) begin
               if (train_taken && (PHT[train_index] < 2'b11))
                	PHT[train_index] <= PHT[train_index] + 1'b1;
               else if (!train_taken && (PHT[train_index] > 2'b00))
                	PHT[train_index] <= PHT[train_index] - 1'b1;
            
            	if (train_mispredicted)
                	predict_history_global <= {train_history[5:0], train_taken};
           end
           
       		if (predict_valid) begin
                if (~(train_valid && train_mispredicted))
            		predict_history_global <= {predict_history_global[5:0], PHT[predict_index][1]};
       		end
    	end
    end
    
    assign predict_taken = PHT[predict_index][1];
    assign predict_history = predict_history_global;
    

endmodule
