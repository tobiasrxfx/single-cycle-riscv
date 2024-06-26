// I can substitute a clock input for a counter instead. So the counter must have an adequate clock frequency in it and the counter must be parametered with 12 modulo. 

module animation(input clk,
                 output [0:6] disp_0,
                 output [0:6] disp_1,
                 output [0:6] disp_2,
                 output [0:6] disp_3);
  
  logic [3:0] counter = 4'd0;  
  
  parameter [3:0] STOP_COUNT = 4'd12; 
  
  always @ (posedge clk) 
    begin 
      case (counter)
        4'd0 : begin 
          	disp_0 = ~7'b1000000; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = 7'b1111111;
        end 
        4'd1 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = ~7'b1000000;
            disp_2 = 7'b1111111;
            disp_3 = 7'b1111111;
        end 
        4'd2 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = 7'b1111111;
            disp_2 = ~7'b1000000;
            disp_3 = 7'b1111111;
        end 
        4'd3 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = ~7'b1000000;
        end
        4'd4 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = ~7'b0100000;
        end
        4'd5 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = ~7'b0010000;
        end
        4'd6 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = ~7'b0001000;
        end
        4'd7 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = 7'b1111111;
            disp_2 = ~7'b0001000;
            disp_3 = 7'b1111111;
        end
        4'd8 : begin 
          	disp_0 = 7'b1111111; 
          	disp_1 = ~7'b0001000;
            disp_2 = 7'b1111111;
            disp_3 = 7'b1111111;
        end
        4'd9 : begin 
          	disp_0 = ~7'b0001000; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = 7'b1111111;
        end
        4'd10 : begin 
          	disp_0 = ~7'b0000100; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = 7'b1111111;
        end
        4'd11 : begin 
          	disp_0 = ~7'b0000010; 
          	disp_1 = 7'b1111111;
            disp_2 = 7'b1111111;
            disp_3 = 7'b1111111;
        end
      endcase 
      
      counter = counter + 1;
  		
      if (counter == STOP_COUNT)
        counter <= 4'd0;
      
    end 
  
endmodule 