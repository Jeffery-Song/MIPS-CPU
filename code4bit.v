`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:52 05/12/2017 
// Design Name: 
// Module Name:    code4bit 
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
module code4bit(
	input [3:0] cnt_data,
	output reg [7:0] data
	);
	always@(*)
	begin
		case(cnt_data)
			4'h0:	data=8'b11000000;
			4'h1:	data=8'b11111001;
			4'h2:	data=8'b10100100;
			4'h3:	data=8'b10110000;
			4'h4:	data=8'b10011001;
			4'h5:	data=8'b10010010;
			4'h6:	data=8'b10000010;
			4'h7:	data=8'b11111000;
			4'h8:	data=8'b10000000;
			4'h9:	data=8'b10010000;
			4'ha: data=8'b10001000;
			4'hb: data=8'b10000011;
			4'hc: data=8'b10100111;
			4'hd: data=8'b10100001;
			4'he: data=8'b10000110;
			4'hf: data=8'b10001110;
		endcase
	end
endmodule
