// Module decoder hex-7seg

module mod_counter (input clk,
                    input rst, 
                    output [3:0] count); 
  
  logic[3:0] counter = 1'd0;   
  parameter MAX_COUNT = 4'd12; //Set the counter's maximum value 
  
  always @(posedge clk or negedge rst) begin
    if(!rst)  
		counter <= 1'd0;
	 else 
	 begin 
      counter <= counter + 1'd1;
      if (counter == MAX_COUNT -1)
        counter <= 1'd0;
	 end 
		  
  end
  
  assign count = counter;
  
endmodule 