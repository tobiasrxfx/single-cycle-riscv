module mux_2x1_param
		#(parameter WORD_WIDTH=8) 
		 (input logic [WORD_WIDTH-1:0]a,
		 input logic [WORD_WIDTH-1:0]b,
		 input logic select,
		 output logic [WORD_WIDTH-1:0]c);
	
	
	 assign c = select == 1'b0 ? a : b;
		
endmodule 