`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:25 03/27/2017 
// Design Name: 
// Module Name:    regfile 
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
module regfile(
	input	clk,
	input	rst_n,
	input	[4:0]	r1_addr,
	input	[4:0]	r2_addr,
	input	[4:0]	r3_addr,
	input	[31:0] r3_din,
	input	r3_wr,
	output reg [31:0] r1_dout,
	output reg [31:0] r2_dout
	);
	reg [31:0] regs [0:31];
	
	always @(posedge clk) 
		begin
			if(r3_wr && (r1_addr==r3_addr))
				r1_dout<=r3_din;
			else
				r1_dout<=regs[r1_addr];
			if(r3_wr && (r2_addr==r3_addr))
				r2_dout<=r3_din;
			else
				r2_dout<=regs[r2_addr];
		end
	
	//assign r1_dout=regs[r1_addr];
	//assign r2_dout=regs[r2_addr];
	always @(posedge clk or negedge rst_n)
		begin
			if(~rst_n)
				begin
					regs[0]<=0;
					regs[1]<=0;
					regs[2]<=0;
					regs[3]<=0;
					regs[4]<=0;
					regs[5]<=0;
					regs[6]<=0;
					regs[7]<=0;
					regs[8]<=0;
					regs[9]<=0;
					regs[10]<=0;
					regs[11]<=0;
					regs[12]<=0;
					regs[13]<=0;
					regs[14]<=0;
					regs[15]<=0;
					regs[16]<=0;
					regs[17]<=0;
					regs[18]<=0;
					regs[19]<=0;
					regs[20]<=0;
					regs[21]<=0;
					regs[22]<=0;
					regs[23]<=0;
					regs[24]<=0;
					regs[25]<=0;
					regs[26]<=0;
					regs[27]<=0;
					regs[28]<=0;
					regs[29]<=0;
					regs[30]<=0;
					regs[31]<=0;
				end
			else if(r3_wr)
				begin
					regs[r3_addr]<=r3_din;
				end
		end

endmodule 


