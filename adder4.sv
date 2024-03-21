module adder_4(input a,
					input clk, 
					output logic b);
					
			
		always @(posedge clk) begin 
		
			a = b;
			
		end 
					
endmodule 