`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:03 05/10/2017 
// Design Name: 
// Module Name:    Forwarding 
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
module Forwarding(
	input [4:0] ID_EX_Rs,
	input [4:0] ID_EX_Rt,
	input [4:0] EX_M_RegDst,
	input [4:0] M_WB_RegDst,
	input EX_M_RegWrite,
	input M_WB_RegWrite,
	output reg [1:0] ALUSrcA,
	output reg [1:0] ALUSrcB
   );
	//if EX_M regwrite 1,check regdst
	always @(*) begin
		if(EX_M_RegWrite && (ID_EX_Rs==EX_M_RegDst)) 
			ALUSrcA=2'b10;
		else if(M_WB_RegWrite && (ID_EX_Rs==M_WB_RegDst)) 
			ALUSrcA=2'b01;
		else ALUSrcA=2'b00;
		
		if(EX_M_RegWrite && (ID_EX_Rt==EX_M_RegDst)) 
			ALUSrcB=2'b10;
		else if(M_WB_RegWrite && (ID_EX_Rt==M_WB_RegDst)) 
			ALUSrcB=2'b01;
		else ALUSrcB=2'b00;
	end


endmodule
