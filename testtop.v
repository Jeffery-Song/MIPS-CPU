`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:59:46 05/12/2017
// Design Name:   top
// Module Name:   D:/verilog/lab7-restart/testtop.v
// Project Name:  lab7-restart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testnewtop;

	// Inputs
	reg clk;
	reg rst_n;
	reg printhl;
	reg [5:0] swaddr;
	wire [7:0] printsig;
	wire [3:0] segslct;
	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk_(clk),
		.rst_n(rst_n),
		.printhl(printhl),
		.swaddr(swaddr),
		.printsig(printsig),
		.segslct(segslct)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		printhl = 0;
		swaddr=2;
		// Wait 100 ns for global reset to finish
		#3;
      rst_n = 1;
		// Add stimulus here

	end
   always @(*) begin
		forever #1 clk=~clk;
		end
endmodule

