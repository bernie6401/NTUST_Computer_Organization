module MEM_WB(
	// Outputs
	output reg RegWriteOut, MemtoRegOut,
	output reg [31:0]ResultOut, MemReadDataOut,
	output reg [4:0]MuxOut,
	// Inputs
	input wire RegWrite, MemtoReg,
	input wire [31:0]Result, MemReadData,
	input wire [4:0]MuxIn,
	input wire clk
);

	always @ (posedge clk)
	begin
		RegWriteOut <= RegWrite;
		MemtoRegOut <= MemtoReg;
		
		ResultOut <= Result;
		MemReadDataOut <= MemReadData;
		MuxOut <= MuxIn;
	end
endmodule