/*
 *	Template for Project 3 Part 2
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
module I_PipelineCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);

	wire [31:0]Instr, RsData, RtData, RdData, MemReadData, Result, ALU_input;
	wire RegWrite, Carry, Zero, MemtoReg, RegDst, ALUSrc, MemWrite, MemRead;
	wire [5:0]Funct1;
	wire [1:0]ALUOp;
	wire [4:0]RtAddr, RdAddr;
	
	wire [31:0]InstrOut, RsDataOut, RtDataOut, ResultOut, ResultOut2, SignOut, RtDataOut2, MemReadDataOut;
	wire [5:0]FunctOut;
	wire [4:0]ShamtOut, RdAddrOut, RdAddrOut2, RdAddrOut3, RtAddrOut;
	wire RegDstOut, ALUSrcOut, MemWriteOut, MemReadOut, MemtoRegOut;
	wire RegWriteOut, RegWriteOut2, RegWriteOut3, MemWriteOut2, MemReadOut2, MemtoRegOut3;
	wire [1:0]ALUOpOut;
	
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
		.clk(clk)
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
		.RdAddr(RdAddrOut3),
		.RdData(RdData),
		.RegWrite(RegWriteOut3),
		.clk(clk)
	);
	
	ID_EX ID_EX
	(
		// Outputs
		.ALUOpOut(ALUOpOut),
		.RegWriteOut(RegWriteOut),
		.RegDstOut(RegDstOut),
		.ALUSrcOut(ALUSrcOut),
		.MemWriteOut(MemWriteOut),
		.MemReadOut(MemReadOut),
		.MemtoRegOut(MemtoRegOut),
		.RsDataOut(RsDataOut),
		.RtDataOut(RtDataOut),
		.SignOut(SignOut),
		.RtAddrOut(RtAddrOut),
		.RdAddrOut(RdAddrOut),
		// Inputs
		.ALUOp(ALUOp),
		.RegWrite(RegWrite),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.RsData(RsData),
		.RtData(RtData),
		.signextend(InstrOut[15:0]),
		.RtAddr(InstrOut[20:16]),
		.RdAddr(InstrOut[15:11]),
		.clk(clk)
	);
	
	ALU ALU
	(
		// Inputs
		.Src1(RsDataOut),
		.Src2(ALU_input),
		.Shamt(SignOut[10:6]),
		.Funct1(Funct1),
		// Outputs
		.Result(Result),
		.Zero(Zero),
		.Carry(Carry)
	);
	
	ALU_Control ALU_Control
	(
		// Inputs
		.funct(SignOut[5:0]),
		.ALUOp(ALUOpOut),
		// Outputs
		.Funct1(Funct1)
	);
	
	mux32_bits_ALU mux32_bits_ALU
	(
		// Outputs
		.ALU_input(ALU_input),
		// Inputs
		.RtData(RtDataOut),
		.signextend(SignOut),
		.ALUSrc(ALUSrc)
	);
	
	mux5_bits_RF mux5_bits_RF
	(
		// Outputs
		.RdAddr(RdAddr),
		// Inputs
		.Instr20_16(RtAddrOut),
		.Instr15_11(RdAddrOut),
		.RegDst(RegDst)
	);
	
	EX_MEM EX_MEM
	(
		// Outputs
		.RegWriteOut(RegWriteOut2),
		.MemtoRegOut(MemtoRegOut2),
		.MemWriteOut(MemWriteOut2),
		.MemReadOut(MemReadOut2),
		.ResultOut(ResultOut),
		.RtDataOut(RtDataOut2),
		.MuxOut(RdAddrOut2),
		// Inputs
		.RegWrite(RegWriteOut),
		.MemtoReg(MemtoRegOut),
		.MemWrite(MemWriteOut),
		.MemRead(MemReadOut),
		.Result(Result),
		.RtData(RtDataOut),
		.MuxIn(RdAddr),
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
		.MemAddr(ResultOut),
		.MemWriteData(RtDataOut2),
		.MemWrite(MemWriteOut2),
		.MemRead(MemReadOut2),
		.clk(clk)
	);
		
	MEM_WB MEM_WB
	(
		// Outputs
		.RegWriteOut(RegWriteOut3),
		.MemtoRegOut(MemtoRegOut3),
		.ResultOut(ResultOut2),
		.MemReadDataOut(MemReadDataOut),
		.MuxOut(RdAddrOut3),
		// Inputs
		.RegWrite(RegWriteOut2),
		.MemtoReg(MemtoRegOut2),
		.Result(ResultOut),
		.MemReadData(MemReadData),
		.MuxIn(RdAddrOut2),
		.clk(clk)
	);
	
	mux32_bits_DM mux32_bits_DM
	(
		// Outputs
		.RdData(RdData),
		// Inputs
		.MemReadData(MemReadDataOut),
		.ALU_output(ResultOut2),
		.MemtoReg(MemtoRegOut3)
	);

endmodule
