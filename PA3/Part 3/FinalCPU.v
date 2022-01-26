/*
 *	Template for Project 3 Part 3
 *	Copyright (C) 2021  Lee Kai Xuan or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module FinalCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk, PCWrite
);

	wire [31:0]Instr, InstrOut, RsData, RtData, ID_EX_RsData, ID_EX_RtData, ID_EX_Sign, ALU_inputA, ALU_inputB, MemReadData;
	wire [31:0]EX_MEM_Result, ForwardB_Out, EX_MEM_RtData, MEM_WB_MemReadData, MEM_WB_Result, RdData, SignOut, Result; 
	wire [5:0]Funct1;
	wire [4:0]ID_EX_RtAddr, ID_EX_RdAddr, ID_EX_RsAddr, mux_RdAddr_out, MEM_WB_RdAddr;
	wire [4:0]EX_MEM_RdAddr;
	wire IF_ID_Write, hazard;
	wire [1:0]ALUOp_Control_mux, ALUOp, ID_EX_ALUOp, ForwardA, ForwardB;
	wire RegDst_Control_mux, RegWrite_Control_mux, ALUSrc_Control_mux, MemWrite_Control_mux, MemRead_Control_mux, MemtoReg_Control_mux;
	wire RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg;
	wire ID_EX_RegWrite, ID_EX_RegDst, ID_EX_ALUSrc, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_MemtoReg;
	wire EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_MemRead;
	wire MEM_WB_RegWrite, MEM_WB_MemtoReg;
	wire Carry, Zero;
	
	
	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory
	(
		// Outputs
		.Instr(Instr),
		// Inputs
		.InstrAddr(AddrIn)
	);

	Adder Adder
	(	
		// Outputs
		.AddrOut(AddrOut),
		// Inputs
		.AddrIn(AddrIn)
	);

	IF_ID IF_ID
	(
		// Outputs
		.InstrOut(InstrOut),
		// Inputs
		.InstrIn(Instr),
		.IF_ID_Write(IF_ID_Write),
		.clk(clk)
	);
	
	HazardDetection HazardDetection
	(
		// Outputs
		.hazard(hazard),
		.IF_ID_Write(IF_ID_Write),
		.PCWrite(PCWrite),
		// Inputs
		.ID_EX_MemRead(ID_EX_MemRead),
		.ID_EX_RtAddr(ID_EX_RtAddr),
		.IF_ID_RsAddr(InstrOut[25:21]),
		.IF_ID_RtAddr(InstrOut[20:16])
	);
	
	mux_Control mux_Control
	(
		// Outputs
		.ALUOp_Control_mux(ALUOp_Control_mux),
		.RegDst_Control_mux(RegDst_Control_mux),
		.RegWrite_Control_mux(RegWrite_Control_mux),
		.ALUSrc_Control_mux(ALUSrc_Control_mux),
		.MemWrite_Control_mux(MemWrite_Control_mux),
		.MemRead_Control_mux(MemRead_Control_mux),
		.MemtoReg_Control_mux(MemtoReg_Control_mux),
		// Inputs
		.ALUOp(ALUOp),
		.RegDst(RegDst),
		.RegWrite(RegWrite),
		.ALUSrc(ALUSrc),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.hazard_control(hazard)
	);
	
	Control Control
	(
		// Inputs
		.OpCode(InstrOut[31:26]),
		// Outputs
		.RegWrite(RegWrite),
		.MemtoReg(MemtoReg),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.RegDst(RegDst),
		.ALUOp(ALUOp),
		.ALUSrc(ALUSrc)
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File
	(
		// Outputs
		.RsData(RsData),
		.RtData(RtData),
		// Inputs
		.RsAddr(InstrOut[25:21]),
		.RtAddr(InstrOut[20:16]),
		.RdAddr(MEM_WB_RdAddr),
		.RdData(RdData),
		.RegWrite(MEM_WB_RegWrite),
		.clk(clk)
	);
	
	ID_EX ID_EX
	(
		// Outputs
		.ALUOpOut(ID_EX_ALUOp),
		.RegWriteOut(ID_EX_RegWrite),
		.RegDstOut(ID_EX_RegDst),
		.ALUSrcOut(ID_EX_ALUSrc),
		.MemWriteOut(ID_EX_MemWrite),
		.MemReadOut(ID_EX_MemRead),
		.MemtoRegOut(ID_EX_MemtoReg),
		.RsDataOut(ID_EX_RsData),
		.RtDataOut(ID_EX_RtData),
		.SignOut(ID_EX_Sign),
		.RtAddrOut(ID_EX_RtAddr),
		.RdAddrOut(ID_EX_RdAddr),
		.RsAddrOut(ID_EX_RsAddr),
		// Inputs
		.ALUOp(ALUOp_Control_mux),
		.RegDst(RegDst_Control_mux),
		.RegWrite(RegWrite_Control_mux),
		.ALUSrc(ALUSrc_Control_mux),
		.MemWrite(MemWrite_Control_mux),
		.MemRead(MemRead_Control_mux),
		.MemtoReg(MemtoReg_Control_mux),
		.RsData(RsData),
		.RtData(RtData),
		.signextend(InstrOut[15:0]),
		.RsAddr(InstrOut[25:21]),
		.RtAddr(InstrOut[20:16]),
		.RdAddr(InstrOut[15:11]),
		.clk(clk)
	);
	
	mux_ForwardA mux_ForwardA
	(
		// Outputs
		.ALU_input(ALU_inputA),
		// Inputs
		.RsData(ID_EX_RsData),
		.RdData_forward(RdData),
		.ALU_Result_forward(EX_MEM_Result),
		.forwarding(ForwardA)
	);
	
	mux_ForwardB mux_ForwardB
	(
		// Outputs
		.ALU_mux_input(ForwardB_Out),
		// Inputs
		.RtData(ID_EX_RtData),
		.RdData_forward(RdData),
		.ALU_Result_forward(EX_MEM_Result),
		.forwarding(ForwardB)
	);
	
	mux32_bits_ALU mux32_bits_ALU
	(
		// Outputs
		.ALU_input(ALU_inputB),
		// Inputs
		.ForwardB_out(ForwardB_Out),
		.signextend(ID_EX_Sign),
		.ALUSrc(ID_EX_ALUSrc)
	);
	
	ALU ALU
	(
		// Inputs
		.Src1(ALU_inputA),
		.Src2(ALU_inputB),
		.Shamt(ID_EX_Sign[10:6]),
		.Funct1(Funct1),
		// Outputs
		.Result(Result),
		.Zero(Zero),
		.Carry(Carry)
	);
	
	ALU_Control ALU_Control
	(
		// Inputs
		.funct(ID_EX_Sign[5:0]),
		.ALUOp(ID_EX_ALUOp),
		// Outputs
		.Funct1(Funct1)
	);
	
	mux5_bits_RF mux5_bits_RF
	(
		// Outputs
		.RdAddr(mux_RdAddr_out),
		// Inputs
		.Instr20_16(ID_EX_RtAddr),
		.Instr15_11(ID_EX_RdAddr),
		.RegDst(ID_EX_RegDst)
	);
	
	ForwardUnit ForwardUnit
	(
		// Outputs
		.ForwardA(ForwardA),
		.ForwardB(ForwardB),
		// Inputs
		.ID_EX_RsAddr(ID_EX_RsAddr),
		.ID_EX_RtAddr(ID_EX_RtAddr),
		.EX_MEM_RdAddr(EX_MEM_RdAddr),
		.MEM_WB_RdAddr(MEM_WB_RdAddr),
		.EX_MEM_RegWrite(EX_MEM_RegWrite),
		.MEM_WB_RegWrite(MEM_WB_RegWrite)
	);
	
	EX_MEM EX_MEM
	(
		// Outputs
		.RegWriteOut(EX_MEM_RegWrite),
		.MemtoRegOut(EX_MEM_MemtoReg),
		.MemWriteOut(EX_MEM_MemWrite),
		.MemReadOut(EX_MEM_MemRead),
		.ResultOut(EX_MEM_Result),
		.RtDataOut(EX_MEM_RtData),
		.MuxOut(EX_MEM_RdAddr),
		// Inputs
		.RegWrite(ID_EX_RegWrite),
		.MemtoReg(ID_EX_MemtoReg),
		.MemWrite(ID_EX_MemWrite),
		.MemRead(ID_EX_MemRead),
		.Result(Result),
		.RtData(ForwardB_Out),
		.MuxIn(mux_RdAddr_out),
		.clk(clk)
	);
		
	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory
	(
		// Outputs
		.MemReadData(MemReadData),
		// Inputs
		.MemAddr(EX_MEM_Result),
		.MemWriteData(EX_MEM_RtData),
		.MemWrite(EX_MEM_MemWrite),
		.MemRead(EX_MEM_MemRead),
		.clk(clk)
	);
		
	MEM_WB MEM_WB
	(
		// Outputs
		.RegWriteOut(MEM_WB_RegWrite),
		.MemtoRegOut(MEM_WB_MemtoReg),
		.ResultOut(MEM_WB_Result),
		.MemReadDataOut(MEM_WB_MemReadData),
		.MuxOut(MEM_WB_RdAddr),
		// Inputs
		.RegWrite(EX_MEM_RegWrite),
		.MemtoReg(EX_MEM_MemtoReg),
		.Result(EX_MEM_Result),
		.MemReadData(MemReadData),
		.MuxIn(EX_MEM_RdAddr),
		.clk(clk)
	);
	
	mux32_bits_DM mux32_bits_DM
	(
		// Outputs
		.RdData(RdData),
		// Inputs
		.MemReadData(MEM_WB_MemReadData),
		.ALU_output(MEM_WB_Result),
		.MemtoReg(MEM_WB_MemtoReg)
	);

endmodule
