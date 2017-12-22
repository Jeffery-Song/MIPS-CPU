`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:27:48 05/11/2017 
// Design Name: 
// Module Name:    Hazard 
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
module Hazard(
	input ID_EX_MemRead,
	input [4:0] Rs,
	input [4:0] Rt,
	input [4:0] ID_EX_Rt,
	input [5:0] Opcode,
	input [5:0] Funct,
	output reg Hazard,
	output reg PCWrite,
	//output reg InsSrc,
	output reg IRWrite,
	output reg HazardPCSrc
    );
	always @(*) begin
		if(ID_EX_MemRead && ((Rs==ID_EX_Rt)||(Rt==ID_EX_Rt))||(Opcode==0 && Funct==6'b001100 && ID_EX_Rt==2)) begin
			Hazard=0;
			PCWrite=0;
			//InsSrc=1;
			IRWrite=0;
			HazardPCSrc=1;
		end
		else begin
			Hazard=1;
			PCWrite=1;
			//InsSrc=0;
			IRWrite=1;
			HazardPCSrc=0;
		end
	end

endmodule
