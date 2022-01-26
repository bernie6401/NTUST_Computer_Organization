/*
 *	Template for Project 3 Part 1
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
module R_PipelineCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);
	
	wire [31:0]Instr, RsData, RtData;
	wire RegWrite, Carry, Zero;
	wire [5:0]Funct1;
	wire [1:0]ALUOp;
	
	wire [31:0]InstrOut, RsDataOut, RtDataOut, Result, ResultOut, ResultOut2;
	wire [5:0]FunctOut;
	wire [4:0]ShamtOut, RdAddrOut, RdAddrOut2, RdAddrOut3;
	wire RegWriteOut, RegWriteOut2, RegWriteOut3;
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

	IF_ID IF_ID
	(
		// Outputs
		.InstrOut(InstrOut),
		// Inputs
		.InstrIn(Instr),
		.clk(clk)
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
		.RdData(ResultOut2),
		.RegWrite(RegWriteOut3),
		.clk(clk)
	);
	
	Control Control
	(
		// Inputs
		.OpCode(InstrOut[31:26]),
		// Outputs
		.RegWrite(RegWrite),
		.ALUOp(ALUOp)
	);
	
	ID_EX ID_EX
	(
		// Outputs
		.ALUOpOut(ALUOpOut),
		.RegWriteOut(RegWriteOut),
		.RsDataOut(RsDataOut),
		.RtDataOut(RtDataOut),
		.FunctOut(FunctOut),
		.ShamtOut(ShamtOut),
		.RdAddrOut(RdAddrOut),
		// Inputs
		.ALUOp(ALUOp),
		.RegWrite(RegWrite),
		.RsData(RsData),
		.RtData(RtData),
		.Funct(InstrOut[5:0]), 
		.Shamt(InstrOut[10:6]),
		.RdAddr(InstrOut[15:11]),
		.clk(clk)
	);
	
	ALU ALU
	(
		// Inputs
		.Src1(RsDataOut),
		.Src2(RtDataOut),
		.Shamt(ShamtOut),
		.Funct1(Funct1),
		// Outputs
		.Result(Result),
		.Zero(Zero),
		.Carry(Carry)
	);
	
	ALU_Control ALU_Control
	(
		// Inputs
		.funct(FunctOut),
		.ALUOp(ALUOpOut),
		// Outputs
		.Funct1(Funct1)
	);
	
	EX_MEM EX_MEM
	(
		// Outputs
		.RegWriteOut(RegWriteOut2),
		.ResultOut(ResultOut),
		.RdAddrOut(RdAddrOut2),
		// Inputs
		.RegWrite(RegWriteOut),
		.Result(Result),
		.RdAddr(RdAddrOut),
		.clk(clk)
	);
	
	MEM_WB MEM_WB
	(
		// Outputs
		.RegWriteOut(RegWriteOut3),
		.ResultOut(ResultOut2),
		.RdAddrOut(RdAddrOut3),
		// Inputs
		.RegWrite(RegWriteOut2),
		.Result(ResultOut),
		.RdAddr(RdAddrOut2),
		.clk(clk)
	);

	Adder Adder
	(	
		// Outputs
		.AddrOut(AddrOut),
		// Inputs
		.AddrIn(AddrIn)
	);
endmodule
