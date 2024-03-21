`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
logic [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------

logic clk_1hz; 
logic [3:0] contador;
logic [7:0] w_rd2, w_rd1SrcA, w_SrcB; 		
				
logic [7:0] w_PC, w_Imm, w_ImmPC, w_PCn;
logic [31:0] w_Inst; 
logic [7:0] w_PCp4, w_ULAResult, w_RData, w_Wd3;
logic w_RegWrite, w_ULASrc; 
logic [2:0] w_ULAControl; 

logic [1:0] w_ImmSrc; 
logic w_ResultSrc, w_MemWrite, w_Branch, w_Zero, w_PCSrc;

logic [7:0] w_debug_reg_out [0:7];


clk_divider clk_uut(.clk_in(CLOCK_50),
						  .clk_out(clk_1hz));


// ROM 
logic [31:0] rom [0:255]; 

initial begin 
	$readmemh("hexprog.txt", rom);
end 

assign w_Inst = rom[w_PC>>2]; // Instruction memory 

assign w_PCp4 = w_PC + 4; // Get the next instruction ** Moves PC 

program_counter pc_uut(.pc_in(w_PCn), 
                       .clk(KEY[1]), 
                       .rst(KEY[3]), 
                       .pc_out(w_PC)); 
							  
control_unit ctrl_unit_uut(.op(w_Inst[6:0]),
                           .funct3(w_Inst[14:12]),
									.funct7(w_Inst[31:25]),
									.ula_control(w_ULAControl),
									.ula_src(w_ULASrc),
									.reg_write(w_RegWrite),
									.imm_src(w_ImmSrc),
									.mem_write(w_MemWrite),
									.result_src(w_ResultSrc),
									.branch(w_Branch));
									
register_file reg_file_uut(.write_data(w_Wd3),
									.write_addr(w_Inst[11:7]),
									.write_enable(w_RegWrite),
									.read_addr0(w_Inst[19:15]), 
									.read_addr1(w_Inst[24:20]),
									.clk(KEY[1]), 
									.rst(KEY[3]),
									.reg_data0(w_rd1SrcA),
									.reg_data1(w_rd2),
									.debug_reg_out(w_debug_reg_out)
									); 

ula ula_uut(.src_a(w_rd1SrcA),
			   .src_b(w_SrcB),
				.ctrl(w_ULAControl),
				.result(w_ULAResult),
				.zero(w_Zero));
				
mux_2x1 mux2_uut1(.a(w_rd2),
					 .b(w_Imm),
					 .select(w_ULASrc),
					 .c(w_SrcB));
					 
mux4x1 mux4_uut1(.in_a(w_Inst[31:20]),
					  .in_b({w_Inst[31:25],w_Inst[11:7]}),
					  .in_c({w_Inst[7], w_Inst[30:25], w_Inst[11:8], 1'b0}),
					  .in_d(),
					  .select(w_ImmSrc),
					  .out(w_Imm));

					  
assign w_ImmPC = w_PC + w_Imm; // Adder Immediate 				  
assign w_PCSrc = w_Branch & w_Zero;

ram ram_uut(.A(w_ULAResult), 
				.WD(w_rd2),
				.WE(w_MemWrite),
				.rst(KEY[3]),
				.clk(KEY[1]),
				.RD(w_RData));
				
				
mux_2x1 mux2_uut2(.a(w_ULAResult),
					 .b(w_RData),
					 .select(w_ResultSrc),
					 .c(w_Wd3));
					 
mux_2x1 mux2_uut3(.a(w_PCp4),
					 .b(w_ImmPC),
					 .select(w_PCSrc),
					 .c(w_PCn));		 
					 
// Ligacoes auxiliares 

assign w_d0x0 = w_debug_reg_out[0];
assign w_d0x1 = w_debug_reg_out[1];
assign w_d0x2 = w_debug_reg_out[2];
assign w_d0x3 = w_debug_reg_out[3];
assign w_d1x0 = w_debug_reg_out[4];
assign w_d1x1 = w_debug_reg_out[5];
assign w_d1x2 = w_debug_reg_out[6];
assign w_d1x3 = w_debug_reg_out[7];

assign w_d0x4 = w_PC;

decoder_hexseven decoder_uut(.a(w_Inst[3:0]), .out(HEX0[0:6]));
decoder_hexseven decoder_uut2(.a(w_Inst[7:4]), .out(HEX1[0:6]));
decoder_hexseven decoder_uut3(.a(w_Inst[11:8]), .out(HEX2[0:6]));
decoder_hexseven decoder_uut4(.a(w_Inst[15:12]), .out(HEX3[0:6]));
decoder_hexseven decoder_uut5(.a(w_Inst[19:16]), .out(HEX4[0:6]));
decoder_hexseven decoder_uut6(.a(w_Inst[23:20]), .out(HEX5[0:6]));
decoder_hexseven decoder_uut7(.a(w_Inst[27:24]), .out(HEX6[0:6]));
decoder_hexseven decoder_uut8(.a(w_Inst[31:28]), .out(HEX7[0:6]));

assign LEDR[0] = w_Branch;
assign LEDR[1] = w_ResultSrc;
assign LEDR[2] = w_MemWrite;
assign LEDR[5:3] = w_ULAControl;
assign LEDR[6] = w_ULASrc;
assign LEDR[7] = w_ImmSrc;
assign LEDR[8] = w_RegWrite;

endmodule
