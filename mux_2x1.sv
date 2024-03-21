module mux_2x1 (input logic [7:0]a,
		 input logic [7:0]b,
		 input logic select,
		 output logic [7:0]c);
		 
	 assign c = select == 1'b0 ? a : b;
		
endmodule	
		 
		 
		 

