`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:22:03 04/30/2017 
// Design Name: 
// Module Name:    aluctr 
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
module aluctr(
	input [2:0] ALUOp,
	input [3:0] Funct,
	input [2:0] Opcode,
	output reg [3:0] ALUControl
    );
	always @(*) begin
		if(ALUOp==2'b00)
			ALUControl=0;		//add
		else if(ALUOp==2'b01)
			ALUControl=4'b0010;		//bne,sub
		else if(ALUOp==2'b10)
			ALUControl=Funct;	//rtype
		else if(ALUOp==2'b11) begin
			ALUControl[2:0]=Opcode;		//imm
			ALUControl[3]=0;
		end
		else if(ALUOp==3'b100)
			ALUControl=8;//bgtz
		else ALUControl=0;
	end

endmodule
