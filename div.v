`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:03:11 05/12/2017 
// Design Name: 
// Module Name:    div 
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
module div(
	input clk_,
	input rst_n,
	output reg clk
   );
	reg [24:0] cnt_div;
	always @(posedge clk_ or negedge rst_n) begin
		if (~rst_n) 
			cnt_div<=10'd0;
		else if(cnt_div==10'd499)
			cnt_div<=0;
		else 
			cnt_div<=cnt_div+1;
	end
	always @(posedge clk_ or negedge rst_n) begin
		if(~rst_n)
			clk<=0;
		else if(cnt_div==10'd499)
			clk<=~clk;
	end

endmodule
