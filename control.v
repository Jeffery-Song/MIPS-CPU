`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:15:36 03/27/2017 
// Design Name: 
// Module Name:    control 
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

module control(
	input [5:0] Funct,
	input [5:0] Opcode,
	//input clk,
	//input rst_n,
	output reg RegDst,
	output reg Branch,
	output reg MemtoReg,
	output reg MemWrite,
	output reg ALUSrc,
	output reg [2:0] ALUOp,
	output reg RegWrite,
	//output reg [1:0] PCSrc,
	output reg Jump,
	output reg MemRead,
	output reg JumpaddrSrc
	);
	reg [3:0] current_state;
	reg [3:0] next_state;
	parameter rtype=6'b000000;
	parameter lw=6'b100011;
	parameter sw=6'b101011;
	parameter bgtz=6'b000111;
	parameter bne=6'b000101;
	parameter addi=6'b001000;
	parameter andi=6'b001100;
	parameter j=6'b000010;
	parameter addiu=6'b001001;
	parameter subi=6'b001010;
	parameter subiu=6'b001011;
	parameter ori=6'b001101;
	parameter xori=6'b001110;
	always @(*)
	begin
		case(Opcode)
			lw: begin
					//PCSrc=2'b00;
				
				RegDst=0;
				ALUOp=3'b000;	//add
				ALUSrc=1;
				Jump=0;
					JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
				
				RegWrite=1;
				MemtoReg=1;
				MemRead=1;
			end
			sw: begin
					//PCSrc=2'b00;
				
				RegDst=0;
					ALUOp=3'b000;	//add
				ALUSrc=1;
				Jump=0;
					JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=1;
				
				RegWrite=0;
				MemtoReg=0;
				MemRead=0;
			end
			bne: begin
					//PCSrc=2'b00;
				
				RegDst=0;
					ALUOp=3'b001;	//bne,sub
				ALUSrc=0;
				Jump=0;
					JumpaddrSrc=0;
				
				Branch=1;
				MemWrite=0;
				
				RegWrite=0;
				MemtoReg=0;
				MemRead=0;
			end
			bgtz: begin
					//PCSrc=2'b00;
				
				RegDst=0;
					ALUOp=3'b100;	//bgtz
				ALUSrc=0;
				Jump=0;
					JumpaddrSrc=0;
				
				Branch=1;
				MemWrite=0;
				
				RegWrite=0;
				MemtoReg=0;
				MemRead=0;
			end
			rtype: begin
				if(Funct==8) begin	//jr
						//PCSrc=2'b00;
				
					RegDst=0;
						ALUOp=3'b000;	//add
					ALUSrc=0;
					Jump=1;
					JumpaddrSrc=1;
					Branch=0;
					MemWrite=0;
				
					RegWrite=0;
					MemtoReg=0;
					MemRead=0;
				end
				else if(Funct==6'b001100) begin	//syscall
						//PCSrc=2'b00;
				
					RegDst=0;
						ALUOp=3'b000;	//add
					ALUSrc=0;
					Jump=0;
					JumpaddrSrc=0;
					Branch=0;
					MemWrite=0;
				
					RegWrite=0;
					MemtoReg=0;
					MemRead=0;
				end
				else begin	//rtype
						//PCSrc=2'b00;
				
					RegDst=1;
						ALUOp=3'b010;	//funct
					ALUSrc=0;
					Jump=0;
					JumpaddrSrc=0;
				
					Branch=0;
					MemWrite=0;
				
					RegWrite=1;
					MemtoReg=0;
					MemRead=0;
				end
			end
			andi: begin
					//PCSrc=2'b00;
				
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			addi: begin
					//PCSrc=2'b00;
				
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			addiu: begin
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			subi: begin
			
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			subiu:begin
			
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			ori: begin
			
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			xori:begin
			
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=1;
				Jump=0;
				JumpaddrSrc=0;
				
				Branch=0;
				MemWrite=0;
			
				RegWrite=1;
				MemtoReg=0;
				MemRead=0;
			end
			j: begin
					//PCSrc=2'b00;
				
				RegDst=0;
					ALUOp=3'b011;	//imm
				ALUSrc=0;
				Jump=1;
				JumpaddrSrc=0;
				Branch=0;
				MemWrite=0;
			
				RegWrite=0;
				MemtoReg=0;
				MemRead=0;
			end
			default: begin
				
				RegDst=0;
					ALUOp=3'b000;	//imm
				ALUSrc=0;
				Jump=0;
				JumpaddrSrc=0;
				Branch=0;
				MemWrite=0;
			
				RegWrite=0;
				MemtoReg=0;
				MemRead=0;
			end
				//ALUOp=3'b010;		//funct
				//ALUOp=3'b001;		//bne,sub
				//wusuowei
				//ALUOp=3'b100;		//bgtz,
				//001000 addi,001100 andi
		endcase
	end
endmodule
