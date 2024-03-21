module program_counter(input [7:0] pc_in,
                       input clk, 
                       input rst, 
                       output logic [7:0] pc_out);
  
  always @ (posedge clk or negedge rst) begin 
    if(!rst)
      pc_out <= 8'b0000_0000; 
    else 
      pc_out <= pc_in; 
    
  end
  
endmodule  