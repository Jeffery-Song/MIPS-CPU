`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:59:10 05/12/2017 
// Design Name: 
// Module Name:    code 
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

module code(
	//input [31:0] syscallv0,
	input [15:0] data,
	input clk,
	input rst_n,
	output [7:0] segdisplay,
	output reg [3:0] segslct
	);
	reg [3:0] data_;
	reg [1:0] count;
	code4bit code4bit1(
		data_,
		segdisplay
	);
	always @(*) begin
		begin
			case (count) 
				0: begin
					data_=data[3:0];
					segslct=4'b1110;
				end
				1: begin
					data_=data[7:4];
					if(data[15:12]==0 && data[11:8]==0 && data[7:4]==0)
						segslct=4'b1111;
					else
						segslct=4'b1101;
				end
				2: begin
					data_=data[11:8];
					if(data[15:12]==0 && data[11:8]==0)
						segslct=4'b1111;
					else
						segslct=4'b1011;
				end
				3: begin
					data_=data[15:12];
					if(data[15:12]==0)
						segslct=4'b1111;
					else
						segslct=4'b0111;
				end
			endcase
		end
	end
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) count<=0;
		else count<=count+1;
	end
		
endmodule

