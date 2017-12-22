`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:46 04/16/2017 
// Design Name: 
// Module Name:    top 
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
module top(
	input clk_,
	input rst_n,
	input printhl,
	input [5:0] swaddr,
	output [7:0] printsig,
	output [3:0] segslct
   );
	wire [5:0] datamemaddr=M_WB_syscallprint?swaddr:EX_M_ALURst[7:2];
	reg PCSrcreg;
	reg Jumpreg;
	
	//reg [15:0] printlow;
	//reg [15:0] printhigh;
	wire clk;
	wire PCSrc;
	reg [31:0] PCnormal;
	wire [31:0] nPC=PC+4;
	wire [31:0] AddRst;
	wire [31:0] PC_=PCSrc?AddRst:nPC;
	wire [5:0] PCshr=PC[7:2];
	//wire [31:0] instruction;
	wire JumpaddrSrc;
	wire [31:0] Jumpaddr=JumpaddrSrc?EX_M_ALURst:EX_M_Jmpaddr;
	wire [31:0] PC__=Jump?Jumpaddr:PC_;
	wire PCWrite;
	//wire InsSrc_;
	//reg InsSrc;
	//wire [31:0] insdata;
	//reg [31:0] insreg;
	//assign instruction=InsSrc?insreg:insdata;
	reg [31:0] instruction;
	wire [31:0] instruction_;
	wire IRWrite;
	reg [31:0] HazardPC;
	wire HazardPCSrc;
	wire [31:0] PC=HazardPCSrc?HazardPC:PCnormal;
	
	reg [31:0] IF_ID_nPC;
	
	wire [4:0] wregaddr;
	wire [31:0] wregdata;
	wire [31:0] rd1;
	wire [31:0] rd2;
	wire [31:0] signext;
	wire RegWrite;
	assign signext[15:0]=instruction[15:0];
	assign signext[31:16]=16'h0000-instruction[15];
	wire JumpaddrSrc_;
	wire Jump_;
	wire RegDst_;
	wire Branch_;
	wire MemtoReg_;
	wire MemWrite_;
	wire ALUSrc_;
	wire [2:0] ALUOp_;
	wire RegWrite_;
	//wire [1:0] PCSrc_;
	wire MemRead_;
	wire Hazard;
	
	//reg [4:0] readregaddr1;
	//reg [4:0] readregaddr2;
	
	reg [31:0] ID_EX_nPC;
	reg [4:0] ID_EX_EX;
	reg [4:0] ID_EX_M;//4JumpaddrSrc 3JUmp
	reg [1:0] ID_EX_WB;
	reg [31:0] ID_EX_signext;
	reg [4:0] ID_EX_ins2521;//rs
	reg [4:0] ID_EX_ins2016;//rt
	reg [4:0] ID_EX_ins1511;//rd
	reg ID_EX_ins27;//bne ot bgtz
	reg [2:0] ID_EX_Op;
	reg [31:0] ID_EX_Jmpaddr;
	reg syscallprint;
	
	wire RegDst=ID_EX_EX[4];
	wire ALUSrc=ID_EX_EX[0];
	wire [2:0] ALUOp=ID_EX_EX[3:1];
	wire [4:0] RegDstRst=RegDst?ID_EX_ins1511:ID_EX_ins2016;
	wire [3:0] ALUControl;
	wire [31:0] ALUb=ALUSrc?ID_EX_signext:ALUb1;
	wire [31:0] signextshl;
	assign signextshl[31:2]=ID_EX_signext[29:0];
	assign signextshl[1:0]=2'b00;
	wire [31:0] PCaddrst;
	assign PCaddrst=ID_EX_nPC + signextshl;
	wire zero_;
	wire sign_;
	wire overflow_;
	wire [31:0] ALURst;
	wire [1:0] ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [31:0] ALUa1=ALUSrcA[0]?wregdata:rd1;
	wire [31:0] ALUa=ALUSrcA[1]?EX_M_ALURst:ALUa1;
	wire [31:0] ALUb11=ALUSrcB[0]?wregdata:rd2;
	wire [31:0] ALUb1=ALUSrcB[1]?EX_M_ALURst:ALUb11;
	
	wire ID_EX_MemRead=ID_EX_M[2];
	//reg [15:0] numtoprintlow;
	//reg [15:0] numtoprinthigh;
	//wire [15:0] numtoprint=printhl?numtoprinthigh:numtoprintlow;
	wire [15:0] numtoprint=printhl?memdata[31:16]:memdata[15:0];
	//wire [3:0] segslct;
	
	reg [1:0] EX_M_WB;
	reg [4:0] EX_M_M;
	reg [31:0] EX_M_PC;
	reg [2:0] EX_M_ALUSig;
	reg [31:0] EX_M_ALURst;
	reg [31:0] EX_M_rd2;
	reg [4:0] EX_M_RegDst;
	reg EX_M_ins27;
	reg [31:0] EX_M_Jmpaddr;
	reg EX_M_syscallprint;
	
	wire Jump=EX_M_M[3];
	assign JumpaddrSrc=EX_M_M[4];
	assign AddRst=EX_M_PC;
	wire MemWrite=EX_M_M[0];
	wire Branch=EX_M_M[1];
	wire zero=EX_M_ALUSig[0];
	wire sign=EX_M_ALUSig[1];
	assign PCSrc=Branch & ~zero & (~EX_M_ins27 | sign);
	wire [31:0] memdata;
	
	reg [1:0] M_WB_WB;
	reg [31:0] M_WB_ALURst;
	reg [4:0] M_WB_RegDst;
	reg M_WB_syscallprint;
	
	wire MemtoReg=M_WB_WB[0];
	assign RegWrite=M_WB_WB[1];
	assign wregaddr=M_WB_RegDst;
	assign wregdata=MemtoReg?memdata:M_WB_ALURst;
	
	
	Hazard Hazard1 (
		.ID_EX_MemRead(ID_EX_MemRead), 
		.Rs(instruction[25:21]), 		/////
		.Rt(instruction[20:16]), //////////
		.ID_EX_Rt(ID_EX_ins2016), 
		.Opcode(instruction[31:26]),
		.Funct(instruction[5:0]),
		.Hazard(Hazard), 
		.PCWrite(PCWrite), 
		//.InsSrc(InsSrc_),
		.IRWrite(IRWrite),
		.HazardPCSrc(HazardPCSrc)
	);
	
	Forwarding Forwarding1 (
		.ID_EX_Rs(ID_EX_ins2521), 
		.ID_EX_Rt(ID_EX_ins2016), 
		.EX_M_RegDst(EX_M_RegDst), 
		.M_WB_RegDst(M_WB_RegDst), 
		.EX_M_RegWrite(EX_M_WB[1]), 
		.M_WB_RegWrite(M_WB_WB[1]), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB)
	);
		
	IM1 IM11 (
		.clka(clk), 
		.addra(PCshr), 
		.douta(instruction_)
	);
	
	ram ram1 (
		.clka(clk), 
		.wea(MemWrite), 
		//.addra(EX_M_ALURst[7:2]), 
		.addra(datamemaddr), 
		.dina(EX_M_rd2), 
		.douta(memdata)
	);
	
	regfile regfile1 (
		clk,
		rst_n,
		instruction[25:21],////////
		instruction[20:16],////////
		wregaddr,
		wregdata,
		RegWrite,
		rd1,
		rd2
	);
	
	control control1(
		instruction[5:0],
		instruction[31:26],
	//	clk,
	//	rst_n,
		RegDst_,
		Branch_,
		MemtoReg_,
		MemWrite_,
		ALUSrc_,
		ALUOp_,
		RegWrite_,
	//	PCSrc_,
		Jump_,
		MemRead_,
		JumpaddrSrc_
	);
	aluctr aluctr1 (
		ALUOp,
		ID_EX_signext[3:0],
		ID_EX_Op,
		ALUControl
	);
	myalu myalu1 (
		ALUa,
		ALUb,
		ALUControl,
		ALURst,
		zero_,
		overflow_,
		sign_
    ); 
	code code1(
		numtoprint,
		clk,
		rst_n,
		printsig,
		segslct
	);
	div div1(
		clk_,
		rst_n,
		clk
   );
	always @(posedge clk or negedge rst_n) begin
		//insreg<=insdata; 
		if(~rst_n) begin
			PCnormal<=0;
			instruction<=0;
			HazardPC<=0;
			//InsSrc<=0;
		end
		else begin
			//InsSrc<=InsSrc_;
			HazardPC<=PCnormal;
			//if(PCWrite & ~M_WB_syscallprint)
			if(PCWrite)
				PCnormal<=PC__;
			if(PCSrc | Jump | PCSrcreg | Jumpreg | M_WB_syscallprint)
				instruction<=0;
			else if(IRWrite)
			//else if(IRWrite & ~M_WB_syscallprint)
				instruction<=instruction_;
		end
	end
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) IF_ID_nPC<=0;
		else
			IF_ID_nPC<=PC;
	end
	
	always @(posedge clk) begin
		ID_EX_Jmpaddr[1:0]=2'b00;
	end
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ID_EX_signext<=0;
			ID_EX_ins2521<=0;
			ID_EX_ins2016<=0;
			ID_EX_ins1511<=0;
			ID_EX_ins27<=0;
			ID_EX_EX[0]<=0;
			ID_EX_EX[3:1]<=0;
			ID_EX_EX[4]<=0;
			//ID_EX_EX[5]<=0;
			ID_EX_M[0]<=0;
			ID_EX_M[1]<=0;
			ID_EX_M[2]<=0;
			ID_EX_M[3]<=0;
			ID_EX_M[4]<=0;
			ID_EX_WB[0]<=0;
			ID_EX_WB[1]<=0;
			ID_EX_nPC<=0;
			ID_EX_Op<=0;
			ID_EX_Jmpaddr[31:2]<=0;
			syscallprint<=0;
		end
		else begin
			ID_EX_signext<=signext;
			ID_EX_ins2521<=instruction[25:21];
			ID_EX_ins2016<=instruction[20:16];
			ID_EX_ins1511<=instruction[15:11];
			ID_EX_ins27<=instruction[27];
			if(~Hazard | PCSrc | Jump | PCSrcreg | Jumpreg) 
			begin
				ID_EX_EX<=0;
				ID_EX_M<=0;
				ID_EX_WB<=0;
			end 
			else begin
				ID_EX_EX[0]<=ALUSrc_;
				ID_EX_EX[3:1]<=ALUOp_;
				ID_EX_EX[4]<=RegDst_;
				//ID_EX_EX[5]<=Jump_;
				ID_EX_M[0]<=MemWrite_;
				ID_EX_M[1]<=Branch_;
				ID_EX_M[2]<=MemRead_;
				ID_EX_M[3]<=Jump_;
				ID_EX_M[4]<=JumpaddrSrc_;
				ID_EX_WB[0]<=MemtoReg_;
				ID_EX_WB[1]<=RegWrite_;
			end
			ID_EX_nPC<=IF_ID_nPC;
			ID_EX_Op<=instruction[28:26];
			ID_EX_Jmpaddr[27:2]<=instruction[25:0];
			ID_EX_Jmpaddr[31:28]<=nPC[31:28];
			if(instruction[31:25]==0 && instruction[5:0]==6'b001100)
				syscallprint<=1;
			else syscallprint<=0;
		end
	end
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			EX_M_RegDst<=0;
			EX_M_WB<=0;
			EX_M_M<=0;
			EX_M_PC<=0;
			EX_M_ALUSig[0]<=0;
			EX_M_ALUSig[1]<=0;
			EX_M_ALUSig[2]<=0;
			EX_M_ALURst<=0;
			EX_M_rd2<=0;
			EX_M_ins27<=0;
			EX_M_Jmpaddr<=0;
			EX_M_syscallprint<=0;
		end
		else begin
			EX_M_RegDst<=RegDstRst;
			if( PCSrc | Jump  | PCSrcreg | Jumpreg) begin
				EX_M_WB<=0;
				EX_M_M<=0;
			end
			else begin
				EX_M_WB<=ID_EX_WB;
				EX_M_M<=ID_EX_M;
			end
			EX_M_PC<=PCaddrst;
			EX_M_ALUSig[0]<=zero_;
			EX_M_ALUSig[1]<=sign_;
			EX_M_ALUSig[2]<=overflow_;
			EX_M_ALURst<=ALURst;
			EX_M_rd2<=ALUb1;
			EX_M_ins27<=ID_EX_ins27;
			EX_M_Jmpaddr<=ID_EX_Jmpaddr;
			EX_M_syscallprint<=syscallprint;
		end
	end
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin 
			M_WB_WB<=0;
			M_WB_ALURst<=0;
			M_WB_RegDst<=0;
			M_WB_syscallprint<=0;
		end 
		else begin
			M_WB_WB<=EX_M_WB;
			M_WB_ALURst<=EX_M_ALURst;
			M_WB_RegDst<=EX_M_RegDst;
			if(~M_WB_syscallprint) 
				M_WB_syscallprint<=EX_M_syscallprint;
			else M_WB_syscallprint<=1;
		end
	end
	/*
	always @(*) begin
		printlow = memdata % 10000;
		printhigh = memdata / 10000;
	end
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			numtoprintlow<=0;
			numtoprinthigh<=0;
		end
		else begin
			numtoprintlow<=printlow[13:0];
			numtoprinthigh<=printhigh[13:0];
		end
	
	end
	*/
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			PCSrcreg<=0;
			Jumpreg<=0;
		end
		else begin
			PCSrcreg<=PCSrc;
			Jumpreg<=Jump;
		end
	end
endmodule
