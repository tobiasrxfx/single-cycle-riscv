module mux4x1 (input [7:0] in_a,
					input [7:0] in_b,
					input [7:0] in_c,
					input [7:0] in_d,
					input [1:0] select, 
					output logic [7:0] out); 
					
	
	always_comb begin 
		case(select)
			2'b00 : out = in_a;
			2'b01 : out = in_b;
			2'b10 : out = in_c;
			2'b11 : out = in_d;
		endcase
	end 
			
endmodule 		
					

					

					