`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:34 03/27/2017 
// Design Name: 
// Module Name:    myalu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module myalu(
	input [31:0] alu_a,
	input [31:0] alu_b,
	input [3:0] alu_op,
	output [31:0] alu_out,
	output reg zero,
	output reg overflow,
	output reg sign
    );
	reg [32:0] alu_rst;
	wire [32:0] alu_a1;
	assign alu_a1[31:0]=alu_a;
	assign alu_a1[32]=0;
	wire [32:0] alu_b1;
	assign alu_b1[31:0]=alu_b;
	assign alu_b1[32]=0;
	
	assign alu_out=alu_rst[31:0];
	
	parameter A_ADD=4'h00;
	parameter A_ADDu=4'h01;
	parameter A_SUB=4'h02;
	parameter A_SUBu=4'h03;
	parameter A_AND=4'h04;
	parameter A_OR=4'h05;
	parameter A_XOR=4'h06;
	parameter A_NOR=4'h07;
	parameter A_BGTZ=4'h08;
	always @(*)
		begin
				case(alu_op)
					A_ADD:	begin
						alu_rst=alu_a1 + alu_b1;
						overflow = (~alu_a[31] & ~alu_b[31] & alu_rst[31]) | (alu_a[31] & alu_b[31] & ~alu_rst[31]);
						sign=~alu_rst[31];
					end
					A_ADDu:	begin
						alu_rst=alu_a1 + alu_b1;
						overflow=alu_rst[32];
						sign=1;
					end
					A_SUB:	begin
						alu_rst=alu_a1 - alu_b1;
						overflow=(~alu_a[31] & alu_b[31] & alu_rst[31]) | (alu_a[31] & ~alu_b[31] & ~alu_rst[31]);
						sign=~alu_rst[31];
					end
					A_SUBu:	begin
						alu_rst=alu_a1 - alu_b1;
						sign=1;
						overflow=alu_rst[32];
					end
					A_AND:	begin
						alu_rst=alu_a1 & alu_b1;
						sign=~alu_rst[31];
						overflow=0;
					end
					A_OR:		begin
						alu_rst=alu_a1 | alu_b1;
						sign=~alu_rst[31];
						overflow=0;
					end
					A_XOR:	begin
						alu_rst=(~alu_a1 & alu_b1)|(alu_a1 & ~alu_b1);
						sign=~alu_rst[31];
						overflow=0;
					end
					A_NOR:	begin
						alu_rst=~(alu_a1 | alu_b1);
						sign=~alu_rst[31];
						overflow=0;
					end
					A_BGTZ:	begin
						alu_rst=alu_a1;
						sign=~alu_rst[31];
						overflow=0;
					end
					default: begin
						alu_rst=0;
						sign=~alu_rst[31];
						overflow=0;
					end
				endcase
		end
	always @(*)
		begin
			if(alu_out==0) zero=1;
			else zero=0;
		end
endmodule
