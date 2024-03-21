module ram(input [7:0] A, // address input  
           input [7:0] WD, // data (write) input 
           input clk, // clock signal 
           input rst, // reset 
           input WE, // write enable 
           output logic [7:0] RD // read data
           );
  
  logic [7:0] RAM [256]; 
  
  
  // Combinational READ
  assign RD = RAM [A]; 
  
  
  // Sequential WRITE
  always @ (posedge clk or negedge rst) begin 
    if(!rst) begin 
      RAM = '{ default : 4'h0 };
    end 
    else begin 
      RAM [A] <= WD;
    end   
  end 
  
endmodule 