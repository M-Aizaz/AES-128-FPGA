`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:05:36 02/25/2023
// Design Name:   AES_encrypty
// Module Name:   D:/PAF/Project/AES-encrpty/sti.v
// Project Name:  AES-encrpty
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AES_encrypty
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sti;

	// Inputs
	reg clk;
	reg [7:0] data;
	reg [7:0] key;

	// Outputs
	wire [7:0] chiper;

	// Instantiate the Unit Under Test (UUT)
	AES_encrypty uut (
		.clk(clk), 
		.data(data), 
		.key(key), 
		.chiper(chiper)
	);
always #5 clk=~clk;
	initial begin
	clk = 0;
	#0 data = 8'h32; key = 8'h2b;
	#10 data = 8'h88; key = 8'h28;
	#10 data = 8'h31; key = 8'hAB;
	#10 data = 8'hE0; key = 8'h09;	

	#10 data = 8'h43; key = 8'h7E;
	#10 data = 8'h5A; key = 8'hAE;
	#10 data = 8'h31; key = 8'hF7;
	#10 data = 8'h37; key = 8'hCF;

	#10 data = 8'hF6; key = 8'h15;
	#10 data = 8'h30; key = 8'hD2;
	#10 data = 8'h98; key = 8'h15;
	#10 data = 8'h07; key = 8'h4F;	

	#10 data = 8'hA8; key = 8'h16;
	#10 data = 8'h8D; key = 8'hA6;
	#10 data = 8'hA2; key = 8'h88;
	#10 data = 8'h34; key = 8'h3C;	
		// Initialize Inputs
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

