module control_unit(input [6:0] op,
                    input [2:0] funct3,
                    input [6:0] funct7,
                    output logic [2:0] ula_control,
                    output logic ula_src,
                    output logic reg_write,
                    output logic [1:0] imm_src,
                    output logic mem_write,
                    output logic result_src,
                    output logic branch);
  
  always @* begin 
    casez({op,funct3, funct7})
      17'b0110011_000_0000000 : begin // ADD
        reg_write 	= 1'b1; 
        imm_src 	= 2'bxx; // Not important 'x' 
        ula_src 	= 1'b0;
        ula_control = 3'b000;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end 
      17'b0110011_000_0100000 : begin // SUB
        reg_write 	= 1'b1; 
        imm_src 	= 2'bxx; // Not important 'x' 
        ula_src 	= 1'b0;
        ula_control = 3'b001;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end
      17'b0110011_111_0000000 : begin // AND
        reg_write 	= 1'b1; 
        imm_src 	= 2'bxx; // Not important 'x' 
        ula_src 	= 1'b0;
        ula_control = 3'b010;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end 
      17'b0110011_110_0000000 : begin // OR
        reg_write 	= 1'b1; 
        imm_src 	= 2'bxx; // Not important 'x' 
        ula_src 	= 1'b0;
        ula_control = 3'b011;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end     
      17'b0110011_100_0000000 : begin // XOR
        reg_write 	= 1'b1; 
        imm_src 	= 2'bxx; // Not important 'x' 
        ula_src 	= 1'b0;
        ula_control = 3'b100;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end     
      17'b0110011_010_0000000 : begin // SLT
        reg_write 	= 1'b1; 
        imm_src 	= 2'bxx; // Not important 'x' 
        ula_src 	= 1'b0;
        ula_control = 3'b101;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end 
      17'b0010011_000_??????? : begin // ADDi
        reg_write 	= 1'b1; 
        imm_src 	= 2'b00; 
        ula_src 	= 1'b1;
        ula_control = 3'b000;
        mem_write 	= 1'b0;
        result_src 	= 1'b0;
        branch 		= 1'b0;
      end
      17'b0000011_000_??????? : begin // LB
        reg_write 	= 1'b1; 
        imm_src 	= 2'b00; 
        ula_src 	= 1'b1;
        ula_control = 3'b000;
        mem_write 	= 1'b0;
        result_src 	= 1'b1;
        branch 		= 1'b0;
      end
      17'b0100011_000_??????? : begin // SB
        reg_write 	= 1'b0; 
        imm_src 	= 2'b01; 
        ula_src 	= 1'b1;
        ula_control = 3'b000;
        mem_write 	= 1'b1;
        result_src 	= 1'bx; // Not important 'x' 
        branch 		= 1'b0;
      end
      17'b1100011_000_??????? : begin // BEQ
        reg_write 	= 1'b0; 
        imm_src 	= 2'b10; 
        ula_src 	= 1'b0;
        ula_control = 3'b001;
        mem_write 	= 1'b0;
        result_src 	= 1'bx; // Not important 'x' 
        branch 		= 1'b1;
      end      
		default : begin 
	    reg_write 	= 1'b1; 
        imm_src 	= 2'b11; 
        ula_src 	= 1'b1;
        ula_control = 3'b111;
        mem_write 	= 1'b1;
        result_src 	= 1'b1; // Not important 'x' 
        branch 		= 1'b0;  
		end 
    endcase   
  end 
        
endmodule 