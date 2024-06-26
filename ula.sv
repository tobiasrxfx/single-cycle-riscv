module ula (
  input [7:0] src_a,
  input [7:0] src_b,
  input [2:0] ctrl,
  output logic [7:0] result,
  output logic zero
);
  
  // Perform operations based on ctrl input
  always @* begin
    case (ctrl)
      3'b000: result <= src_a + src_b;        // Add
      3'b001: result <= src_a + ~src_b + 1;        // Subtraction
      3'b010: result <= src_a & src_b;        // Logic AND
      3'b011: result <= src_a | src_b;     // Logic OR
		3'b100: result <= src_a^src_b;			 // Logic XOR
      3'b101: result <= (src_a < src_b) ? 1 : 0; // Less than comparison
      default: result <= 8'b1111_1111;        // Default value
    endcase
    
    zero <= result == 8'b0000_0000 ? 1'b1 : 1'b0; 
    
  end

endmodule
