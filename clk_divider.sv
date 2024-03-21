// Frequency divider from 50MHz to 1Hz 
module clk_divider (input clk_in,
                     output logic clk_out);
  
  logic[27:0] counter = 28'd0; //With 28 bits it goes untill ~0.2GHz 
  
  parameter DIVISOR = 28'd50_000_000; // Input clock frequency 50MHz 
  
	always @(posedge clk_in)
	begin
		 counter = counter + 1'd1;
		 if(counter >= DIVISOR)
  			counter = 1'd0;
 
      clk_out = (counter<DIVISOR/2)?1'b1:1'b0;
	end
  
  
endmodule 
