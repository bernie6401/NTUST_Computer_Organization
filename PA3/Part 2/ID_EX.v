module ID_EX(
	// Outputs
	output reg [1:0]ALUOpOut,
	output reg RegWriteOut, RegDstOut, ALUSrcOut, MemWriteOut, MemReadOut, MemtoRegOut,
	output reg [31:0]RsDataOut,RtDataOut,
	output reg [31:0]SignOut,
	output reg [4:0]RtAddrOut, RdAddrOut,
	// Inputs
	input wire [1:0]ALUOp,
	input wire clk, RegWrite, RegDst, ALUSrc, MemWrite, MemRead, MemtoReg,
	input wire [31:0]RsData,RtData,
	input wire [15:0]signextend,
	input wire [4:0]RtAddr, RdAddr
);

	
	always @ (posedge clk)
	begin
		RegWriteOut <= RegWrite;
		MemtoRegOut <= MemtoReg;
		MemWriteOut <= MemWrite;
		MemReadOut <= MemRead;
		RegDstOut <= RegDst;
		ALUOpOut <= ALUOp;
		ALUSrcOut <= ALUSrc;
		
		RsDataOut <= RsData;
		RtDataOut <= RtData;
		SignOut <= {0, signextend};
		RtAddrOut <= RtAddr;
		RdAddrOut <= RdAddr;
	end
endmodule