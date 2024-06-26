module register_file(input [7:0] write_data, 
                     input [2:0] write_addr,
                     input write_enable,
                     input [2:0] read_addr0, 
                     input [2:0] read_addr1,
                     input clk, 
                     input rst,
                     output logic [7:0] reg_data0,
                     output logic [7:0] reg_data1,
							output logic [7:0] debug_reg_out [8]); 
                            

  logic [7:0] registers [8]; // 8 elements of 8 bits each one 

  assign debug_reg_out = registers;

  always @ (posedge clk or negedge rst) begin 

    if(!rst) begin 

      registers <= '{ default : 8'h00 }; // Set the value of all registers to zero

    end 
    else if(write_enable) begin 
      
      if(write_addr == 3'b0) begin 
        registers[0] <= 8'b0; // Can I do it outside of the always using an assign statement?
      end 
		else begin 
		  registers[write_addr] <= write_data;
    
		end 
    end 

  end 
  
  // Combinational circuit to set the output the required register value
  always @* begin
    reg_data0 <= registers[read_addr0];
    reg_data1 <= registers[read_addr1];
  
  end

endmodule