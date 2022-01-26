module EX_MEM(
	// Outputs
	output reg RegWriteOut, MemtoRegOut, MemWriteOut, MemReadOut,
	output reg [31:0]ResultOut, RtDataOut,
	output reg [4:0]MuxOut,
	// Inputs
	input wire RegWrite, MemtoReg, MemWrite, MemRead,
	input wire [31:0]Result, RtData,
	input wire [4:0]MuxIn,
	input wire clk
);

	always @ (posedge clk)
	begin
		RegWriteOut <= RegWrite;
		MemtoRegOut <= MemtoReg;
		MemWriteOut <= MemWrite;
		MemReadOut <= MemRead;
		
		ResultOut <= Result;
		RtDataOut <= RtData;
		MuxOut <= MuxIn;
	end
endmodule